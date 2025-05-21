//
//  FavoriteStocksViewModelState.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

enum FavoriteStocksViewModelState: Equatable {
	case idle
	case loading
	case loaded([StockDisplay])
	case empty
}
