//
//  TableViewController.swift
//  FatSecret
//
//  Created by user184905 on 12/12/20.
//

import UIKit
import FatSecretSwift

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private let PRODUCT_SCREEN_IDENTIFIER: String = "ProductScreen"
    
    var data : [SearchedFood] = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchField.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let food = data[indexPath.row]
        cell.nameText.text = food.name
        cell.id = food.id
        cell.isFavorite = Storage.favoritesFood.contains(food.id)
        let description = food.getDataFromDescription()
        cell.doseText.text = description.dose
        cell.caloriesText.text = description.calories
        cell.fatText.text = description.fat
        cell.carbsText.text = description.carbs
        cell.proteinText.text = description.protein
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
    
    func searchAction(){
        guard let text = searchField.text else { return }
        if text == ""{
            return
        }
        do{
            Storage.fatSecretClient.searchFood(name: text) { search in
                self.data = search.foods

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        catch{
            return
        }
        
        searchField.endEditing( true)
    }
    
    @IBAction func clickToSearchButton(_ sender: Any) {
        searchAction()
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchAction()
        return true
    }
    
    
}

public struct ProductDescription{
    let dose: String!
    let calories: String!
    let fat: String!
    let carbs: String!
    let protein: String!
}

public extension SearchedFood {

    func getDataFromDescription() -> ProductDescription {
        let parts = description.components(separatedBy: "|")
        let dose = parts[0].components(separatedBy: "-")[0]
        let calories = parts[0].components(separatedBy: "-")[1]
        return ProductDescription(dose: dose, calories: calories, fat: parts[1], carbs: parts[2], protein: parts[3])
            
    }
}

