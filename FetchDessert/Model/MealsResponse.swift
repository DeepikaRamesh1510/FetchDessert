//
//  MealsResponse.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

struct MealsResponse<T: Decodable>: Decodable {
	var meals: T
}
