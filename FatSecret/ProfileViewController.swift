//
//  ProfileViewController.swift
//  FatSecret
//
//  Created by user184905 on 12/19/20.
//

import UIKit
import FatSecretSwift
import Charts

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var caloriesLabel: UILabel!
    var eatenFood : [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateEatenFood()
        updatePage()
    }
    
    func updatePage(){
//        pieChart.setValue(getTodayCalories(), forKey: "calories")
        var dataEntries : [ChartDataEntry] = []
        let protein = getTodayProtein()
        let carbo = getTodayCarbohydrates()
        let fat = getTodayFat()
        dataEntries.append(PieChartDataEntry(value: protein, label: "protein"))
        dataEntries.append(PieChartDataEntry(value: carbo, label: "carbohydrates"))
        dataEntries.append(PieChartDataEntry(value: fat, label: "fat"))
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = [.systemPink, .systemBlue , .systemPurple]
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        pieChart.legend.enabled = false
        
        caloriesLabel.text = String(Int(getTodayCalories())) + " / 2700 kilocalories"
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
    
        for id in Storage.favoritesFood {
            if !isIdInEatenFood(id){
                Storage.fatSecretClient.getFood(id: id) { food in
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

