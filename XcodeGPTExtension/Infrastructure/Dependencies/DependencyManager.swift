//
//  DependencyManager.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import Foundation

final class DependencyManager {
    static func makeCodeRefactorDependencies() -> RefactorCodeUseCase {
        let refactorCodeRepository: RefactorCodeRepository = XcodeGPTRefactorCodeRepository()
        let useCase: RefactorCodeUseCase = DefaultRefactorCodeUseCase(repository: refactorCodeRepository)
        
        return useCase
    }
    
    static func makeJSONConverterDependencies() -> JSONConverterUseCase {
        let jsonConverterRepository: JSONConverterRepository = XcodeGPTJSONConverterRepository()
        let useCase: JSONConverterUseCase = DefaultJSONConverterUseCase(repository: jsonConverterRepository)
        
        return useCase
    }
    
    static func makeCodeSmellsDependencies() -> CodeSmellsUseCase {
        let codeSmellsRepository: CodeSmellsRepository = XcodeGPTCodeSmellsRepository()
        let useCase: CodeSmellsUseCase = DefaultCodeSmellsUseCase(repository: codeSmellsRepository)
        
        return useCase
    }
    
    static func makeExplainCodeDependencies() -> ExplainCodeUseCase {
        let explainCodeRepository: ExplainCodeRepository = XcodeGPTExplainCodeRepository()
        let useCase: ExplainCodeUseCase = DefaultExplainCodeUseCase(repository: explainCodeRepository)
        
        return useCase
    }
    
    static func makeUnitTestsDependencies() -> UnitTestUseCase {
        let unitTestRepository: UnitTestRepository = XcodeGPTUnitTestRepository()
        let useCase: UnitTestUseCase = DefaultUnitTestUseCase(repository: unitTestRepository)
        
        return useCase
    }
    
    static func makeRegexDependencies() -> RegexUseCase {
        let regexRepository: RegexRepository = XcodeGPTRegexRepository()
        let useCase: RegexUseCase = DefaultRegexUseCase(repository: regexRepository)
        
        return useCase
    }
    
    static func makeCommentDependencies() -> CommentUseCase {
        let commentRepository: CommentRepository = XcodeGPTCommentRepository()
        let useCase: CommentUseCase = DefaultCommentUseCase(repository: commentRepository)
        
        return useCase
    }
}


