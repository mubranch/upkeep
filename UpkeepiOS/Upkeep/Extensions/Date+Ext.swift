//
//  Date+Ext.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation

extension Date? {
    var unwrapped: String {
        self?.formatted() ?? "unkown".capitalized
    }
}
