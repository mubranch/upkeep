//
//  HomeViewModelTests.swift
//  UpkeepTests
//
//  Created by Mustafa on 5/6/24.
//

import Combine
import Foundation
import SwiftData
@testable import Upkeep
import XCTest

class HomeViewModelTests: XCTestCase {
    var modelContext: ModelContext!
    var viewModel: HomeViewModel!

    @MainActor
    override func setUp() {
        super.setUp()
        modelContext = try! ModelContainer(for: Appliance.self, Manual.self, Brand.self, Category.self, configurations: .init(isStoredInMemoryOnly: true)).mainContext
        viewModel = HomeViewModel(modelContext: modelContext)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHomeViewModel_Initialization_PopulatesAppliances() {
        XCTAssert(viewModel.appliances.isEmpty, "Model context is be empty on first launch.")
        modelContext.insert(Appliance())
        viewModel = HomeViewModel(modelContext: modelContext)
        XCTAssertEqual(viewModel.appliances.count, 1, "One appliance is in the view model.")
    }

    @MainActor
    func testHomeViewModel_AddDefaultsIfNeeded_InsertsDefaultsWhenEmpty() {
        modelContext = try! ModelContainer(for: Appliance.self, Manual.self, Brand.self, Category.self, configurations: .init(isStoredInMemoryOnly: true)).mainContext
        XCTAssert(modelContext.isEmpty, "Model Context is empty")
        viewModel = HomeViewModel(modelContext: modelContext)
        XCTAssert(!modelContext.isEmpty, "Defaults were added")
    }

    func testHomeViewModel_AddDefaultsIfNeeded_SkipsInsertsWhenNotEmpty() {
        let brands: [Brand] = modelContext.fetchData()
        viewModel = HomeViewModel(modelContext: modelContext)
        XCTAssertEqual(brands.count, DefaultBrands.allCases.count, "No new brands were added.")
    }
}
