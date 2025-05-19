//
//  MockStockListDataSource.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

/// Concrete implementation of `StockListDataSourceProtocol` that loads
/// stock data from a local bundled JSON file.
///
/// Includes a simulated delay to mimic real network latency,
/// as specified by the exercise.
/// Can be replaced with a live API data source by conforming
/// to the same protocol.
final class StockListDataSource: StockListDataSourceProtocol {
	
	private let resourceName: String

	init(resourceName: String = "example_response") {
		self.resourceName = resourceName
	}

	func fetchStocks() async throws -> [Stock] {
		try await Task.sleep(for: .seconds(1))
		
		guard let url = Bundle.main.url(
			forResource: resourceName,
			withExtension: "json") else {
			throw NSError(
				domain: "StockListDataSource",
				code: 1,
				userInfo: [
					NSLocalizedDescriptionKey: "JSON not found"
				]
			)
		}
		
		let data = try Data(contentsOf: url)
		
		return try JSONDecoder().decode([Stock].self, from: data)
	}
}
