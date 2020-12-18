//
//  FavoriteProductsTableViewController.swift
//  FatSecret
//
//  Created by user184905 on 12/17/20.
//

import UIKit
import FatSecretSwift

class FavoriteProductsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let PRODUCT_SCREEN_IDENTIFIER: String = "ProductScreen"
    var data : [Food] = []
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let food = data[indexPath.row]
        cell.nameText.text = food.name
        cell.id = food.id
        cell.isFavorite = Storage.favoritesFood.contains(food.id)
        let serving = food.servings?[0]
        cell.doseText.text = ""
        cell.caloriesText.text = "Calories: " + (serving?.calories)!
        cell.fatText.text = "Fat: " + (serving?.fat)!
        cell.carbsText.text = "Carbs: " + (serving?.carbohydrate)!
        cell.proteinText.text = "Protein: " + (serving?.protein)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: PRODUCT_SCREEN_IDENTIFIER ) as! ProductViewController
        let product = data[indexPath.row]
        newViewController.product_id = product.id
        newViewController.isFavorite = Storage.favoritesFood.contains(product.id)
        newViewController.onDisapper = self.tableView.reloadData
        self.present(newViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isIdInData = {(id : String) -> Bool in
            for item in self.data{
                if item.id == id {
                    return true
                }
            }
            return false
        }
        
        for food in data {
            if !Storage.favoritesFood.contains(food.id){
                data.removeAll{(item) in item.id == food.id}
            }
        }
        
        for id in Storage.favoritesFood {
            if !isIdInData(id){
                Storage.fatSecretClient.getFood(id: id) { food in
                    self.data.append(food)
                    print(food)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        self.tableView.reloadData()
    }


}
