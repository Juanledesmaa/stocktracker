//
//  StockListViewModel.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation
import SwiftUI

@MainActor
final class StockListViewModel: ObservableObject {
	struct StockListViewData {
		let progressViewText = "Loading Stocks..."
		let errorImageName = "alert"
		let errorTitle = "An error occurred while fetching stocks."
		let errorSubtitle = "Try to pull to refresh or try again later."
		let errorImageSize = CGSize(width: 100, height: 100)
		let emptyImageName = "secure"
		let emptyStocksTitle = "No stocks could be found."
		let listHeaderTitle = "All Stocks"
	}
	
	let viewData = StockListViewData()
	@Published private(set) var state: StockListViewModelState = .idle
	
	private let service: any StockListServiceProtocol
	private let favoritesManager: any FavoritesManagerProtocol
	private var originalStocks: [StockDisplay] = []
	
	@AppStorage("stockListSortOption") private var storedSortRawValue: String = StockListSortOption.none.rawValue
	
	private(set) var currentSort: StockListSortOption {
		get { StockListSortOption(rawValue: storedSortRawValue) ?? .none }
		set { storedSortRawValue = newValue.rawValue }
	}
	
	init(
		service: any StockListServiceProtocol,
		favoritesManager: any FavoritesManagerProtocol
	) {
		self.service = service
		self.favoritesManager = favoritesManager
	}
	
	func loadStocks(force: Bool) async {
		state = .loading
		await service.loadStocks(force: force)
		
		let stocks = service.stocks
		
		if !stocks.isEmpty {
			let stockDisplayModels = stocks.map {
				StockDisplay(
					stock: $0,
					isFavorite: favoritesManager.isFavorite($0.id)
				)
			}
			
			originalStocks = stockDisplayModels
			
			state = .loaded(
				featuredStocks: stockDisplayModels.filter { $0.stock.isFeatured },
				allStocks: stockDisplayModels
			)
			
			applySort(currentSort)
		} else {
			state = .empty
		}
		
		if let error = service.errorMessage {
			state = .error(error)
		}
	}
	
	func toggleFavorite(_ stockDisplay: StockDisplay) {
		favoritesManager.toggle(stock: stockDisplay.stock)
		
		if case let .loaded(_, currentAll) = state {
			let updated = currentAll.map { item in
				if item.id == stockDisplay.id {
					return StockDisplay(
						stock: item.stock,
						isFavorite: !item.isFavorite
					)
				} else {
					return item
				}
			}
			
			state = .loaded(
				featuredStocks: originalStocks.filter { $0.stock.isFeatured },
				allStocks: updated
			)
		}
	}
	
	func applySort(_ sort: StockListSortOption) {
		currentSort = sort
		
		guard case .loaded = state else { return }

		let sortedStocks = StockSorter.sort(originalStocks, by: sort)
		state = .loaded(
			featuredStocks: originalStocks.filter { $0.stock.isFeatured },
			allStocks: sortedStocks
		)
	}
}
