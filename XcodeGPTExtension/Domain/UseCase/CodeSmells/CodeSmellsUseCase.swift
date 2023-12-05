//
//  CodeSmellsUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol CodeSmellsUseCase {
    func searchForCodeSmells(in code: [String]) async throws -> Suggestion
}

