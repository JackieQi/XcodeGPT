//
//  ChatGPTRequestBody.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

struct ChatGPTRequestBody: Encodable {
    var model: String?
    var mode: LLMChatMode
    let messages: [ChatGPTRequestBody.Message]
    
    init(prompt: String, modelConfig: LanguageModelConfig) {
        let message = ChatGPTRequestBody.Message(role: .user, content: prompt)
        let systemMessage = ChatGPTRequestBody.Message(role: .system, content: localizedPrompt("LLM_SYSTEM_PROMPT"))
        self.messages = [
            message,
            systemMessage
        ]
        
        self.model = modelConfig.modelName
        self.mode = modelConfig.chatMode
    }
}

extension ChatGPTRequestBody {
    struct Message: Encodable {
        let role: LLMUserType
        let content: String
    }
}

