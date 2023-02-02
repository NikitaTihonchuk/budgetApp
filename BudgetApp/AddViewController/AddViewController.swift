//
//  AddViewController.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        //tableView.delegate = self
        //tableView.dataSource = self
    }

    private func registerCell() {
        let nib = UINib(nibName: TableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TableViewCell.id)
    }

}

/*extension AddViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}*/
