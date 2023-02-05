//
//  AddViewController.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit

final class AddViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let arrayOfCur = [CurrencyRealmModel]()
    var id = ""
    private var currencyArray = RealmManager<CurrencyRealmModel>().read()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = true
        title = "Ваши сбережения"
        addToRealm()
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currencyArray = RealmManager<CurrencyRealmModel>().read()
        tableView.reloadData()
    }
    
    @objc func addTapped() {
        let vc = AddNewCurrencyViewController(nibName: "AddNewCurrencyViewController", bundle: nil)
        if let sheet = vc.sheetPresentationController {
             sheet.detents = [.medium()]
             sheet.preferredCornerRadius = 50
             sheet.prefersScrollingExpandsWhenScrolledToEdge = true
             sheet.prefersEdgeAttachedInCompactHeight = true
             sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
         }
        present(vc, animated: true)
        vc.completionHandler = { [weak self] in
            self?.currencyArray = RealmManager<CurrencyRealmModel>().read()
            self?.tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currency = currencyArray[indexPath.row]
            RealmManager<CurrencyRealmModel>().delete(object: currency)
            currencyArray = RealmManager<CurrencyRealmModel>().read()
            tableView.reloadData()
        }
    }
}
