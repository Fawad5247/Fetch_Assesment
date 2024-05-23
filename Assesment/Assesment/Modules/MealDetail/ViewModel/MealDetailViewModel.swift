//
//  MealDetailViewModel.swift
//  Assesment
//
//  Created by Fawad Akhtar on 05/22/2024.
//

import Foundation

class MealDetailViewModel {
    var mealDetail: MealDetail?
    var onUpdate: (() -> Void)?
    
    func fetchMealDetail(by id: String) {
        APIService.shared.fetchData(urlString: "\(apiEndPoints.dessertDetail.rawValue)\(id)") { [weak self] (result: Result<MealResponse, Error>) in
            switch result {
            case .success(let mealResponse):
                self?.mealDetail = mealResponse.meals?.first
                self?.onUpdate?()
            case .failure(let error):
                print("Failed to fetch meal detail: \(error.localizedDescription)")
            }
        }
    }
}
