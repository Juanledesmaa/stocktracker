//
//  FileStorage.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

import Foundation

final class FileStorage: FileStorageProtocol {
	private let directory: URL

	init(directory: URL) {
		self.directory = directory
	}

	func save<T: Encodable>(_ object: T, to fileName: String) throws {
		let url = directory.appendingPathComponent(fileName)
		let data = try JSONEncoder().encode(object)
		try data.write(to: url, options: .atomic)
	}

	func load<T: Decodable>(_ fileName: String, as type: T.Type) throws -> T {
		let url = directory.appendingPathComponent(fileName)
		let data = try Data(contentsOf: url)
		return try JSONDecoder().decode(T.self, from: data)
	}
}
