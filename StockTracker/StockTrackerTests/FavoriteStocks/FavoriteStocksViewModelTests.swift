//
//  FavoriteStocksViewModelTests.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

import XCTest
@testable import StockTracker

@MainActor
final class FavoriteStocksViewModelTests: XCTestCase {

	func test_initialState_isIdle() {
		let viewModel = FavoriteStocksViewModel(favoritesManager: MockFavoritesManager())
		XCTAssertEqual(viewModel.state, .idle)
	}

	func test_loadFavorites_withEmptyFavorites_setsEmptyState() {
		let favoritesManager = MockFavoritesManager(favorites: [])
		let viewModel = FavoriteStocksViewModel(favoritesManager: favoritesManager)

		viewModel.loadFavorites()

		XCTAssertEqual(viewModel.state, .empty)
	}

	func test_loadFavorites_withFavorites_setsLoadedStateAndAppliesSort() {
		let stock = Stock.mock(name: "Apple")
		let favoritesManager = MockFavoritesManager(favorites: [stock])
		let viewModel = FavoriteStocksViewModel(favoritesManager: favoritesManager)

		viewModel.loadFavorites()

		guard case let .loaded(stocks) = viewModel.state else {
			return XCTFail("Expected loaded state")
		}

		XCTAssertEqual(stocks.count, 1)
		XCTAssertEqual(stocks.first?.stock.name, "Apple")
	}

	func test_toggleFavorite_callsToggleAndReloads() {
		let stock = Stock.mock(name: "Apple")
		let favoritesManager = MockFavoritesManager(favorites: [stock])
		let viewModel = FavoriteStocksViewModel(favoritesManager: favoritesManager)

		viewModel.toggleFavorite(StockDisplay(stock: stock, isFavorite: true))

		XCTAssertEqual(favoritesManager.toggledStocks, [stock])
	}

	func test_applySort_setsCurrentSortAndUpdatesLoadedState() {
		let stockA = Stock.mock(name: "A", price: 10)
		let stockB = Stock.mock(name: "B", price: 5)
		let favoritesManager = MockFavoritesManager(favorites: [stockA, stockB])
		let viewModel = FavoriteStocksViewModel(favoritesManager: favoritesManager)

		viewModel.loadFavorites()
		viewModel.applySort(.priceAscending)

		XCTAssertEqual(viewModel.currentSort, .priceAscending)

		guard case let .loaded(stocks) = viewModel.state else {
			return XCTFail("Expected loaded state")
		}

		XCTAssertEqual(stocks.map { $0.stock.name }, ["B", "A"])
	}

	func test_applySort_whenStateIsNotLoaded_doesNothing() {
		let favoritesManager = MockFavoritesManager()
		let viewModel = FavoriteStocksViewModel(favoritesManager: favoritesManager)

		viewModel.applySort(.alphabeticalAscending)

		XCTAssertEqual(viewModel.state, .idle)
	}
}

