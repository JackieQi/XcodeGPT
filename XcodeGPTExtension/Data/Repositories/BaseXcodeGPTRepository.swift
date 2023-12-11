//
//  BaseXcodeGPTRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

class BaseXcodeGPTRepository {
    func initializeChatService() throws -> ChatService {
        let modelConfig = LanguageModelConfigBuilder.makeLanguageModelConfig()
        return ChatService(modelConfig: modelConfig)
    }
    
    func handleChatError(_ error: Error) -> ConverterError {
        switch error {
        case ChatGPTError.rateLimitReached:
            return ConverterError.rateLimit
        case ChatGPTError.serverError:
            return ConverterError.serverError
        case ChatGPTError.authentication:
            return ConverterError.authorization
        case ChatGPTError.tokenLimitReached:
            return ConverterError.tokenLimit
        default:
            return ConverterError.unknownResponse
        }
    }
    
    func processChatResponse(_ response: ChatGPTResponse) -> [Suggestion] {
        return response.choices.map { Suggestion(result: $0.message.content) }
    }
}
