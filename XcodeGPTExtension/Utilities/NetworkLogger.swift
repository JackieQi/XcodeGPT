//
//  NetworkLogger.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/30/23.
//

import Foundation
import OSLog

public protocol LoggableItem {
    var trackableDescription: String { get }
}

public final class LoggableWrapper<T: LoggableItem>: NSObject {
    public var item: T?
    
    public init(item: T?) {
        self.item = item
    }
    
    public override var description: String {
        if let item = item {
            return item.trackableDescription
        } else {
            return ""
        }
    }
}

extension String: LoggableItem {
    public var trackableDescription: String {
        self
    }
}

extension URLRequest: LoggableItem {
    func getQueryParameters(url: String?) -> [String: String]? {
        if let url = url, let urlComponents = URLComponents(string: url), let queryItems = urlComponents.queryItems {
            var parameters = [String: String]()
            for item in queryItems {
                parameters[item.name] = item.value ?? ""
            }
            return parameters
        }
        return nil
    }
    
    public var trackableDescription: String {
        var requestBody: Any?
        if let bodyData = httpBody {
            requestBody = try? JSONSerialization.jsonObject(with: bodyData, options: .mutableContainers)
        } else {
            requestBody = ""
        }
        
        var requestHeader: Any?
        if let headers = allHTTPHeaderFields {
            if let headerData = try? JSONSerialization.data(withJSONObject: headers) {
                requestHeader = try? JSONSerialization.jsonObject(with: headerData, options: .mutableContainers)
            } else {
                requestHeader = allHTTPHeaderFields
            }
        } else {
            requestHeader = ""
        }
        
        var queryParameters: Any?
        if let queryItems = getQueryParameters(url: self.url?.absoluteString) {
            if let queryData = try? JSONSerialization.data(withJSONObject: queryItems) {
                queryParameters = try? JSONSerialization.jsonObject(with: queryData, options: .mutableContainers)
            } else {
                queryParameters = queryItems
            }
        } else {
            queryParameters = ""
        }
        
        let url = self.url ?? URL(fileURLWithPath: "")
        
        let method = httpMethod ?? ""
        
        var detailDic: [String: Any] = ["url": "\(url)",
                                        "method": "\(method)",
                                        "header": requestHeader as Any,
                                        "query_parameter": queryParameters as Any]
        if method == "POST" || method == "PUT" {
            detailDic["body"] = requestBody as Any
        }
        
        let descriptionDic: [String: Any] = ["Request": detailDic]
        
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: descriptionDic),
                let result = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            Logger.process.debug("Can't parse the request")
            return ""
        }
        return "\(result))"
    }
}

extension HTTPURLResponse: LoggableItem {
    public var trackableDescription: String {
        let url = self.url ?? URL(fileURLWithPath: "")
        let responseString = HTTPURLResponse.localizedString(forStatusCode: statusCode)
        
        let descriptionDic: [String: Any] = ["Response": ["status_code": "\(statusCode)",
                                                          "url": "\(url)",
                                                          "response_string": "\(responseString)"]]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: descriptionDic),
              let result = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) else {
            Logger.process.error("The data didn't serialize. Sigh. At least we tried.")
            return ""
        }
        return "\(result))"
    }
}
