//
//  StockListService.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

@MainActor
final class StockListService: StockListServiceProtocol {
	@Published private(set) var stocks: [Stock] = []
	@Published private(set) var errorMessage: String?

	private let dataSource: StockListDataSourceProtocol

	private var hasLoadedOnce = false
	private var cachedStocks: [Stock] = []

	init(dataSource: StockListDataSourceProtocol) {
		self.dataSource = dataSource
	}

	func loadStocks(force: Bool = false) async {
		guard !hasLoadedOnce || force else {
			stocks = cachedStocks
			errorMessage = nil
			return
		}

		do {
			let allStocks = try await dataSource.fetchStocks()
			let uniqueStocks = removeDuplicates(allStocks)

			cachedStocks = uniqueStocks
			stocks = uniqueStocks
			errorMessage = nil
			hasLoadedOnce = true
		} catch is CancellationError {
			print("Stock loading was cancelled.")
		} catch {
			errorMessage = "Failed to load stocks: \(error.localizedDescription)"
		}
	}

	private func removeDuplicates(_ stocks: [Stock]) -> [Stock] {
		var seen = Set<String>()
		return stocks.filter { stock in
			guard !seen.contains(stock.ticker) else { return false }
			seen.insert(stock.ticker)
			return true
		}
	}
}


