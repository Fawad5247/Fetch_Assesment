//
//  MealListViewModel.swift
//  Assesment
//
//  Created by Fawad Akhtar on 05/22/2024.
//

import Foundation

import Foundation

class MealListViewModel {
    var meals: [MealData] = []
    var onUpdate: (() -> Void)?
    
    func fetchMeals() {
        APIService.shared.fetchData(urlString: apiEndPoints.dessertList.rawValue) { [weak self] (result: Result<MealListResponse, Error>) in
            switch result {
            case .success(let mealResponse):
                // Filter out meals with nil or empty strMeal values, then sort the array alphabetically
                self?.meals = mealResponse.meals?
                    .compactMap { $0.strMeal?.isEmpty == false ? $0 : nil }
                    .sorted { $0.strMeal ?? "" < $1.strMeal ?? "" } ?? []

                self?.onUpdate?()
            case .failure(let error):
                print("Failed to fetch meals: \(error.localizedDescription)")
            }
        }
    }
}
