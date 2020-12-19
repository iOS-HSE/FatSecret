import UIKit
import FatSecretSwift
import Charts

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let PRODUCT_SCREEN_IDENTIFIER: String = "ProductScreen"
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var eatenFood : [Food] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getTodayEatenFood().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let food = getTodayEatenFood()[indexPath.row]
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
        let product = getTodayEatenFood()[indexPath.row]
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
        updateEatenFood()
        updatePage()
    }
    
    func updatePage(){
        var dataEntries : [ChartDataEntry] = []
        let protein = getTodayProtein()
        let carbo = getTodayCarbohydrates()
        let fat = getTodayFat()
        if protein == 0 && carbo == 0 && fat == 0 {
            dataEntries.append(PieChartDataEntry(value: 1, label: "You don't eat today"))
        } else {
            dataEntries.append(PieChartDataEntry(value: protein, label: "protein"))
            dataEntries.append(PieChartDataEntry(value: carbo, label: "carbohydrates"))
            dataEntries.append(PieChartDataEntry(value: fat, label: "fat"))
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = [.systemPink, .systemBlue , .systemPurple]
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        pieChart.legend.enabled = false
        
        let calories = Int(getTodayCalories())
        caloriesLabel.text = String(calories) + " / 2700 kilocalories"
        tableView.reloadData()
    }
    
    func updateEatenFood(){
        let isIdInEatenFood = {(id : String) -> Bool in
            for item in self.eatenFood{
                if item.id == id {
                    return true
                }
            }
            return false
        }
    
        for food in Storage.eatenFood {
            if !isIdInEatenFood(food["id"]!){
                Storage.fatSecretClient.getFood(id: food["id"]!) { food in
                    self.eatenFood.append(food)
                    DispatchQueue.main.async {
                        self.updatePage()
                    }
                }
            }
        }
    }
    
    func getFoodById(id: String) -> Food?{
        for food in eatenFood{
            if food.id == id{
                return food
            }
        }
        return nil
    }
        
    func getTodayEatenFood() -> [Food]{
        var eatenTodayFood : [Food] = []
        let today : String = Storage.dateFormatter.string(from: Date())
        for food in Storage.eatenFood{
            if food["date"] == today {
                guard let foodObj = getFoodById(id: food["id"]!) else { continue }
                eatenTodayFood.append(foodObj)
            }
        }
        return eatenTodayFood
    }
    
    func getDoubleByString(str: String) -> Double?{
        var newStr = ""
        for char in str{
            if !(char.isNumber || char.isPunctuation){
                break
            }
            newStr.append(char)
        }
        return Double(newStr)
        
    }
    
    func getTodayCalories() -> Double{
        var sumOfCalories = 0.0
        for food in getTodayEatenFood(){
            guard let calories = getDoubleByString(str: food.servings![0].calories ?? "") else { continue }
            sumOfCalories += calories
        }
        return sumOfCalories
    }
    
    func getTodayFat() -> Double{
        var sumOfFat = 0.0
        for food in getTodayEatenFood(){
            guard let fat = getDoubleByString(str: food.servings![0].fat ?? "") else { continue }
            sumOfFat += fat
        }
        return sumOfFat
    }
    
    func getTodayCarbohydrates() -> Double{
        var sumOfCarbohydrates = 0.0
        for food in getTodayEatenFood(){
            guard let carbohydrate = getDoubleByString(str: food.servings![0].carbohydrate ?? "") else { continue }
            sumOfCarbohydrates += carbohydrate
        }
        return sumOfCarbohydrates
    }
    
    func getTodayProtein() -> Double{
        var sumOfProtein = 0.0
        for food in getTodayEatenFood(){
            guard let protein = getDoubleByString(str: food.servings![0].protein ?? "") else { continue }
            sumOfProtein += protein
        }
        return sumOfProtein
    }
    
}
