//
//  Tab.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/12/24.
//

import Foundation

enum Tab: Int, CaseIterable, Identifiable {
    case chat, translate, imagine, summarize
    
    var id: Int {
        rawValue
    }
    
    var systemImage: String {
        switch self {
        case .chat:
            "ellipsis.message"
        case .translate:
            "arrow.left.arrow.right"
        case .imagine:
            "wand.and.stars"
        case .summarize:
            "sum"
        }
    }
    
    var title: String {
        switch self {
        case .chat:
            Constants.Tabs.chat
        case .translate:
            Constants.Tabs.translate
        case .imagine:
            Constants.Tabs.imagine
        case .summarize:
            Constants.Tabs.summarize
        }
    }
}
