//
//  CodeRefactorCommand.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation
import XcodeKit

final class CodeRefactorCommand: NSObject, XCSourceEditorCommand {
    let useCase: RefactorCodeUseCase = DependencyManager.makeCodeRefactorDependencies()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        guard let codeLines = invocation.buffer.lines as? [String],
              let selections = invocation.buffer.selections as? [XCSourceTextRange],
              let xcodeSelection = selections.first
        else {
            completionHandler(nil)
            return
        }
        
        Task {
            do {
                let functionLines = extractSelectedTextFrom(selection: xcodeSelection, from: codeLines)
                let suggestion = try await self.useCase.refactor(function: functionLines)
                
                let insertedExplanation = "/**\n\(suggestion.result)\n*/"
                
                invocation.buffer.lines.add(insertedExplanation) // add to the end of the file
            } catch let error {
                print("🚨🚨🚨 [Chat] Error: \(error)")
            }
            
            completionHandler(nil)
        }
    }
    
    private func extractSelectedTextFrom(selection: XCSourceTextRange, from lines: [String]) -> [String] {
        let selectedLinesSlice = lines[selection.start.line..<selection.end.line]
        let selectedLines = Array<String>(selectedLinesSlice)
        
        return selectedLines
    }
}
