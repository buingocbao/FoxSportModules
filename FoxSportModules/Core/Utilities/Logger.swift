//
//  Logger.swift
//  FoxSportModules
//
//  Created by BimBim on 3/28/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import Foundation

class Logger {
    static func debug(_ message: Any, title: String = "") {
        print("-----DebugPrint-------")
        if title != "" {
            print(String(format: "%@: %@", title, String(describing: message)))
        } else {
            print(String(format: "%@", String(describing: message)))
        }
        print("----------------------")
    }
}
