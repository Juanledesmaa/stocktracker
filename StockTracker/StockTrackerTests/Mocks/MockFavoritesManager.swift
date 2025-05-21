//
//  MockFavoritesManager.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

@testable import StockTracker
import SwiftUI

final class MockFavoritesManager: FavoritesManagerProtocol {
	var favorites: [Stock]
	var toggledStocks: [Stock] = []

	init(favorites: [Stock] = []) {
		self.favorites = favorites
	}

	func isFavorite(_ ticker: String) -> Bool {
		favorites.contains { $0.ticker == ticker }
	}

	func toggle(stock: Stock) {
		toggledStocks.append(stock)

		if let index = favorites.firstIndex(
			where: { $0.ticker == stock.ticker }
		) {
			favorites.remove(at: index)
		} else {
			favorites.append(stock)
		}
	}
}

