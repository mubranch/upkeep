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
        let itemFetchDescriptor = FetchDescriptor<Brand>()
        guard (try? fetch(itemFetchDescriptor).count) == 0 else {
            return false
        }
        return true
    }
}
