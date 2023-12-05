//
//  ChatService+Operations.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

extension ChatService {
    func codeRefactorFor(code: String) async throws -> ChatGPTResponse {
        let refactorPrompt = "\(localizedPrompt("PROMPT_CODE_REFACTOR")):\n \(code)"
        
        return try await processRequestFor(prompt: refactorPrompt)
    }
    
    func codeSmellsFor(code: String) async throws -> ChatGPTResponse {
        let smellsPrompt = "\(localizedPrompt("PROMPT_CODE_SMELLS")):\n \(code)"
        
        return try await processRequestFor(prompt: smellsPrompt)
    }
    
    func convertToJSON(source code: String) async throws -> ChatGPTResponse {
        let jsonPrompt = "\(localizedPrompt("PROMPT_JSON")):\n \(code)"
        
        return try await processRequestFor(prompt: jsonPrompt)
    }
    
    func explain(source code: String) async throws -> ChatGPTResponse {
        let explainPrompt = "\(localizedPrompt("PROMPT_EXPLAIN_CODE")):\n \(code)"
        
        return try await processRequestFor(prompt: explainPrompt)
    }
    
    func generateTestsFor(source code: String) async throws -> ChatGPTResponse {
        let testsPrompt = "\(localizedPrompt("PROMPT_GENERATE_UNIT_TEST")):\n \(code)"
        
        return try await processRequestFor(prompt: testsPrompt)
    }
    
    func generateRegexFor(string value: String) async throws -> ChatGPTResponse {
        let regexPrompt = "\(localizedPrompt("PROMPT_REGEX")):\n \(value)"
        
        return try await processRequestFor(prompt: regexPrompt)
    }
    
    func comment(function code: String) async throws -> ChatGPTResponse {
        let commentPrompt = String(format: localizedPrompt("PROMPT_COMMENT"), code)
        
        return try await processRequestFor(prompt: commentPrompt)
    }
}

