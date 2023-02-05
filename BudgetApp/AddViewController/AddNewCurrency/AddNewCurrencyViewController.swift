//
//  AddNewCurrencyViewController.swift
//  BudgetApp
//
//  Created by Nikita on 5.02.23.
//

import UIKit

class AddNewCurrencyViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sumTextField: UITextField!
    var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func addCurrencyDidTap(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        let sum = Int(sumTextField.text ?? "0")
        guard let sum else { return }
        let model = CurrencyRealmModel(sum: sum, image: "smiley.fill", name: name)
        let transaction = ReplenishmentRealmModel(count: model.sum, ownerID: model.id)
        RealmManager<CurrencyRealmModel>().write(object: model)
        RealmManager<ReplenishmentRealmModel>().write(object: transaction)
        completionHandler?()
        dismiss(animated: true)
    }
    

}
