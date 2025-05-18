//
//  StockListDataSourceProtocol.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

protocol StockListDataSourceProtocol: Sendable {
	func fetchStocks() async throws -> [Stock]
}
