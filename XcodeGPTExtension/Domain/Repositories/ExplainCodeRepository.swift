//
//  ExplainCodeRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol ExplainCodeRepository {
    func explainMeThis(code: String) async throws -> [Suggestion]
}

