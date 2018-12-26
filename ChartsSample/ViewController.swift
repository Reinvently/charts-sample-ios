//
//  ViewController.swift
//  ChartsInvestigation
//
//  Created by Konstantine Dementiev on 12/24/18.
//  Copyright © 2018 Konstantine Dementiev. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    fileprivate struct Default {
        static let elementsCount = 300000;
        static let visibleElementsCount = 350.0;
        
        static let verticalMin = -4.0;
        static let verticalMax = 4.0;
    }

    @IBOutlet weak var lineChartView: LineChartView!
    
    private var updateTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply initial data.
        lineChartView.data = prepareInitialData()

        // Configure chart view default appearance.
        configureDefault(chartView: lineChartView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateTimer?.invalidate()
    }
    
    private func configureDefault(chartView: LineChartView) {
        
        chartView.xAxis.drawLabelsEnabled = false
        chartView.getAxis(.right).enabled = false
        
        chartView.getAxis(.left).axisMaximum = Default.verticalMax
        chartView.getAxis(.left).axisMinimum = Default.verticalMin
        
        chartView.setVisibleXRangeMaximum(Default.visibleElementsCount)
    }
    
    func prepareInitialData() -> LineChartData {
        
        let points = randomPoints(count: Default.elementsCount)
        let dataSet = LineChartDataSet(values: points, label: "")
        
        dataSet.drawCirclesEnabled = false
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        dataSet.drawFilledEnabled = false
        
        dataSet.setColor(UIColor.blue)
        
        return LineChartData(dataSet: dataSet)
    }
}

extension ViewController {
    
    fileprivate func randomPoints(count: Int) -> [ChartDataEntry] {
        var dataEntryList = [ChartDataEntry]()
        
        for i in 1...count {
            let x = Double(i)
            let y = Double(Int(arc4random() % 100) - 50) / 100.0
            dataEntryList.append(ChartDataEntry(x: x, y: y))
        }
        
        return dataEntryList
    }
}
