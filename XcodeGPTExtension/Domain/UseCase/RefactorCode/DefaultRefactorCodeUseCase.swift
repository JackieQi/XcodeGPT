//
//  DefaultRefactorCodeUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class DefaultRefactorCodeUseCase: RefactorCodeUseCase {
    private let repository: RefactorCodeRepository
    
    init(repository: RefactorCodeRepository) {
        self.repository = repository
    }
    
    func refactor(function code: [String]) async throws -> Suggestion {
        let preparedCode = code.reduce("") { $0 + $1 }
        
        let suggestions = try await self.repository.refactor(code: preparedCode)
        
        guard let suggestion = suggestions.first else {
            throw ConverterError.emptyResults
        }
        
        return suggestion
    }
}
