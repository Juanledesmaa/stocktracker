//
//  StockListViewModel.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import Foundation

@MainActor
final class StockListViewModel: ObservableObject {
	
	var shownStocks: [Stock] = []
	@Published private(set) var isLoading = false
	private let service: any StockListServiceProtocol
	
	
	init(service: any StockListServiceProtocol) {
		self.service = service
	}
	
	func loadStocks() async {
		isLoading = true
		await service.loadStocks()
		shownStocks = service.stocks
		isLoading = false
	}
}
