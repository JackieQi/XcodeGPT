//
//  XcodeGPTCommentRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class XcodeGPTCommentRepository: BaseXcodeGPTRepository, CommentRepository {
    func comment(function code: String) async throws -> [Suggestion] {
        do {
            let chatService = try initializeChatService()
            let chatGPTResponse = try await chatService.comment(function: code)
            return processChatResponse(chatGPTResponse)
        } catch let error {
            throw handleChatError(error)
        }
    }
}

