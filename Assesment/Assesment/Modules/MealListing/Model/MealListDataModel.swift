//
//  MealListDataModel.swift
//  Assesment
//
//  Created by Fawad Akhtar on 05/22/2024.
//

import Foundation

struct MealListResponse: Codable {
    let meals: [MealData]?
}

struct MealData: Codable {
    let idMeal: String?
    let strMeal: String?
    let strMealThumb: String?
}
