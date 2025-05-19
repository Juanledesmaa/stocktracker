//
//  StockListServiceTests.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import XCTest
@testable import StockTracker

@MainActor
final class StockListServiceTests: XCTestCase {

	func test_loadStocks_successfullyPublishesStocks() async {
		let expectedStocks = [
			Stock(
				name: "Apple",
				ticker: "AAPL",
				price: 150.0,
				priceChange24Hrs: 1.0,
				isFeatured: true
			)
		]
		let stub = MockStockListDataSource(result: .success(expectedStocks))
		let service = StockListService(dataSource: stub)

		await service.loadStocks()

		XCTAssertEqual(service.stocks, expectedStocks)
		XCTAssertNil(service.errorMessage)
	}

	func test_loadStocks_failurePublishesErrorMessage() async {
		struct FakeError: LocalizedError {
			var errorDescription: String? { "Fake failure" }
		}

		let stub = MockStockListDataSource(result: .failure(FakeError()))
		let service = StockListService(dataSource: stub)

		await service.loadStocks()

		XCTAssertTrue(service.stocks.isEmpty)
		XCTAssertEqual(
			service.errorMessage,
			"Failed to load stocks: Fake failure"
		)
	}
}
