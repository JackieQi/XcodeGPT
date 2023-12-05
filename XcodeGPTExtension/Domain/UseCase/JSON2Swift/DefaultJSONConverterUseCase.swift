//
//  DefaultJSONConverterUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class DefaultJSONConverterUseCase: JSONConverterUseCase {
    let repository: JSONConverterRepository
    
    init(repository: JSONConverterRepository) {
        self.repository = repository
    }
    
    func convertToJSON(source code: [String]) async throws -> Suggestion {
        let preparedCode = code.reduce("") { $0 + $1 }
        
        let suggestions = try await self.repository.convertToJSON(code: preparedCode)
        
        guard let suggestion = suggestions.first else {
            throw ConverterError.emptyResults
        }
        
        return suggestion
    }
}

