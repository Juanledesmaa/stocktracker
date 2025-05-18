//
//  StockListServiceProtocol.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

@MainActor
protocol StockListServiceProtocol: ObservableObject {
	var stocks: [Stock] { get }
	var errorMessage: String? { get }
	func loadStocks() async
}
