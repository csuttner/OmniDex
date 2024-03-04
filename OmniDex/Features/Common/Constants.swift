//
//  Constants.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

enum Constants {
    enum Tabs {
        static let chat = "Chat"
        static let translate = "Translate"
        static let imagine = "Imagine"
        static let summarize = "Summarize"
    }
    
    enum Error {
        static let error = "Error"
        static let noMessage = "No message was found in the response"
    }
    
    enum Common {
        static let new = "New"
    }

    enum Color {
        static let interactive = "Mint"
    }

    enum Chat {
        static let conversations = "Conversations"
        static let message = "Message"
        static let library = "Library"
        static let camera = "Camera"
        static let noSummary = "No summary"
    }
    
    enum Prompts {
        static func summary(wordCount: Int) -> String {
            "Summarize this conversation's topic in \(wordCount) words"
        }
    }
}
