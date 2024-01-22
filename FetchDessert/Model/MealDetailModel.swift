//
//  MealDetailModel.swift
//  FetchDessert
//
//  Created by Deepika Ramesh on 1/21/24.
//



import Foundation

struct Ingredient: Identifiable {
	var id: UUID = UUID()
	var name: String
	var measurement: String
}

struct MealDetailModel: Decodable {
	var id: String = ""
	var name: String = ""
	var area: String = ""
	var instruction: String = ""
	var thumbnail: String = ""
	var ingredients: [Ingredient] = []
	
	private struct CustomCodingKeys: CodingKey {
		var stringValue: String
		init?(stringValue: String) {
			self.stringValue = stringValue
		}
		var intValue: Int?
		init?(intValue: Int) {
			return nil
		}
	}
	
	init() { }
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CustomCodingKeys.self)
		var ingredients: [Int: Ingredient] = [:]
		
		for key in container.allKeys {
			guard let value = try container.decode(String?.self, forKey: CustomCodingKeys(stringValue: key.stringValue)!) else { continue }
			switch key.stringValue {
				case "idMeal":
					self.id = value
				case "strMeal":
					self.name = value
				case "strArea":
					self.area = value
				case "strInstructions":
					self.instruction = value
				case "strMealThumb":
					self.thumbnail = value
				default: break
			}
			
			if let lastChar = key.stringValue.last, lastChar.isNumber {
				var key = key.stringValue
				var num = Int(String(key.removeLast()))!
				
				if let lastChar = key.last, lastChar.isNumber {
					num *= 10
					num += Int(String(lastChar))!
					key.removeLast()
				}
				
				var ingredient = ingredients[num] ?? Ingredient(name: "", measurement: "")
				updateIngredient(&ingredient, key, value)
				ingredients[num] = ingredient
			}
		}
		
		let values = ingredients.values.filter {
			return !$0.name.isEmpty
		}
		self.ingredients = values
	}
	
	func updateIngredient(_ ingredient: inout Ingredient, _ key: String, _ value: String) {
		switch key {
			case "strMeasure":
				ingredient.measurement = value
			case "strIngredient":
				ingredient.name = value
			default: break
		}
	}
}
