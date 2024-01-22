//
//  MealListCellView.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import SwiftUI
import UIKit

struct MealListCellView: View {
	@Binding var meal: DessertsListModel
	
	@State
	var imageData: Data?
	
	var body: some View {
		HStack(alignment: .top, spacing: 10) {
			AsyncImage(
				url: URL(string: meal.thumbnailStr),
				content: { image in
					image.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(maxWidth: 50, maxHeight: 50)
				},
				placeholder: {
					ProgressView()
				}
			)
			
			VStack(alignment: .leading, spacing: 5) {
				Text(meal.name)
					.font(.headline)
			}
		}
	}
}

struct MealListCellView_Previews: PreviewProvider {
    static var previews: some View {
		MealListCellView(
			meal: .constant(DessertsListModel())
		)
    }
}
