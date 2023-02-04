//
//  AdditionalInfoCurrencyTableViewCell.swift
//  BudgetApp
//
//  Created by Nikita on 4.02.23.
//

import UIKit

class AdditionalInfoCurrencyTableViewCell: UITableViewCell {
    static let id = String(describing: AdditionalInfoCurrencyTableViewCell.self)
    @IBOutlet weak var sumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func set(model: ReplenishmentRealmModel) {
        sumLabel.text = String(model.count)
    }
    
}
