//
//  EndPoint.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

protocol EndPoint {
	var baseUrl: String { get }
	var path: String { get }
	var body: [String: String]? { get }
	var method: HTTPMethod { get }
	var headers: [String: String]? { get }
	func run<T: Decodable>() async throws -> T
}

extension EndPoint {
	func run<T: Decodable>() async throws -> T {
		
		guard let url = URL(string: self.baseUrl + self.path) else { throw NetworkError.invalidURL }
		var request = URLRequest(url: url)
		
		if let headers = self.headers {
			for header in headers {
				request.addValue(header.value, forHTTPHeaderField: header.key)
			}
		}
		
		if let body = self.body {
			request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
		}
		
		request.httpMethod = self.method.rawValue
		
		
		let result = try await URLSession.shared.data(for: request)
		guard let httpResponse = result.1 as? HTTPURLResponse else {
			throw NetworkError.invalidResponse
		}
		
		switch httpResponse.statusCode {
			case 200...299:
				let response = try JSONDecoder().decode(T.self, from: result.0)
				return response
			default:
				throw NetworkError.failedToFetch
		}
	}
}
