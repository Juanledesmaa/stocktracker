//
//  Stock.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

struct Stock: Decodable, Equatable {
	let uuid: String
	let name: String
	let price: Double
	let priceChange24Hrs: Double
	let isFeatured: Bool
}
