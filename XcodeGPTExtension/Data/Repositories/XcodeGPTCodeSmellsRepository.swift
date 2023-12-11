//
//  XcodeGPTCodeSmellsRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class XcodeGPTCodeSmellsRepository: BaseXcodeGPTRepository, CodeSmellsRepository {
    func searchForCodeSmells(in code: String) async throws -> [Suggestion] {
        let chatService = try initializeChatService()
        
        do {
            let chatGPTResponse = try await chatService.codeSmellsFor(code: code)
            return processChatResponse(chatGPTResponse)
        } catch let error {
            throw handleChatError(error)
        }
    }
}

