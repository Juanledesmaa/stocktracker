//
//  StockListViewModel.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

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
	}
	
	let viewData = StockListViewData()
	@Published private(set) var state: StockListViewModelState = .idle

	private let service: any StockListServiceProtocol

	init(service: any StockListServiceProtocol) {
		self.service = service
	}

	func loadStocks() async {
		state = .loading
		await service.loadStocks()

		let stocks = service.stocks

		if !stocks.isEmpty {
			state = .loaded(
				featuredStocks: stocks.filter { $0.isFeatured },
				allStocks: stocks
			)
		} else {
			state = .empty
		}

		if let error = service.errorMessage {
			state = .error(error)
		}
	}
}
