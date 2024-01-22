//
//  MealCacher.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

class MealCacher {
	var cache: [String: MealDetailModel] = [:]
	var apiService: DessertApiProtocol
	
	init(apiService: DessertApiProtocol) {
		self.apiService = apiService
	}
	
	func getMealDetails(_ id: String) async throws -> MealDetailModel {
		if let detail = cache[id] {
			return detail
		}
		
		let response = try await apiService.fetchMealDetails(id)
		cache[id] = response
		return response
	}
}
