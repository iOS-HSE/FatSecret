//
//  ProductViewController.swift
//  FatSecret
//
//  Created by user184905 on 12/13/20.
//

import UIKit
import FatSecretSwift

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var product_id: String = ""
    var data: [String] = []
    var onDisapper : (() -> Void)! = nil
    var isFavorite = false
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateButtonImage()
        
        Storage.fatSecretClient.getFood(id: product_id) { food in
            self.nameText.text = food.name
            let serving : Serving? = food.servings?[0]
            
            if let calories: String = serving?.calories {
                self.data.append("calories: \(calories)")
            }
            if let calcium: String = serving?.calcium {
                self.data.append("calcium: \(calcium)")
            }
            if let carbohydrate: String = serving?.carbohydrate {
                self.data.append("carbohydrate: \(carbohydrate)")
            }
            if let cholesterol: String = serving?.cholesterol {
                self.data.append("cholesterol: \(cholesterol)")
            }
            if let fat: String = serving?.fat {
                self.data.append("fat: \(fat)")
            }
            if let iron: String = serving?.iron {
                self.data.append("iron: \(iron)")
            }
            if let protein: String = serving?.protein {
                self.data.append("protein: \(protein)")
            }
            if let sugar: String = serving?.sugar {
                self.data.append("sugar: \(sugar)")
            }
            if let vitaminA: String = serving?.vitaminA {
                self.data.append("vitaminA: \(vitaminA)")
            }
            if let vitaminC: String = serving?.vitaminC {
                self.data.append("vitaminC: \(vitaminC)")
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onDisapper()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func updateButtonImage(){
        if isFavorite{
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func clickToFavorite(_ sender: Any) {
        isFavorite = !isFavorite
        Storage.changeFavorites(id: product_id)
        updateButtonImage()
    }
    
    @IBAction func clcikToEat(_ sender: Any) {
        Storage.eatFood(id: product_id)
        let alert = UIAlertController(title: "Success", message: "Food add to eaten", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
