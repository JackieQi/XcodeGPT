//
//  XcodeGPTUnitTestRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class XcodeGPTUnitTestRepository: BaseXcodeGPTRepository, UnitTestRepository {
    func generateTestsFor(source code: String) async throws -> [Suggestion] {
        let chatService = try initializeChatService()
        
        do {
            let chatGPTResponse = try await chatService.generateTestsFor(source: code)
            return processChatResponse(chatGPTResponse)
        }  catch let error {
            throw handleChatError(error)
        }
    }
}
