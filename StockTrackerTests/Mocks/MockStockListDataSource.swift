//
//  MockStockListDataSource.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

@testable import StockTracker

final class MockStockListDataSource: StockListDataSourceProtocol {
	let result: Result<[Stock], Error>

	init(result: Result<[Stock], Error>) {
		self.result = result
	}

	func fetchStocks() async throws -> [Stock] {
		switch result {
		case .success(let stocks):
			return stocks
		case .failure(let error):
			throw error
		}
	}
}
