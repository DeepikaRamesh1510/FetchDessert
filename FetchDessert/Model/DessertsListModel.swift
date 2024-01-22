//
//  DessertsListModel.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

struct DessertsListModel: Decodable, Identifiable {
	var id: String
	var name: String
	var thumbnailStr: String
	
	enum CodingKeys: String, CodingKey {
		case id = "idMeal"
		case name = "strMeal"
		case thumbnailStr = "strMealThumb"
	}
	
	init() {
		id = "Test"
		name = "Dessert"
		thumbnailStr = ""
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.thumbnailStr = try container.decode(String.self, forKey: .thumbnailStr)
	}
}
