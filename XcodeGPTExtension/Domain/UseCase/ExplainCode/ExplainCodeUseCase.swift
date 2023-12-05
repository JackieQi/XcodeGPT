//
//  ExplainCodeUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol ExplainCodeUseCase {
    func explainMeThis(code: String) async throws -> Suggestion
}

