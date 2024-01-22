//
//  MealDetailView.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import SwiftUI

struct MealDetailView: View {
	@ObservedObject
	var viewModel: MealDetailViewModel
	
    var body: some View {
		GeometryReader { geo in
			if viewModel.isLoading {
				ProgressView()
			} else {
				ScrollView {
					VStack(alignment: .leading) {
						Text(viewModel.mealDetail.name)
							.padding([.leading, .trailing], 20)
							.font(Font.largeTitle)
						AsyncImage(
							url: URL(string: viewModel.mealDetail.thumbnail),
							content: { image in
								image.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(maxWidth: 300, maxHeight: 200)
							},
							placeholder: {
								ProgressView()
							}
						)
						.padding(20)
						
						Text("Instructions: ")
							.font(Font.title)
							.padding(20)
						Text(viewModel.mealDetail.instruction)
							.padding(20)
						
						Text("Ingredients:")
							.font(Font.title)
							.padding(20)
						List(viewModel.mealDetail.ingredients) { ingredient in
							Text("\(ingredient.name) - \(ingredient.measurement)")
						}
						.padding(0)
						.background(Color.white) 
						.frame(
							width: geo.size.width - 5,
							height: geo.size.height - 50,
							alignment: .center
						)
					}
				}
			}
		}
		.task {
			viewModel.fetchMealDetail()
		}
		
	}
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
		MealDetailView(
			viewModel: MealDetailViewModel(
				mealId: "Test",
				apiService: DessertApi()
			)
		)
    }
}
