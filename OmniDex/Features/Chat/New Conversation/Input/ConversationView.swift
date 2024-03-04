//
//  ChatView.swift
//  OmniAI
//
//  Created by Clay Suttner on 2/14/24.
//

import SwiftUI
import SwiftData

struct ConversationView: View {
    let chatService = ServiceProvider.openAiChatService
    let dataStore: SwiftDataStore?
    
    @Environment(Conversation.self) private var conversation
    
    @State private var prompt = ""
    @State private var image: UIImage?
    @State private var errorItem: ErrorItem?
    @State private var newMessage: Message?

    var body: some View {
        ZStack(alignment: .bottom) {
            ConversationScrollView()

            ConversationInputBar(
                text: $prompt,
                selectedImage: $image
            ) {
                newMessage = Message(
                    text: prompt,
                    image: image?.base64String
                )
            }
        }
        .alert(item: $errorItem) { errorItem in
            Alert(
                title: Text(errorItem.title),
                message: Text(errorItem.message),
                dismissButton: .default(Text("OK")) {
                    self.errorItem = nil
                }
            )
        }
        .task(id: newMessage) {
            guard let newMessage else {
                return
            }
            
            await send(newMessage: newMessage)
            await fetchSummary()
            await saveConversation()
        }
        .navigationTitle(conversation.summary.isEmpty ? "New Conversation" : conversation.summary)
        .navigationBarTitleDisplayMode(.inline)
    }

    func send(newMessage: Message) async {
        let history = conversation.messages

        prompt = ""
        image = nil
        conversation.messages.append(newMessage)
        conversation.messages.append(Message(isUser: false, isLoading: true))

        do {
            let stream = try await chatService.streamChatCompletion(
                text: newMessage.text,
                image: newMessage.image,
                history: history
            )
            
            for try await chunk in stream {
                updateMessage(with: chunk)
            }

            conversation.updated = Date()
            
        } catch {
            handle(error: error, newMessage: newMessage)
        }
    }

    private func updateMessage(with chunk: MessageChunk) {
        if let index = conversation.messages
            .firstIndex(where: { $0.id == chunk.id }) {
            conversation.messages[index].text.append(chunk.text)

        } else {
            conversation.messages.removeAll { $0.isLoading }
            conversation.messages.append(chunk.message)
        }
    }

    private func handle(error: Error, newMessage: Message) {
        conversation.messages.removeAll { $0.isLoading }
        conversation.messages.removeAll { $0 == newMessage }
        errorItem = ErrorItem(error: error)
        prompt = newMessage.text
        image = UIImage.fromBase64(newMessage.image)
    }
    
    func fetchSummary() async {
        guard conversation.summary.isEmpty else {
            return
        }
        
        let summaryMessage = try? await chatService.fetchChatCompletion(
            text: Constants.Prompts.summary(wordCount: 4),
            image: nil,
            history: conversation.messages
        )
        
        conversation.summary = summaryMessage?.text ?? Constants.Chat.noSummary
    }
    
    private func saveConversation() async {
        guard !conversation.messages.isEmpty else {
            return
        }
        
        do {
            try await dataStore?.store(item: StoredConversation(conversation: conversation))

        } catch {
            print(error)
        }
    }
}

#Preview {
    ConversationView(dataStore: nil)
        .environment(Preview.conversation)
}
