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
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateButtonImage()
        updateDeleteButtonState()
        
        Storage.fatSecretClient.getFood(id: product_id) { food in
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
                self.nameText.text = food.name
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    func updateDeleteButtonState(){
        deleteButton.isHidden = !Storage.foodIsEatenToday(id: product_id)
    }
    
    @IBAction func clickToFavorite(_ sender: Any) {
        isFavorite = !isFavorite
        Storage.changeFavorites(id: product_id)
        updateButtonImage()
    }
    
    @IBAction func clcikToEat(_ sender: Any) {
        Storage.eatFood(id: product_id)
        let alert = UIAlertController(title: "Success", message: "Food add to eaten", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true)
        updateDeleteButtonState()
    }
    
    @IBAction func clickToDelete(_ sender: Any) {
        Storage.deleteFood(id: product_id)
        let alert = UIAlertController(title: "Success", message: "Food delete from eaten", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true)
        updateDeleteButtonState()
    }
}
