//
//  BillViewController.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit

class BillViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var sheetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetButton.layer.masksToBounds = true
        sheetButton.layer.cornerRadius = 35
    }

    
   private func showMyViewControllerInACustomizedSheet() {
        let viewControllerToPresent = AddCategoryViewController(nibName: "AddCategoryViewController", bundle: nil)
       viewControllerToPresent.number = counterLabel.text!
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    

    @IBAction func sumNumberToCounterDidTap(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            if self.counterLabel.text != "0" {
                self.counterLabel.text = String("\(self.counterLabel.text!)\(sender.tag - 1000)")
            } else {
                self.counterLabel.text = String(sender.tag - 1000)
            }
        }
    }
    
    @IBAction func moveToSettingsButton(button sender: UIButton) {
        if self.counterLabel.text != "0" {
            showMyViewControllerInACustomizedSheet()
        }
    }
    
    @IBAction func deleteLastNumberFromCounter(_ sender: UIButton) {
        if self.counterLabel.text == "0" {
            
        } else {
            if self.counterLabel.text!.count > 1 {
                self.counterLabel.text!.removeLast()
            } else {
                self.counterLabel.text = "0"
            }
        }
    }
    
    
}
