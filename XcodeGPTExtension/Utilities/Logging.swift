//
//  Logging.swift
//  XcodeGPTExtension
//
//  Created by Jackie Qi on 11/27/23.
//

import OSLog

extension Logger {
    private static var subsystem = "com.XcodeGPTExtension"
    
    static let process = Logger(subsystem: subsystem, category: "process")
}
