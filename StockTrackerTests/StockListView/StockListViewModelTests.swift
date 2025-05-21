//
//  StockListViewModelTests.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

import XCTest
@testable import StockTracker

@MainActor
final class StockListViewModelTests: XCTestCase {

	func test_loadStocks_withStocks_setsLoadedState() async {
		let stocks = [
			Stock.mock(name: "Stock A", isFeatured: false),
			Stock.mock(name: "Stock B", isFeatured: true)
		]
		let service = MockStockListService(stocks: stocks)
		let viewModel = StockListViewModel(service: service, favoritesManager: MockFavoritesManager())

		await viewModel.loadStocks(force: false)

		guard case let .loaded(featured, all) = viewModel.state else {
			return XCTFail("Expected loaded state")
		}

		XCTAssertEqual(all.count, 2)
		XCTAssertEqual(featured.count, 1)
	}

	func test_loadStocks_withEmptyStocks_setsEmptyState() async {
		let service = MockStockListService(stocks: [])
		let viewModel = StockListViewModel(service: service, favoritesManager: MockFavoritesManager())

		await viewModel.loadStocks(force: false)

		XCTAssertEqual(viewModel.state, .empty)
	}

	func test_loadStocks_withError_setsErrorState() async {
		let service = MockStockListService(errorMessage: "Something went wrong")
		let viewModel = StockListViewModel(service: service, favoritesManager: MockFavoritesManager())

		await viewModel.loadStocks(force: false)

		guard case let .error(message) = viewModel.state else {
			return XCTFail("Expected error state")
		}

		XCTAssertEqual(message, "Something went wrong")
	}
	
	func test_toggleFavorite_whenStateIsNotLoaded_doesNothing() {
		let stock = Stock.mock(ticker: "MCKO")
		let favoritesManager = MockFavoritesManager()
		let viewModel = StockListViewModel(
			service: MockStockListService(),
			favoritesManager: favoritesManager
		)

		let display = StockDisplay(stock: stock, isFavorite: false)
		viewModel.toggleFavorite(display)

		XCTAssertTrue(favoritesManager.toggledStocks.contains(where: { $0.ticker == "MCKO" }))

		XCTAssertEqual(viewModel.state, .idle)
	}
	
	func test_applySort_whenStateIsNotLoaded_doesNothing() {
		let viewModel = StockListViewModel(
			service: MockStockListService(),
			favoritesManager: MockFavoritesManager()
		)

		viewModel.applySort(.priceAscending)
		XCTAssertEqual(viewModel.state, .idle)
	}
	
	func test_toggleFavorite_updatesFavoriteFlag_whenMatchingIDFound() async {
		let stock = Stock.mock(name: "MockStock", ticker: "MCKO")
		let display = StockDisplay(stock: stock, isFavorite: false)

		let service = MockStockListService(stocks: [stock])
		let favoritesManager = MockFavoritesManager()

		let viewModel = StockListViewModel(service: service, favoritesManager: favoritesManager)

		await viewModel.loadStocks(force: false)

		guard case let .loaded(_, allStocks) = viewModel.state,
			  let matchingDisplay = allStocks.first(where: { $0.id == display.id }) else {
			return XCTFail("Expected loaded state with matching stock")
		}

		viewModel.toggleFavorite(matchingDisplay)

		guard case let .loaded(_, updatedStocks) = viewModel.state else {
			return XCTFail("Expected loaded state after toggling")
		}

		XCTAssertTrue(updatedStocks.contains(where: { $0.id == display.id && $0.isFavorite }))
	}
}
