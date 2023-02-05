//
//  AnalyticsViewController.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit
import Charts
class AnalyticsViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Аналитика"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currency = RealmManager<CurrencyRealmModel>().read()
        customizeChart(dataPoints: currency)
    }
    
    private func customizeChart(dataPoints: [CurrencyRealmModel]) {
        var dataEntries: [ChartDataEntry] = []
          for eachCurrency in dataPoints {
              let dataEntry = PieChartDataEntry(value: Double(eachCurrency.sum), label: eachCurrency.name, data: eachCurrency.name as AnyObject)
            dataEntries.append(dataEntry)
          }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
          pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
          let pieChartData = PieChartData(dataSet: pieChartDataSet)
          let format = NumberFormatter()
          format.numberStyle = .none
          let formatter = DefaultValueFormatter(formatter: format)
          pieChartData.setValueFormatter(formatter)
          pieChartView.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }

}
