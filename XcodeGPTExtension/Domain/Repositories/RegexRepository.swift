//
//  RegexRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol RegexRepository {
    func generateRegexFor(string value: String) async throws -> [Suggestion]
}
