//
//  TableViewCell.swift
//  TodoList
//
//  Created by Michael Chernousov on 08.02.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet weak var dateTextLabel: UILabel!
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    var onCheck: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
//
