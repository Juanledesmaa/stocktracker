//
//  StockListViewModelState.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//


enum StockListViewModelState: Equatable {
	case idle
	case loading
	case loaded(featuredStocks: [StockDisplay], allStocks: [StockDisplay])
	case empty
	case error(String)
}
