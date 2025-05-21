//
//  StockListDataSourceTests.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import XCTest
@testable import StockTracker

final class StockListDataSourceTests: XCTestCase {
	
	let testDefaults = UncheckedUserDefaults(.init(suiteName: "TestDefaults")!)

	override func setUp() {
		super.setUp()
		testDefaults.value.removeObject(forKey: "mockAPIResponse")
	}

	func test_fetchStocks_success_returnsDecodedStocks() async throws {
		testDefaults.value.setValue("Success", forKey: "mockAPIResponse")
		let dataSource = StockListDataSource(
			resourceName: "mock_response",
			bundle: getBundle(),
			userDefaults: testDefaults
		)

		let stocks = try await dataSource.fetchStocks()

		XCTAssertFalse(stocks.isEmpty)
	}

	func test_fetchStocks_empty_returnsEmptyArray() async throws {
		testDefaults.value.setValue("Empty", forKey: "mockAPIResponse")
		let dataSource = StockListDataSource(
			resourceName: "mock_response",
			bundle: getBundle(),
			userDefaults: testDefaults
		)

		let stocks = try await dataSource.fetchStocks()

		XCTAssertTrue(stocks.isEmpty)
	}

	func test_fetchStocks_error_throwsError() async {
		testDefaults.value.setValue("Error", forKey: "mockAPIResponse")
		let dataSource = StockListDataSource(
			resourceName: "mock_response",
			bundle: getBundle(),
			userDefaults: testDefaults
		)

		do {
			_ = try await dataSource.fetchStocks()
			XCTFail("Expected error to be thrown")
		} catch {
			XCTAssertEqual((error as NSError).domain, "MockedError")
		}
	}

	func test_fetchStocks_longDelay_returnsDecodedStocks() async throws {
		testDefaults.value.setValue("Long Delay", forKey: "mockAPIResponse")
		let dataSource = StockListDataSource(
			resourceName: "mock_response",
			bundle: getBundle(),
			userDefaults: testDefaults
		)

		let stocks = try await dataSource.fetchStocks()

		XCTAssertFalse(stocks.isEmpty)
	}

	func test_loadMockedJSON_withInvalidFile_throwsError() async {
		testDefaults.value.setValue("Success", forKey: "mockAPIResponse")
		let dataSource = StockListDataSource(
			resourceName: "non_existent_file",
			bundle: getBundle(),
			userDefaults: testDefaults
		)

		do {
			_ = try await dataSource.fetchStocks()
			XCTFail("Expected error to be thrown")
		} catch {
			XCTAssertEqual((error as NSError).domain, "StockListDataSource")
		}
	}
	
	private func getBundle() -> Bundle {
		return Bundle(for: StockListDataSourceTests.self)
	}
}

