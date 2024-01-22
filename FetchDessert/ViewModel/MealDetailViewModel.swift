//
//  MealDetailViewModel.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

class MealDetailViewModel: ObservableObject {
	let mealId: String
	let apiService: DessertApiProtocol
	
	@Published var mealDetail: MealDetailModel = .init()
	@Published var imageData: Data?
	@Published var isLoading: Bool = true
	
	init(
		mealId: String,
		apiService: DessertApiProtocol
	) {
		self.mealId = mealId
		self.apiService = apiService
	}
	
	func fetchMealDetail() {
		isLoading = true
		Task {
			do {
				let response = try await apiService.fetchMealDetails(self.mealId)
				DispatchQueue.main.async {
					self.mealDetail = response
					self.isLoading = false
				}
			} catch {
				print(error.localizedDescription)
				DispatchQueue.main.async { [unowned self] in
					self.isLoading = false
				}
			}
		}
	}
}
