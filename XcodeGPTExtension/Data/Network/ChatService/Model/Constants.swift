//
//  Constants.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

enum Constants {
    static let chatEndPoint = "/v1/chat/completions"
    
    static let contentTypeHeaderKey = "Content-Type"
    static let contentTypeHeaderValue = "application/json"
    
    static let authorizationHeaderKey = "Authorization"
    static let authorizationHeaderValue = "Bearer"
    
    static let modelChatGPTUser = "user"
}

