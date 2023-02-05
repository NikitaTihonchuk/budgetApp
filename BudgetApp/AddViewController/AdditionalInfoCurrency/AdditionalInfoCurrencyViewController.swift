//
//  AdditionalInfoCurrencyViewController.swift
//  BudgetApp
//
//  Created by Nikita on 4.02.23.
//

import UIKit

final class AdditionalInfoCurrencyViewController: UIViewController {

    @IBOutlet weak var nameCurrency: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var replenishmentArray = [ReplenishmentRealmModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    var model: CurrencyRealmModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        nameCurrency.text = model?.name
        setValue()
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setValue() {
        replenishmentArray = RealmManager<ReplenishmentRealmModel>().read()
        replenishmentArray = replenishmentArray.filter({$0.ownerID == model?.id})
        print(replenishmentArray.count)
        tableView.reloadData()
    }

    private func registerCell() {
        let nib = UINib(nibName: AdditionalInfoCurrencyTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AdditionalInfoCurrencyTableViewCell.id)
    }

}

extension AdditionalInfoCurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replenishmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalInfoCurrencyTableViewCell.id, for: indexPath)
        guard let additionalCell = cell as? AdditionalInfoCurrencyTableViewCell else { return cell }
        print(replenishmentArray[indexPath.row])
        additionalCell.set(model: replenishmentArray[indexPath.row])
        return additionalCell
    }
    
    
}
