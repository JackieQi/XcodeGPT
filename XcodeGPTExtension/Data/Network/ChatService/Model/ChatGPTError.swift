//
//  ChatGPTError.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

enum ChatGPTError: Error {
    case malformedURL(value: String)
    case authentication
    case rateLimitReached
    case serverError
    case tokenLimitReached
    case unknownServerResponse
    case malformedResponse
}

