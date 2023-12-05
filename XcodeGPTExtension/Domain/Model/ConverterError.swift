//
//  ConverterError.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

enum ConverterError: Error {
    case emptyResults
    case authorization
    case rateLimit
    case tokenLimit
    case serverError
    case unknownResponse
}

