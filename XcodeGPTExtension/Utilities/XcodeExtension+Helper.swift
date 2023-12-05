//
//  XcodeExtension+Helper.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 12/5/23.
//

import Foundation
import XcodeKit

func getSelectedLines(from invocation: XCSourceEditorCommandInvocation) -> [String] {
    let buffer = invocation.buffer
    var selectedTextLines: [String] = []
    
    // Loop through each selection range in the buffer
    if let selections = buffer.selections as? [XCSourceTextRange] {
        // if user just put the cursor at the end of line, treat this as whole file selection
        
        for selection in selections {
            
            let startLine = selection.start.line
            let startColumn = selection.start.column
            let endLine = selection.end.line
            let endColumn = selection.end.column
            
            if startLine == endLine { // If the selection is within a single line
                // If select the bottom line at the end of the file, then return empty lines
                if startLine >= buffer.lines.count {
                    return []
                }
                if let line = buffer.lines[startLine] as? String {
                    let startIndex = line.index(line.startIndex, offsetBy: startColumn, limitedBy: line.endIndex) ?? line.endIndex
                    let endIndex = line.index(line.startIndex, offsetBy: endColumn, limitedBy: line.endIndex) ?? line.endIndex
                    selectedTextLines.append(String(line[startIndex..<endIndex]))
                }
            } else {
                // The selection spans multiple lines
                for lineIndex in startLine...endLine {
                    if let line = buffer.lines[lineIndex] as? String {
                        if lineIndex == startLine {
                            let startIndex = line.index(line.startIndex, offsetBy: startColumn, limitedBy: line.endIndex) ?? line.endIndex
                            selectedTextLines.append(String(line[startIndex...]))
                        } else if lineIndex == endLine {
                            let endIndex = line.index(line.startIndex, offsetBy: endColumn, limitedBy: line.endIndex) ?? line.endIndex
                            // Add a check to avoid adding a newline if the selection is at the start of the line
                            if endIndex > line.startIndex {
                                selectedTextLines.append(String(line[..<endIndex]))
                            }
                        } else {
                            selectedTextLines.append(line)
                        }
                        // Only add a newline if it's not the last line of the selection
                        if lineIndex < endLine {
                            selectedTextLines.append("\n")
                        }
                    }
                }
            }
        }
    }
    
    return selectedTextLines
    }
