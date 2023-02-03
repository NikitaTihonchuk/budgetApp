//
//  TableViewCell.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let id = String(describing: TableViewCell.self)
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencySum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func set(model: CurrencyRealmModel) {
        currencyImage.image = UIImage(systemName: model.image)!
        currencyName.text = model.name
        currencySum.text = String(model.sum)
    }
    
}
