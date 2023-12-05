//
//  URL+Extensions.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/30/23.
//

import Foundation

public extension URLRequest {
    // convert URLRequest to cURL format for BE to debug
    var curlString: String {
#if !DEBUG
        return ""
#else
        var result = "curl "
        
        if let method = httpMethod {
            result += "-X \(method) \\\n"
        }
        
        if let headers = allHTTPHeaderFields {
            for (header, value) in headers {
                result += "-H \"\(header): \(value)\" \\\n"
            }
        }
        
        if let body = httpBody, !body.isEmpty, let string = String(data: body, encoding: .utf8), !string.isEmpty {
            result += "-d '\(string)' \\\n"
        }
        
        if let url = url {
            result += "'\(url.absoluteString)'"
        }
        
        return result
#endif
    }
}
