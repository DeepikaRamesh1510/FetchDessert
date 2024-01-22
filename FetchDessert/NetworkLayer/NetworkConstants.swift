//
//  NetworkConstants.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
}

enum NetworkError: Error {
	case invalidURL
	case invalidResponse
	case failedToFetch
}
