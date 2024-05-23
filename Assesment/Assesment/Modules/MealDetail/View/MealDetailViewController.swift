//
//  MealDetailViewController.swift
//  Assesment
//
//  Created by Fawad Akhtar on 05/22/2024.
//

import UIKit

class MealDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    var mealID: String?
    let viewModel = MealDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        if let mealID = mealID {
            viewModel.fetchMealDetail(by: mealID)
        }
    }
    
    
    
    func updateUI() {
        guard let mealDetail = viewModel.mealDetail else { return }

        nameLabel.text = mealDetail.strMeal
        instructionsLabel.text = mealDetail.strInstructions
        
        var ingredientsText = ""
        for (ingredient, measurement) in zip(mealDetail.ingredients, mealDetail.measurements) {
            ingredientsText += "\(ingredient): \(measurement)\n"
        }
        ingredientsLabel.text = ingredientsText
    }
}

