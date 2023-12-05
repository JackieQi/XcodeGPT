//
//  JSONConverterRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol JSONConverterRepository {
    func convertToJSON(code: String) async throws -> [Suggestion]
}

