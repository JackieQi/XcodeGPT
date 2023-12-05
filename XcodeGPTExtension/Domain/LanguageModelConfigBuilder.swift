//
//  LanguageModelConfigBuilder.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 12/1/23.
//

import Foundation

struct LanguageModelConfigBuilder {
    static func makeLanguageModelConfig() -> LanguageModelConfig {
        if Environment.useLMStudio,
            let serverURL = Environment.webServerURL {
            return LanguageModelConfig(serverURL: serverURL, serverType: .LMStudio)
        } else if Environment.useTextUI,
            let serverURL = Environment.webServerURL {
            return LanguageModelConfig(serverURL: serverURL, serverType: .WebUI)
        } else {
            if let apiKey = Environment.apiKey,
                let serverURL = Environment.webServerURL {
                return LanguageModelConfig(apiKey: apiKey,
                                           modelName: Environment.modelName,
                                           serverURL:  serverURL,
                                           serverType: .OpenAI)
            } else {
                fatalError("[Error] ❌❌❌ Please select one server to run ❌❌❌")
            }
        }
    }
}
