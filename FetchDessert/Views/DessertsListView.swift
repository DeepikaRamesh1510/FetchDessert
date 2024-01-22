//
//  DessertsListView.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import SwiftUI

struct DessertsListView: View {
	@EnvironmentObject
	var viewModel: ListViewModel
	
	var body: some View {
		NavigationView {
			List {
				ForEach($viewModel.desserts) { dessert in
					NavigationLink {
						MealDetailView(
							viewModel: MealDetailViewModel(
								mealId: dessert.id,
								apiService: viewModel.dessertApi
							)
						)
					} label: {
						MealListCellView(meal: dessert)
					}
				}
			}
		}
		.navigationBarTitle(Text("Menu"))
	}
}


struct DessertsListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertsListView()
    }
}
