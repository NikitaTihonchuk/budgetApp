//
//  AddViewController.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let arrayOfCur = [CurrencyRealmModel]()
    var id = ""
    var currencyArray = RealmManager<CurrencyRealmModel>().read()
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = true
        title = "Ваши сбережения"
        addToRealm()
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currencyArray = RealmManager<CurrencyRealmModel>().read()
        tableView.reloadData()
    }
    
   
    private func addToRealm() {
        if currencyArray.isEmpty {
            let arrayOfCur: [CurrencyRealmModel] = [CurrencyRealmModel(sum: 0, image: "dollarsign.circle.fill", name: "Dollar"), CurrencyRealmModel(sum: 0, image: "tengesign.circle.fill", name: "Tenge"), CurrencyRealmModel(sum: 0, image: "rublesign.circle.fill", name: "Ruble"), CurrencyRealmModel(sum: 0, image: "bitcoinsign.circle.fill", name: "Bitcoin"), CurrencyRealmModel(sum: 0, image: "eurosign.circle.fill", name: "Euro")]
            
            for currency in arrayOfCur {
                RealmManager<CurrencyRealmModel>().write(object: currency)
            }
        }
    }
   
    private func registerCell() {
        let nib = UINib(nibName: TableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TableViewCell.id)
    }

}

extension AddViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath)
        guard let currencyCell = cell as? TableViewCell else { return cell }
        currencyCell.set(model: currencyArray[indexPath.row])
        return currencyCell
    }
}

extension AddViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencyArray[indexPath.row]
        let vc = AdditionalInfoCurrencyViewController(nibName: "AdditionalInfoCurrencyViewController", bundle: nil)
        vc.model = currency
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
