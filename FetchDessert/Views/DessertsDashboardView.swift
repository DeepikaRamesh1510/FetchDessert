//
//  DessertsDashboard.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import SwiftUI

struct DessertsDashboardView: View {
	@EnvironmentObject
	var viewModel: ListViewModel
	 
	var body: some View {
		ZStack {
			if viewModel.isLoading {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle())
			} else {
				DessertsListView()
					.environmentObject(viewModel)
			}
		}
		.task {
			viewModel.fetchAllDesserts()
		}
	}
}

struct DessertsDashboard_Previews: PreviewProvider {
    static var previews: some View {
        DessertsDashboardView()
    }
}
