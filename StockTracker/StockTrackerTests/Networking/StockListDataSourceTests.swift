//
//  StockListDataSourceTests.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import XCTest
@testable import StockTracker

final class StockListDataSourceTests: XCTestCase {

	func test_fetchStocks_successfullyDecodesStocks() async throws {
		let dataSource = StockListDataSource()

		let stocks = try await dataSource.fetchStocks()

		XCTAssertFalse(stocks.isEmpty)
		XCTAssertTrue(
			stocks.allSatisfy { !$0.name.isEmpty && !$0.ticker.isEmpty }
		)
	}

	func test_fetchStocks_throwsErrorWhenFileIsMissing() async {
		let dataSource = StockListDataSource(resourceName: "missing_file")

		do {
			_ = try await dataSource.fetchStocks()
			XCTFail("Expected error not thrown")
		} catch {
			XCTAssertEqual(
				(error as NSError).localizedDescription,
				"JSON not found"
			)
		}
	}
}
