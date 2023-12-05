//
//  RefactorCodeRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol RefactorCodeRepository {
    func refactor(code: String) async throws -> [Suggestion]
}

