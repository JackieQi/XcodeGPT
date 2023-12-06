//
//  LanguageModelConfig.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 12/1/23.
//

import Foundation

public enum SupportedChatServer {
    case OpenAI
    case LMStudio
    case WebUI
}

public enum LLMChatMode: String, Encodable {
    case chat
    case instruct
}

public enum LLMUserType: String, Encodable {
    case user
    case system
    case assistant
}

public struct LanguageModelConfig {
    var apiKey: String?
    var modelName: String? // NOTE: Only OpenAI is using it right now
    var serverURL: URL
    var chatMode: LLMChatMode?
    let serverType: SupportedChatServer
    
    init(apiKey: String? = nil, 
         modelName: String? = nil,
         chatMode: LLMChatMode? = nil,
         serverURL: URL,
         serverType: SupportedChatServer) {
        self.apiKey = apiKey
        self.modelName = modelName
        self.chatMode = chatMode
        self.serverURL = serverURL
        self.serverType = serverType
    }
}
