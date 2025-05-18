//
//  Stock.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

struct Stock: Identifiable, Codable {
	var id: String { ticker }
	let name: String
	let ticker: String
	let price: Decimal
	let priceChange24Hrs: Decimal
	let isFeatured: Bool

	enum CodingKeys: String, CodingKey {
		case name
		case ticker
		case price
		case priceChange24Hrs = "price_change_24hrs"
		case isFeatured = "is_featured"
	}
}
