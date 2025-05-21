//
//  FileStorageTests.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

import XCTest
@testable import StockTracker

final class FileStorageTests: XCTestCase {

	private var storage: FileStorageProtocol!
	private var tempDirectory: URL!

	override func setUp() {
		super.setUp()
		tempDirectory = FileManager
			.default
			.temporaryDirectory
			.appendingPathComponent(
				UUID().uuidString
			)
		try? FileManager.default.createDirectory(
			at: tempDirectory,
			withIntermediateDirectories: true
		)
		storage = FileStorage(directory: tempDirectory)
	}

	override func tearDown() {
		try? FileManager.default.removeItem(at: tempDirectory)
		storage = nil
		super.tearDown()
	}

	func testSaveAndLoad_StringArray() throws {
		let dataToSave = ["AAPL", "GOOG", "TSLA"]
		let fileName = "test_favorites.json"

		try storage.save(dataToSave, to: fileName)

		let loadedData: [String] = try storage.load(fileName, as: [String].self)
		XCTAssertEqual(loadedData, dataToSave)
	}

	func testLoad_NonexistentFile_ThrowsError() {
		let fileName = "nonexistent.json"

		XCTAssertThrowsError(
			try storage.load(
				fileName,
				as: [String].self
			)
		) { error in
			XCTAssertTrue((error as NSError).domain == NSCocoaErrorDomain)
		}
	}
}
