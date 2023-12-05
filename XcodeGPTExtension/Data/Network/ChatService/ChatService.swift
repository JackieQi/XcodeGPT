//
//  ChatService.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation
import OSLog

final public class ChatService {
    private var commonHeaders: [String : String]
    private let modelConfig: LanguageModelConfig
    
    init(modelConfig: LanguageModelConfig) {
        self.commonHeaders = [
            Constants.contentTypeHeaderKey: Constants.contentTypeHeaderValue
        ]
        
        self.modelConfig = modelConfig
        
        switch modelConfig.serverType {
        case .OpenAI: // setup API key for openAI
            self.commonHeaders[Constants.authorizationHeaderKey] 
            = "\(Constants.authorizationHeaderValue) \(modelConfig.apiKey ?? "")"
        case .LMStudio:
            Logger.process.info("[LM Studio] selected")
        case .WebUI:
            Logger.process.info("[Text Generation Web UI] selected")
        }
    }
    
    internal func processRequestFor(prompt: String) async throws -> ChatGPTResponse {
        Logger.process.info("[PROMPT] \(prompt)")
        
        let chatGRTRequest = ChatGPTRequestBody(prompt: prompt, modelConfig: modelConfig)
        let data = try? JSONEncoder().encode(chatGRTRequest)
        
        let request = NetworkRequest(httpHeaders: commonHeaders, body: data)
        let baseURLString = modelConfig.serverURL.absoluteString
        let fullURLString = baseURLString.appending(Constants.chatEndPoint)
        
        guard let chatServiceURLRequest = request.makeURLRequest(for: fullURLString) else {
            throw ChatGPTError.malformedURL(value: fullURLString)
        }
        
        let requestWrapper = LoggableWrapper<URLRequest>(item: chatServiceURLRequest)
        Logger.process.debug("[Request]: \(requestWrapper.item?.curlString ?? "")")
        
        guard let (data, response) = try? await URLSession.shared.data(for: chatServiceURLRequest),
              let httpResponse = response as? HTTPURLResponse else {
            throw ChatGPTError.unknownServerResponse
        }
        
        let responseWrapper = LoggableWrapper<HTTPURLResponse>(item: httpResponse)
        Logger.process.debug("[Response]: \(responseWrapper)")
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            let jsonResponse = "\(json ?? [:])"
            Logger.process.debug("[Response Data] \(jsonResponse)")
        } catch {
            let responseString = String(decoding: data, as: UTF8.self)
            Logger.process.debug("[Response Data] \(responseString)")
        }
        
        switch httpResponse.statusCode {
        case 400:
            throw ChatGPTError.tokenLimitReached
            /*
             ["error": {
                code = "context_length_exceeded";
                message = "This model's maximum context length is 4097 tokens. However, your messages resulted in 4101 tokens. Please reduce the length of the messages.";
                param = messages;
                type = "invalid_request_error";
             }]
             */
        case 401:
            throw ChatGPTError.authentication
        case 429:
            throw ChatGPTError.rateLimitReached
        case 500:
            throw ChatGPTError.serverError
        case 200:
            let chatGPTResponse = try self.processResponse(data: data)
            return chatGPTResponse
        default:
            let responseObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            let description = "\(String(describing: responseObject))"
            Logger.process.debug("\(description)")
            
            throw ChatGPTError.unknownServerResponse
        }
    }
    
    private func processResponse(data: Data) throws -> ChatGPTResponse {
        let jsonDecoder = JSONDecoder()
        
        do {
            let chatGPTResponse = try jsonDecoder.decode(ChatGPTResponse.self, from: data)
            return chatGPTResponse
        } catch {
            throw ChatGPTError.malformedResponse
        }
    }
}

