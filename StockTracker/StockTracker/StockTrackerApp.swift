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
			RootHostingView {
				AnyView(buildRootTabs())
			}
		}	
	}

	private func buildRootTabs() -> some View {
		let dataSource = StockListDataSource()
		let stockListService = StockListService(dataSource: dataSource)
		let fileStorage = FileStorage(directory: FileManager.documentsDirectory)
		let favoritesManager = FavoritesManager(storage: fileStorage)

		let stockListviewModel = StockListViewModel(
			service: stockListService,
			favoritesManager: favoritesManager
		)

		let favoriteStocksViewModel = FavoriteStocksViewModel(
			favoritesManager: favoritesManager
		)

		return RootTabView(tabs: [
			TabItem(
				view: AnyView(StockListView(viewModel: stockListviewModel)),
				label: "Home",
				systemImage: "list.bullet"
			),
			TabItem(
				view: AnyView(FavoriteStocksView(viewModel: favoriteStocksViewModel)),
				label: "Favorites",
				systemImage: "star.fill"
			),
			TabItem(
				view: AnyView(SettingsView()),
				label: "Settings",
				systemImage: "gearshape.fill"
			)
		])
	}
}


