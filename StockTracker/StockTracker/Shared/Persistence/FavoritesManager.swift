//
//  FavoritesManager.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

import Foundation
import Combine

final class FavoritesManager: FavoritesManagerProtocol {
	@Published private var favoritesSet: Set<Stock> = []

	private let fileName = "favorites.json"
	private let storage: FileStorageProtocol

	init(storage: FileStorageProtocol) {
		self.storage = storage
		loadFavorites()
	}

	var favorites: [Stock] {
		Array(favoritesSet).sorted { $0.ticker < $1.ticker }
	}

	func isFavorite(_ ticker: String) -> Bool {
		favoritesSet.contains { $0.ticker == ticker }
	}

	func toggle(stock: Stock) {
		if favoritesSet.contains(stock) {
			favoritesSet.remove(stock)
		} else {
			favoritesSet.insert(stock)
		}
		saveFavorites()
	}

	private func loadFavorites() {
		do {
			let decoded = try storage.load(fileName, as: [Stock].self)
			favoritesSet = Set(decoded)
		} catch {
			print("Failed to load favorites: \(error)")
			favoritesSet = []
		}
	}

	private func saveFavorites() {
		do {
			try storage.save(Array(favoritesSet), to: fileName)
		} catch {
			print("Failed to save favorites: \(error)")
		}
	}
}
