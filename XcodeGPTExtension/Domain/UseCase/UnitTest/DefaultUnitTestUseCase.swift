//
//  DefaultUnitTestUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class DefaultUnitTestUseCase: UnitTestUseCase {
    private let repository: UnitTestRepository
    
    init(repository: UnitTestRepository) {
        self.repository = repository
    }
    
    func generateTestsFor(source code: [String]) async throws -> Suggestion {
        let lines = code.reduce("") { $0 + $1 }
        
        let suggestions = try await self.repository.generateTestsFor(source: lines)
        
        guard let suggestion = suggestions.first else {
            throw ConverterError.emptyResults
        }
        
        return suggestion
    }
}

