//
//  SourceEditorExtension.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation
import OSLog
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
        Logger.process.debug("[Chat GPT Extension] Ready")
    }
    
    
//    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
//        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
//        return [
//            [
//                .classNameKey : "SourceEditorCommand",
//                .identifierKey : "SourceEditorCommand",
//                .nameKey : "XcodeGPT"
//            ]
//        ]
//    }
     
}

