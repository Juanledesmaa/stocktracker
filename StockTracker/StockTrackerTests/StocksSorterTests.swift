//
//  StocksSorterTests.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

@testable import StockTracker
import XCTest

final class StockSorterTests: XCTestCase {
	func test_sort_byNone() {
		let stockA = Stock.mock(name: "A", price: 100)
		let stockB = Stock.mock(name: "B", price: 50)
		let stockC = Stock.mock(name: "Ghost", price: 50)
		let displays = [
			StockDisplay(stock: stockA, isFavorite: true),
			StockDisplay(stock: stockB, isFavorite: true),
			StockDisplay(stock: stockC, isFavorite: true)
		]

		let sorted = StockSorter.sort(displays, by: .none)
		XCTAssertEqual(displays, sorted)
	}
	
	func test_sort_byPriceChangeAscending() {
		let stockA = Stock.mock(name: "A", priceChange24Hrs: 9.99)
		let stockB = Stock.mock(name: "B", priceChange24Hrs: 19.99)
		let stockC = Stock.mock(name: "C", priceChange24Hrs: 119.99)
		let displays = [
			StockDisplay(stock: stockA, isFavorite: true),
			StockDisplay(stock: stockB, isFavorite: true),
			StockDisplay(stock: stockC, isFavorite: true)
		]

		let sorted = StockSorter.sort(displays, by: .priceChangeAscending)
		XCTAssertEqual(
			sorted.map { $0.stock.priceChange24Hrs }, [9.99, 19.99, 119.99]
		)
	}
	
	func test_sort_byPriceChangeDescending() {
		let stockA = Stock.mock(name: "A", priceChange24Hrs: 9.99)
		let stockB = Stock.mock(name: "B", priceChange24Hrs: 19.99)
		let stockC = Stock.mock(name: "C", priceChange24Hrs: 119.99)
		let displays = [
			StockDisplay(stock: stockA, isFavorite: true),
			StockDisplay(stock: stockB, isFavorite: true),
			StockDisplay(stock: stockC, isFavorite: true)
		]

		let sorted = StockSorter.sort(displays, by: .priceChangeDescending)
		XCTAssertEqual(
			sorted.map { $0.stock.priceChange24Hrs }, [119.99, 19.99, 9.99]
		)
	}
	
	func test_sort_byAlphabeticalAscending() {
		let stockA = Stock.mock(name: "A", priceChange24Hrs: 9.99)
		let stockB = Stock.mock(name: "B", priceChange24Hrs: 19.99)
		let stockC = Stock.mock(name: "Z", priceChange24Hrs: 119.99)
		let displays = [
			StockDisplay(stock: stockA, isFavorite: true),
			StockDisplay(stock: stockB, isFavorite: true),
			StockDisplay(stock: stockC, isFavorite: true)
		]

		let sorted = StockSorter.sort(displays, by: .alphabeticalAscending)
		XCTAssertEqual(
			sorted.map { $0.stock.name }, ["A", "B", "Z"]
		)
	}
	
	func test_sort_byAlphabeticalDescending() {
		let stockA = Stock.mock(name: "A", priceChange24Hrs: 9.99)
		let stockB = Stock.mock(name: "B", priceChange24Hrs: 19.99)
		let stockC = Stock.mock(name: "Z", priceChange24Hrs: 119.99)
		let displays = [
			StockDisplay(stock: stockA, isFavorite: true),
			StockDisplay(stock: stockB, isFavorite: true),
			StockDisplay(stock: stockC, isFavorite: true)
		]

		let sorted = StockSorter.sort(displays, by: .alphabeticalDescending)
		XCTAssertEqual(
			sorted.map { $0.stock.name }, ["Z", "B", "A"]
		)
	}
	
	func test_sort_byPriceAscending() {
		let stockA = Stock.mock(name: "A", price: 100)
		let stockB = Stock.mock(name: "B", price: 50)
		let displays = [StockDisplay(stock: stockA, isFavorite: true),
						StockDisplay(stock: stockB, isFavorite: true)]

		let sorted = StockSorter.sort(displays, by: .priceAscending)
		XCTAssertEqual(sorted.map { $0.stock.price }, [50, 100])
	}

	func test_sort_byPriceDescending() {
		let stockA = Stock.mock(name: "A", price: 100)
		let stockB = Stock.mock(name: "B", price: 50)
		let displays = [StockDisplay(stock: stockA, isFavorite: true),
						StockDisplay(stock: stockB, isFavorite: true)]

		let sorted = StockSorter.sort(displays, by: .priceDescending)
		XCTAssertEqual(sorted.map { $0.stock.price }, [100, 50])
	}
}
