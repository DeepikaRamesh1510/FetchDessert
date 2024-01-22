//
//  DessertsEndPoint.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

enum DessertsEndPoint {
	case fetchAll
	case fetchDetail(mealId: String)
}

extension DessertsEndPoint: EndPoint {
	
	var baseUrl: String {
		return "https://themealdb.com"
	}
	
	var path: String {
		switch self {
			case .fetchAll:
				return "/api/json/v1/1/filter.php?c=Dessert"
			case .fetchDetail(let mealId):
				return "/api/json/v1/1/lookup.php?i=\(mealId)"
		}
	}
	
	var method: HTTPMethod {
		switch self {
			case .fetchDetail, .fetchAll:
				return .get
		}
	}
	
	var headers: [String : String]? { return nil }
	
	var body: [String : String]? { return nil }
}
