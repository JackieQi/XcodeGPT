//
//  Data+Extensions.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 12/8/23.
//

import Foundation
import OSLog

public extension Data {
    func toJSONString(prettyPrinted: Bool = true) -> String? {
        let options: JSONSerialization.WritingOptions = prettyPrinted ? .prettyPrinted : []
        do {
            let object = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: object, options: options)
            return String(data: data, encoding: .utf8)
        } catch {
            let stringData = String(data: self, encoding: .utf8)
            let description = "❌❌❌ [Error] converting Data to JSON String: \(error.localizedDescription)" +
                            " \nData(in String): \(stringData ?? "")"
            
            Logger.process.debug("\(description)")
            return nil
        }
    }
}
