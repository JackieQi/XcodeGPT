//
//  XcodeGPTCodeSmellsRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class XcodeGPTCodeSmellsRepository: BaseXcodeGPTRepository, CodeSmellsRepository {
    func searchForCodeSmells(in code: String) async throws -> [Suggestion] {
        do {
            let chatService = try initializeChatService()
            let chatGPTResponse = try await chatService.codeSmellsFor(code: code)
            return try processChatResponse(chatGPTResponse)
        } catch let error {
            try handleChatError(error)
            return []
        }
    }
}

