//
//  CodeSmellsEditorCommand.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation
import XcodeKit

final class CodeSmellsEditorCommand: NSObject, XCSourceEditorCommand {
    let useCase: CodeSmellsUseCase = DependencyManager.makeCodeSmellsDependencies()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        guard let codeLines = invocation.buffer.lines as? [String] else {
            completionHandler(nil)
            return
        }
        
        // Retrieve the selected lines
        let selectedLines = getSelectedLines(from: invocation)
        
        let codeToCheck: [String]
        
        // use user selected lines or whole file
        if !selectedLines.isEmpty && selectedLines.first != "" {
            codeToCheck = selectedLines
        } else {
            codeToCheck = codeLines
        }
        
        Task {
            do {
                let suggestion = try await self.useCase.searchForCodeSmells(in: codeToCheck)
                
                let insertedSuggestion = "/**\n\(suggestion.result)\n*/"
                
                invocation.buffer.lines.add(insertedSuggestion)
            } catch let error {
                print("🚨🚨🚨 [Chat] Error: \(error)")
            }
            
            completionHandler(nil)
        }
    }
    
    
}

