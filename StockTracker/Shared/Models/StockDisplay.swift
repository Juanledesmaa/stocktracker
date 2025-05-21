//
//  StockDisplay.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

struct StockDisplay: Identifiable, Equatable {
	let stock: Stock
	let isFavorite: Bool

	var id: String { stock.ticker }
}
