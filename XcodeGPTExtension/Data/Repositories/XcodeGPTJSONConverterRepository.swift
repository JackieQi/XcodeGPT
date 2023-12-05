//
//  XcodeGPTJSONConverterRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class XcodeGPTJSONConverterRepository: BaseXcodeGPTRepository, JSONConverterRepository {
    func convertToJSON(code: String) async throws -> [Suggestion] {
        do {
            let chatService = try initializeChatService()
            let chatGPTResponse = try await chatService.convertToJSON(source: code)
            return try processChatResponse(chatGPTResponse)
        } catch let error {
            try handleChatError(error)
            return []
        }
    }
}

