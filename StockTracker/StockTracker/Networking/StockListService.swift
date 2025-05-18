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
	
	init(dataSource: StockListDataSourceProtocol) {
		self.dataSource = dataSource
	}
	
	func loadStocks() async {
		do {
			stocks = try await dataSource.fetchStocks()
		} catch {
			errorMessage = "Failed to load stocks: \(error.localizedDescription)"
		}
	}
}
