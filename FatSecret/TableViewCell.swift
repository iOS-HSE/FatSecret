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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
