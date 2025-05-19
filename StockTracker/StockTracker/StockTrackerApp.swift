//
//  StockTrackerApp.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import SwiftUI

@main
struct StockTrackerApp: App {
    var body: some Scene {
        WindowGroup {
			// TODO: Refactor everything here to a Builder/Factory pattern.
			let dataSource = StockListDataSource()
			let stockListService = StockListService(dataSource: dataSource)
			let viewModel = StockListViewModel(
				service: stockListService
			)
			
			RootTabView(tabs: [
				TabItem(
					view: AnyView(StockListView(viewModel: viewModel)),
					label: "Home",
					systemImage: "list.bullet"
				),
				TabItem(
					view: AnyView(FavoriteStocksView(viewModel: FavoriteStocksViewModel())),
					label: "Favorites",
					systemImage: "star.fill"
				)
			])
        }
    }
}
