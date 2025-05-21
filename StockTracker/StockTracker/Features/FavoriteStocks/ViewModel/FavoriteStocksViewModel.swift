//
//  FavoriteStocksViewModel.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import Foundation
import SwiftUI

@MainActor
final class FavoriteStocksViewModel: ObservableObject {
	struct FavoriteStocksViewData {
		let progressViewText = "Loading favorites..."
		let emptyImageName = "favorite"
		let emptyImageSize = CGSize(width: 100, height: 100)
		let emptyFavoritesTitle = "You haven't added any favorites yet"
		let listHeaderTitle = "Your Favorite Stocks"
	}
	let viewData = FavoriteStocksViewData()
	
	@Published private(set) var state: FavoriteStocksViewModelState = .idle
	private let favoritesManager: any FavoritesManagerProtocol
	private var originalStocks: [StockDisplay] = []
	
	@AppStorage("favoriteStocksSortOption") private var storedSortRawValue: String = StockListSortOption.none.rawValue
	
	private(set) var currentSort: StockListSortOption {
		get { StockListSortOption(rawValue: storedSortRawValue) ?? .none }
		set { storedSortRawValue = newValue.rawValue }
	}
	
	init(favoritesManager: any FavoritesManagerProtocol) {
		self.favoritesManager = favoritesManager
	}
	
	func loadFavorites() {
		state = .loading
		
		let favorites = favoritesManager.favorites
		if favorites.isEmpty {
			state = .empty
		} else {
			let displayModels = favorites.map {
				StockDisplay(stock: $0, isFavorite: true)
			}
			originalStocks = displayModels
			
			state = .loaded(displayModels)
			applySort(currentSort)
		}
	}
	
	func toggleFavorite(_ stockDisplay: StockDisplay) {
		favoritesManager.toggle(stock: stockDisplay.stock)
		loadFavorites()
	}
	
	func applySort(_ sort: StockListSortOption) {
		currentSort = sort
		
		guard case .loaded = state else { return }
		
		
		let sortedStocks = StockSorter.sort(originalStocks, by: sort)
		state = .loaded(sortedStocks)
	}
}
