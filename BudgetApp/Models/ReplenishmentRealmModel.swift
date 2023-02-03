//
//  ReplenishmentRealmModel.swift
//  BudgetApp
//
//  Created by Nikita on 3.02.23.
//

import Foundation
import RealmSwift

class ReplenishmentRealmModel: Object {
    @objc dynamic var count = 0
    @objc dynamic var ownerID = ""
    
    convenience init(count: Int, ownerID: String) {
        self.init()
        self.ownerID = ownerID
        self.count = count
    }
}
