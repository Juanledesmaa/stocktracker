//
//  Stock+Extension.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

@testable import StockTracker
import Foundation

extension Stock {
	static func mock(
		name: String = "Mock",
		ticker: String = "MCKO",
		price: Decimal = 1.0,
		priceChange24Hrs: Decimal = 0.0,
		isFeatured: Bool = false
	) -> Stock {
		return Stock(
			name: name,
			ticker: ticker,
			price: price,
			priceChange24Hrs: priceChange24Hrs,
			isFeatured: isFeatured
		)
	}
}
