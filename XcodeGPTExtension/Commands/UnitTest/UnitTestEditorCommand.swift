//
//  UnitTestEditorCommand.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation
import XcodeKit

final class UnitTestEditorCommand: NSObject, XCSourceEditorCommand {
    let useCase: UnitTestUseCase = DependencyManager.makeUnitTestsDependencies()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        guard let codeLines = invocation.buffer.lines as? [String] else {
            completionHandler(nil)
            return
        }
        
        Task {
            do {
                let suggestion = try await self.useCase.generateTestsFor(source: codeLines)
                
                let insertedExplanation = "/**\n\(suggestion.result)\n*/"
                
                invocation.buffer.lines.add(insertedExplanation)
            } catch let error {
                print("🚨🚨🚨 [Chat] Error: \(error)")
            }
            
            completionHandler(nil)
        }
    }
}

