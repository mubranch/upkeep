//
//  ModelContext+Ext.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData

extension ModelContext {
    func fetchData<T: PersistentModel>() -> [T] {
        do {
            let descriptor = FetchDescriptor<T>()
            return try fetch(descriptor)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

extension ModelContext {
    var isEmpty: Bool {
        guard (try? fetchIdentifiers(FetchDescriptor<Brand>()).count) == 0 else {
            return false
        }
        return true
    }
}
