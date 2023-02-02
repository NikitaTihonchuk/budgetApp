//
//  AddCategoryCollectionViewCell.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit

class AddCategoryCollectionViewCell: UICollectionViewCell {

    static let id = String(describing: AddCategoryCollectionViewCell.self)
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func set(image: UIImage) {
        backgroundImage.image = image
    }
}
