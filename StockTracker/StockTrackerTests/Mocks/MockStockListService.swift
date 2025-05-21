//
//  MockStockListService.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

@testable import StockTracker

final class MockStockListService: StockListServiceProtocol {
	var stocks: [Stock]
	var errorMessage: String?

	init(stocks: [Stock] = [], errorMessage: String? = nil) {
		self.stocks = stocks
		self.errorMessage = errorMessage
	}

	func loadStocks(force: Bool) async {}
}
