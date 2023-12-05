//
//  Localizable.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation


func localizedPrompt(_ key: String) -> String {
    let resourceBundle = Bundle(for: ChatService.self)
    
    return NSLocalizedString(key, bundle: resourceBundle, comment: "")
}
