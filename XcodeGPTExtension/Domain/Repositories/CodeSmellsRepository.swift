//
//  CodeSmellsRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol CodeSmellsRepository {
    func searchForCodeSmells(in code: String) async throws -> [Suggestion]
}

