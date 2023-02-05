//
//  AddCategoryViewController.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var number = ""
    let currencyArray: [CurrencyRealmModel] = RealmManager<CurrencyRealmModel>().read()
    var closure: ((CurrencyRealmModel, String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        registerCells()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    
    private func registerCells() {
        let nib = UINib(nibName: AddCategoryCollectionViewCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: AddCategoryCollectionViewCell.id)
    }
    
   
    
    @IBAction func deleteSheetController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func makeYourCategory(_ sender: UIButton) {
    }
    
}

extension AddCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currency = currencyArray[indexPath.row - 1]
         let changeCurrency = currencyArray.filter { $0.name == currency.name }.first
        guard let changeCurrency else { return }
        print(currency.sum)
        let transaction = ReplenishmentRealmModel(count: Int(number)!, ownerID: changeCurrency.id)
        RealmManager<ReplenishmentRealmModel>().write(object: transaction)
        
        RealmManager<CurrencyRealmModel>().update { realm in
            try? realm.write({
                changeCurrency.sum = currency.sum + Int(self.number)!
            })
        }
        
        //navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
        }
    }

 
extension AddCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencyArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
            case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCategoryCollectionViewCell.id, for: indexPath)
            guard let currencyCell = cell as? AddCategoryCollectionViewCell else { return cell }
            currencyCell.set(image: UIImage(systemName: "plus.circle.fill")!.withTintColor(.black))
            return currencyCell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCategoryCollectionViewCell.id, for: indexPath)
            guard let currencyCell = cell as? AddCategoryCollectionViewCell else { return cell }
            currencyCell.set(image: UIImage(systemName: currencyArray[indexPath.row - 1].image)!)
            //currencyCell.backgroundImage.image?.withTintColor(.black)
            return currencyCell
        }
        
    }
}

extension AddCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 25.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        let cellCount = 4.0
        let width = (screen.bounds.width - (inset * (cellCount + 1)))  / cellCount
        return CGSize(width: width, height: width)
    }
}
