//
//  RefactorCodeUseCase.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

protocol RefactorCodeUseCase {
    func refactor(function code: [String]) async throws -> Suggestion
}
