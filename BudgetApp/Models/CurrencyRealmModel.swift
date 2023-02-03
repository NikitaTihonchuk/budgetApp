//
//  CurrencyRealmModel.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import Foundation
import RealmSwift

class CurrencyRealmModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var sum = 0
    @objc dynamic var image = ""
    @objc dynamic var id = ""

    var refill: [ReplenishmentRealmModel] {
        let allEarnings = RealmManager<ReplenishmentRealmModel>().read()
        let eachCurrencyEarnings = allEarnings.filter { $0.ownerID == self.id }
        return eachCurrencyEarnings
    }
    
    convenience init(sum: Int, image: String, name: String) {
        self.init()
        self.id = UUID().uuidString
        self.sum = sum
        self.image = image
        self.name = name
    }
    
}
