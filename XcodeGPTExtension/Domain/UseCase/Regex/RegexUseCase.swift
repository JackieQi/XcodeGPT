//
//  RegexUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol RegexUseCase {
    func generateRegexFor(string value: String) async throws -> Suggestion
}

