//
//  LogManager.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import OSLog

/// The `subsystem` string `identifies a large functional area` within your app or apps. For example, if your app spawns additional processes, you might use a different string for each process. Use reverse-DNS notation, such as com.example.myapp, for each subsystem string.
/// The `category` string `identifies a particular component or module in a given subsystem`. For example, you might define separate strings for your app’s user interface, data model, and networking code. Use any convention you want for these strings.
struct LogManager {
    let logger: Logger

    init(subsystem: String, category: String) {
        self.logger = Logger(subsystem: subsystem, category: category)
    }

    func logDebug(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }

    func logInfo(_ message: String) {
        logger.info("\(message, privacy: .public)")
    }

    func logWarning(_ message: String) {
        logger.warning("\(message, privacy: .public)")
    }

    func logError(_ message: String) {
        logger.error("\(message, privacy: .public)")
    }

    func logFault(_ message: String) {
        logger.fault("\(message, privacy: .public)")
    }
}
