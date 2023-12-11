//
//  XcodeGPTRegexRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class XcodeGPTRegexRepository: BaseXcodeGPTRepository, RegexRepository {
    func generateRegexFor(string value: String) async throws -> [Suggestion] {
        let chatService = try initializeChatService()
        
        do {
            let chatGPTResponse = try await chatService.generateRegexFor(string: value)
            return processChatResponse(chatGPTResponse)
        } catch let error {
            try handleChatError(error)
            return []
        }
    }
}

