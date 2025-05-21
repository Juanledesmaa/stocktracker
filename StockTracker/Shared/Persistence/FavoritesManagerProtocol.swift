//
//  FavoritesManagerProtocol.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

import Combine

protocol FavoritesManagerProtocol: ObservableObject {
	var favorites: [Stock] { get }
	func isFavorite(_ ticker: String) -> Bool
	func toggle(stock: Stock)
}

