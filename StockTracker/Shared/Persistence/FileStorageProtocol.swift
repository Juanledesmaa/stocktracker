//
//  FileStorageProtocol.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

protocol FileStorageProtocol {
	func save<T: Encodable>(_ object: T, to fileName: String) throws
	func load<T: Decodable>(_ fileName: String, as type: T.Type) throws -> T
}
