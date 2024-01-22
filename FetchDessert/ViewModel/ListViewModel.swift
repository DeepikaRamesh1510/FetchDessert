//
//  ListViewModel.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

class ListViewModel: ObservableObject {
	
	@Published var isLoading: Bool = false
	@Published var desserts: [DessertsListModel] = []
	
	var dessertApi: DessertApiProtocol
	
	init(
		dessertApi: DessertApiProtocol = DessertApi()
	) {
		self.dessertApi = dessertApi
	}
	
	func fetchAllDesserts() {
		isLoading = true
		Task {
			do {
				let result = try await dessertApi.fetchAll()
				DispatchQueue.main.async { [unowned self] in
					self.isLoading = false
					self.desserts = result
				}
			} catch {
				print(error.localizedDescription)
				DispatchQueue.main.async { [unowned self] in
					isLoading = false
				}
			}
		}
	}
}
