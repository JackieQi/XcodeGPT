//
//  String+Extensions.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 12/1/23.
//

import Foundation

public extension String {
    var boolean: Bool? {
        switch self.lowercased() {
        case "true":
            return true
        case "false":
            return false
        default:
            return nil
        }
    }
}
