//
//  MockStockListDataSource.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

final class StockListDataSource: StockListDataSourceProtocol {
	func fetchStocks() async throws -> [Stock] {
		// One of the project requirements states that we need to
		// delay the response 1 second.
		try await Task.sleep(for: .seconds(1))
		
		guard let url = Bundle.main.url(
			forResource: "example_response",
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
