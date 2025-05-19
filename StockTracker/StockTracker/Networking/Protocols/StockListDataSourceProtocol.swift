//
//  StockListDataSourceProtocol.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

/// Abstraction for a data source capable of fetching a list of stocks.
///
/// This allows decoupling the actual source of truth (mocked file, API, cache, etc.)
/// from the service layer. Easily swappable in tests or production environments.
protocol StockListDataSourceProtocol: Sendable {
	func fetchStocks() async throws -> [Stock]
}
