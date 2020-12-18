//
//  TableViewCell.swift
//  FatSecret
//
//  Created by user184905 on 12/12/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var doseText: UILabel!
    @IBOutlet weak var caloriesText: UILabel!
    @IBOutlet weak var fatText: UILabel!
    @IBOutlet weak var carbsText: UILabel!
    @IBOutlet weak var proteinText: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var isFavorite = false {
        didSet { updateButtonImage() }
    }
    var id : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        Storage.changeFavorites(id: id)
    }
}
