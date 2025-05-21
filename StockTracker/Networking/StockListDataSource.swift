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
	private let bundle: Bundle
	private let userDefaults: UncheckedUserDefaults
	
	init(
		resourceName: String = "example_response",
		bundle: Bundle = .main,
		userDefaults: UncheckedUserDefaults = .init(.standard)
	) {
		self.resourceName = resourceName
		self.bundle = bundle
		self.userDefaults = userDefaults
	}
	
	func fetchStocks() async throws -> [Stock] {
		let mode = userDefaults.value.string(forKey: "mockAPIResponse") ?? "success"
		let response = MockAPIResponse(rawValue: mode) ?? .success
		
		switch response {
			case .success:
				return try await Task.detached(priority: .userInitiated) { [weak self] in
					guard let self else { return [] }
					try? await Task.sleep(for: .seconds(1))
					
					return try loadMockedJSON()
				}.value
			case .empty:
				return []
				
			case .error:
				throw NSError(
					domain: "MockedError",
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "Simulated API error"]
				)
				
			case .longDelay:
				return try await Task.detached(priority: .userInitiated) { [weak self] in
					guard let self else { return [] }
					try? await Task.sleep(for: .seconds(5))
					
					return try loadMockedJSON()
				}.value
		}
	}
	
	private func loadMockedJSON() throws -> [Stock] {
		guard let url = bundle.url(
			forResource: resourceName,
			withExtension: "json"
		) else {
			throw NSError(
				domain: "StockListDataSource",
				code: 1,
				userInfo: [NSLocalizedDescriptionKey: "JSON not found"]
			)
		}
		let data = try Data(contentsOf: url)
		return try JSONDecoder().decode([Stock].self, from: data)
	}
}


