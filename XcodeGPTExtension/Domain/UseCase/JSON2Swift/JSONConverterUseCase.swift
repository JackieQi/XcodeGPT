//
//  JSONConverterUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol JSONConverterUseCase {
    func convertToJSON(source code: [String]) async throws -> Suggestion
}

