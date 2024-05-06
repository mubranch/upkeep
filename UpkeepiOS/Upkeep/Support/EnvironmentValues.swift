//
//  Environment.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import Foundation
import SwiftUI

private struct WebServiceEndpoint: EnvironmentKey {
    static let defaultValue: String = "https://upkeepwebservice-30bd10389427.herokuapp.com"
}

extension EnvironmentValues {
    var webServiceEndpoint: String {
        get { self[WebServiceEndpoint.self] }
        set { self[WebServiceEndpoint.self] = newValue }
    }
}
