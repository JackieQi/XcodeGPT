//
//  ExplainCodeCommand.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation
import XcodeKit

final class ExplainCodeCommand: NSObject, XCSourceEditorCommand {
    let useCase: ExplainCodeUseCase = DependencyManager.makeExplainCodeDependencies()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        Task {
            let fileSourceCode = invocation.buffer.completeBuffer
            
            // Retrieve the selected lines
            let selectedLines = getSelectedLines(from: invocation)
            
            let codeToCheck: String
            
            // use user selected lines or whole file
            if !selectedLines.isEmpty && selectedLines.first != "" {
                codeToCheck = selectedLines.joined()
            } else {
                codeToCheck = fileSourceCode
            }
            
            print("code to check: \(codeToCheck)")
            
            do {
                let suggestion = try await self.useCase.explainMeThis(code: codeToCheck)
                
                let insertedExplanation = "/**\n\(suggestion.result)\n*/"
                
                invocation.buffer.lines.add(insertedExplanation)
            } catch let error {
                print("🚨🚨🚨 [Chat] Error: \(error)")
            }
            
            completionHandler(nil)
        }
    }
}

