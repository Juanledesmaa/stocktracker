//
//  StockSorter.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

struct StockSorter {
	static func sort(
		_ stocks: [StockDisplay],
		by option: StockListSortOption
	) -> [StockDisplay] {
		switch option {
			case .none:
				return stocks
				
			case .priceChangeAscending:
				return stocks.sorted {
					$0.stock.priceChange24Hrs < $1.stock.priceChange24Hrs
				}
				
			case .priceChangeDescending:
				return stocks.sorted {
					$0.stock.priceChange24Hrs > $1.stock.priceChange24Hrs
				}
				
			case .alphabeticalAscending:
				return stocks.sorted {
					$0.stock.name < $1.stock.name
				}
				
			case .alphabeticalDescending:
				return stocks.sorted { $0.stock.name > $1.stock.name }
				
			case .priceAscending:
				return stocks.sorted { $0.stock.price < $1.stock.price }
				
			case .priceDescending:
				return stocks.sorted { $0.stock.price > $1.stock.price }
		}
	}
}
