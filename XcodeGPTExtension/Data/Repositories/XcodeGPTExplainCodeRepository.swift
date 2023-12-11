//
//  XcodeGPTExplainCodeRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class XcodeGPTExplainCodeRepository: BaseXcodeGPTRepository, ExplainCodeRepository {
    func explainMeThis(code: String) async throws -> [Suggestion] {
        let chatService = try initializeChatService()
        
        do {
            let chatGPTResponse = try await chatService.explain(source: code)
            
            return processChatResponse(chatGPTResponse)
        }  catch let error {
            try handleChatError(error)
            return []
        }
    }
}

