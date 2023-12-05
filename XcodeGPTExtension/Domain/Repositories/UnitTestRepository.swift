//
//  UnitTestRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol UnitTestRepository {
    func generateTestsFor(source code: String) async throws -> [Suggestion]
}

