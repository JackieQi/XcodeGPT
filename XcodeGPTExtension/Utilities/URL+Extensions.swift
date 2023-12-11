//
//  URL+Extensions.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/30/23.
//

import Foundation

public extension URLRequest {
    // convert URLRequest to cURL format
    var curlString: String {
        guard let url = url else { return "" }
        
        var result = "curl -X \(httpMethod ?? "GET") \\\n"
        
        let headerStrings = allHTTPHeaderFields?.map { "-H \"\($0.key): \($0.value)\" \\\n" } ?? []
        result += headerStrings.joined()
        
        if let body = httpBody, !body.isEmpty {
            if let jsonString = body.toJSONString() {
                result += "-d '\(jsonString)' \\\n"
            } else {
                let bodyString = String(data: body, encoding: .utf8) ?? ""
                result += "-d '\(bodyString)' \\\n"
            }
        }
        
        result += "'\(url.absoluteString)'"
        return result
    }
}
