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
        let chat = ChatService(modelConfig: modelConfig)
        return chat
    }
    
    func handleChatError(_ error: Error) throws {
        switch error {
        case ChatGPTError.rateLimitReached:
            throw ConverterError.rateLimit
        case ChatGPTError.serverError:
            throw ConverterError.serverError
        case ChatGPTError.authentication:
            throw ConverterError.authorization
        case ChatGPTError.tokenLimitReached:
            throw ConverterError.tokenLimit
        default:
            throw ConverterError.unknownResponse
        }
    }
    
    func processChatResponse(_ response: ChatGPTResponse) throws -> [Suggestion] {
        var suggestions: [Suggestion]?
        
        suggestions = response.choices.map { choice in
            let suggestion = Suggestion(result: choice.message.content)
            
            return suggestion
        }
        
        guard let unwrappedSuggestions = suggestions else {
            throw ConverterError.emptyResults
        }
        
        return unwrappedSuggestions
    }
}
