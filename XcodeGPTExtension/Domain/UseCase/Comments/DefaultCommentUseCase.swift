//
//  DefaultCommentUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class DefaultCommentUseCase: CommentUseCase {
    private let repository: CommentRepository
    
    init(repository: CommentRepository) {
        self.repository = repository
    }
    
    func comment(function code: [String]) async throws -> Suggestion {
        let preparedCode = code.joined()
        
        let suggestions = try await self.repository.comment(function: preparedCode)
        
        guard let suggestion = suggestions.first else {
            throw ConverterError.emptyResults
        }
        
        return suggestion
    }
}

