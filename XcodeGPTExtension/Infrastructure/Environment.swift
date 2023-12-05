//
//  Environment.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/29/23.
//

import Foundation
import OSLog

public enum Environment {
    
    private enum Keys: String {
        case webServerURL = "WEB_SERVER_URL"
        case openAIKey = "OPENAI_API_KEY"
        case flagLMStudio = "FLAG_LM_STUDIO"
        case flagWEBUI = "FLAG_TEXT_WEB_UI"
        case modelName = "LLM_MODEL_NAME"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError(".plist file not found")
        }
        
        return dict
    }()
    
    static var apiKey: String? = {
        guard let apiKeyString = Environment.infoDictionary[Keys.openAIKey.rawValue] as? String else {
            return nil
        }
        
        Logger.process.info("[API Key] \(apiKeyString)")
        return apiKeyString
    }()
    
    static let useLMStudio: Bool = {
        guard let lmStudio = Environment.infoDictionary[Keys.flagLMStudio.rawValue] as? String else {
            return false
        }
        
        return lmStudio.boolean ?? false
    }()
    
    static let useTextUI: Bool = {
        guard let webUI = Environment.infoDictionary[Keys.flagWEBUI.rawValue] as? String else {
            return false
        }
        
        return webUI.boolean ?? false
    }()
    
    static var modelName: String? = {
        guard let modelnNameString = Environment.infoDictionary[Keys.modelName.rawValue] as? String else {
            return nil
        }
        
        Logger.process.info("[Model Name] \(modelnNameString)")
        return modelnNameString
    }()
    
    static var webServerURL: URL? = {
        guard let webServerURLString = Environment.infoDictionary[Keys.webServerURL.rawValue] as? String,
                let url = URL(string: webServerURLString) else {
            return nil
        }
        
        Logger.process.info("[Server URL] \(webServerURLString)")
        return url
    }()
    
    static var useLocalLLM: Bool {
        return useLMStudio || useTextUI
    }
}
