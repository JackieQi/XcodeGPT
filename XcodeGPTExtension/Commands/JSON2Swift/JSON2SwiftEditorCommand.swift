//
//  SourceEditorCommand.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation
import XcodeKit

class JSON2SwiftEditorCommand: NSObject, XCSourceEditorCommand {
    let useCase: JSONConverterUseCase = DependencyManager.makeJSONConverterDependencies()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        guard let codeLines = invocation.buffer.lines as? [String] else {
            completionHandler(nil)
            return
        }
        
        Task {
            do {
                let suggestion = try await self.useCase.convertToJSON(source: codeLines)
                
                invocation.buffer.selections.removeAllObjects()
                invocation.buffer.selections.add(suggestion.result)
            } catch let error {
                print("🚨🚨🚨 [Chat] Error: \(error)")
            }
            
            completionHandler(nil)
        }
    }
    
}

