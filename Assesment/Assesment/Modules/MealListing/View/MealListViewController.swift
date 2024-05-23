//
//  MealListViewController.swift
//  Assesment
//
//  Created by Fawad Akhtar on 05/22/2024.
//

import UIKit

class MealListViewController: UITableViewController {
    let viewModel = MealListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dessert Recipes"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MealCell")
        
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchMeals()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        let meal = viewModel.meals[indexPath.row]
        cell.textLabel?.text = meal.strMeal
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = viewModel.meals[indexPath.row]
        let detailVC: MealDetailViewController =  self.storyboard?.instantiateViewController(withIdentifier: "MealDetailViewController") as! MealDetailViewController
        detailVC.mealID = meal.idMeal
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

