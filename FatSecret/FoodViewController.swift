//
//  FoodViewController.swift
//  FatSecret
//
//  Created by user184905 on 12/7/20.
//

import UIKit

class FoodViewController: UIViewController, UICollectionViewDataSource {
    
    private let reuseIdentifier = "CELL_ID"
    private let items = ["Swift", "Xcode IDE", "iOS Development"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodViewCell
                
        cell.backgroundColor = UIColor.systemPink
                
        cell.label.text = self.items[indexPath.row]
            
        return cell
        
    }
}
