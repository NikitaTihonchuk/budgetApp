//
//  AnalyticsViewController.swift
//  BudgetApp
//
//  Created by Nikita on 2.02.23.
//

import UIKit
import Charts
class AnalyticsViewController: UIViewController {

   
    let currency = RealmManager<CurrencyRealmModel>().read()
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Аналитика"
       // customizeChart(dataPoints: currency)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeChart(dataPoints: currency)
    }
    
    func customizeChart(dataPoints: [CurrencyRealmModel]) {
        var dataEntries: [ChartDataEntry] = []
          for eachCurrency in dataPoints {
              let dataEntry = PieChartDataEntry(value: Double(eachCurrency.sum), label: eachCurrency.name, data: eachCurrency.name as AnyObject)
            dataEntries.append(dataEntry)
          }
          // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
          pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
          // 3. Set ChartData
          let pieChartData = PieChartData(dataSet: pieChartDataSet)
          let format = NumberFormatter()
          format.numberStyle = .none
          let formatter = DefaultValueFormatter(formatter: format)
          pieChartData.setValueFormatter(formatter)
          // 4. Assign it to the chart’s data
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
    
    func setupPieChart() {
        pieChartView.drawHoleEnabled = false
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = false
        pieChartView.isUserInteractionEnabled = false
        //pieChartView.legend.enabled = false
    }

}
