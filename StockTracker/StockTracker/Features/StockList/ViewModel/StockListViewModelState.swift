//
//  StockListViewModelState.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

enum StockListViewModelState {
	case idle
	case loading
	case loaded(featuredStocks:[Stock], allStocks: [Stock])
	case empty
	case error(String)
}
