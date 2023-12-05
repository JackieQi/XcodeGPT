//
//  CommentRepository.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol CommentRepository {
    func comment(function code: String) async throws -> [Suggestion]
}

