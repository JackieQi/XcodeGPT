//
//  XcodeGPTUnitTestRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class XcodeGPTUnitTestRepository: BaseXcodeGPTRepository, UnitTestRepository {
    func generateTestsFor(source code: String) async throws -> [Suggestion] {
        do {
            let chatService = try initializeChatService()
            let chatGPTResponse = try await chatService.generateTestsFor(source: code)
            return try processChatResponse(chatGPTResponse)
        }  catch let error {
            try handleChatError(error)
            return []
        }
    }
}
