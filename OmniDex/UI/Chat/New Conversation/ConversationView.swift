//
//  ChatView.swift
//  OmniAI
//
//  Created by Clay Suttner on 2/14/24.
//

import SwiftUI
import SwiftData

struct ConversationView: View {
    @Environment(StoreProvider.self) private var storeProvider
    @Environment(ServiceProvider.self) private var serviceProvider
    @Environment(Conversation.self) private var conversation
    
    @State private var prompt = ""
    @State private var image: UIImage?
    @State private var alertItem = AlertItem()
    @State private var newMessage: Message?
    
    @FocusState private var textFocused: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            MessageListView()

            ConversationInputBar(
                text: $prompt,
                selectedImage: $image,
                textFocused: $textFocused
            ) {
                newMessage = Message(
                    text: prompt,
                    image: image?.base64String
                )
            }
        }
        .task(id: newMessage) {
            guard let newMessage else {
                return
            }
            
            await send(newMessage: newMessage)
            await fetchSummary()
            await saveConversation()
        }
        .alert(item: $alertItem)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle(conversation.summary ?? "New Conversation")
        .navigationBarTitleDisplayMode(.inline)
        .contentShape(.rect)
        .onTapGesture {
            textFocused = false
        }
    }

    private func send(newMessage: Message) async {
        let history = conversation.messages

        prompt = ""
        image = nil
        conversation.messages.append(newMessage)
        conversation.messages.append(Message(isUser: false, isLoading: true))

        do {
            let stream = try await serviceProvider.chatService
                .streamChatCompletion(
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
            conversation.messages[index].date = Date()

        } else {
            conversation.messages.removeAll { $0.isLoading }
            conversation.messages.append(chunk.message)
        }
    }

    private func handle(error: Error, newMessage: Message) {
        conversation.messages.removeAll { $0.isLoading }
        conversation.messages.removeAll { $0 == newMessage }
        alertItem = AlertItem(error: error)
        prompt = newMessage.text
        image = UIImage.fromBase64(newMessage.image)
    }
    
    private func fetchSummary() async {
        guard conversation.summary == nil else {
            return
        }
        
        let summaryMessage = try? await serviceProvider.chatService
            .fetchChatCompletion(
                text: Constants.Prompts.summary(wordCount: 4),
                image: nil,
                history: conversation.messages
            )
        
        conversation.summary = summaryMessage?.text
    }
    
    private func saveConversation() async {
        do {
            try await storeProvider.conversationStore
                .save(conversation: conversation)
        } catch {
            print(error)
        }
    }
}

#Preview {
    ConversationView()
        .environment(Mock.conversation)
        .environment(Mock.serviceProvider)
        .environment(Mock.storeProvider)
}

