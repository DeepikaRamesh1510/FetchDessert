//
//  DessertApi.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

protocol DessertApiProtocol {
	func fetchAll() async throws -> [DessertsListModel]
	func fetchMealDetails(_ id: String) async throws -> MealDetailModel
}

struct DessertApi: DessertApiProtocol {
	func fetchAll() async throws -> [DessertsListModel] {
		let response: MealsResponse<[DessertsListModel]> = try await DessertsEndPoint.fetchAll.run()
		return response.meals
	}
	
	func fetchMealDetails(_ id: String) async throws -> MealDetailModel {
		let response: MealsResponse<[MealDetailModel]> = try await DessertsEndPoint.fetchDetail(mealId: id).run()
		if let value = response.meals.first {
			return value
		} else {
			throw NetworkError.failedToFetch
		}
	}
}
