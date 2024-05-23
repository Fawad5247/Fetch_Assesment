//
//  MealDataModel.swift
//  Assesment
//
//  Created by Fawad Akhtar on 05/22/2024.
//

import Foundation

struct MealResponse: Codable {
    let meals: [MealDetail]?
}

struct MealDetail: Decodable {
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
    let strMealThumb: String?
    
    var ingredients: [String] = []
    var measurements: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try? container.decode(String?.self, forKey: .strMealThumb)
        
        // Collect ingredients and measurements
        for i in 1...20 {
            if let ingredient = try? container.decode(String?.self, forKey: CodingKeys(stringValue: "strIngredient\(i)")!),!ingredient.isEmpty {
                ingredients.append(ingredient)
            }
            if let measurement = try? container.decode(String?.self, forKey: CodingKeys(stringValue: "strMeasure\(i)")!), !measurement.isEmpty {
                measurements.append(measurement)
            }
        }
    }
}

// Encodable conformance is added through an extension
extension MealDetail: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strInstructions, forKey: .strInstructions)
        try container.encode(strMealThumb, forKey: .strMealThumb)
        
        for (index, ingredient) in ingredients.enumerated() {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(index + 1)")!
            try container.encode(ingredient, forKey: ingredientKey)
        }
        
        for (index, measurement) in measurements.enumerated() {
            let measurementKey = CodingKeys(stringValue: "strMeasure\(index + 1)")!
            try container.encode(measurement, forKey: measurementKey)
        }
    }
}



