//
//  GraphView.swift
//  Wether
//
//  Created by admin on 08.06.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import ScrollableGraphView

class GraphView: UIView
{
    
    //MARK: - LET
    
    //MARK: - VAR
    private var scrollGraphView = ScrollableGraphView()
    private var graphConstraints = [NSLayoutConstraint]()

    private var data: [Double] = []
    private var labels: [String] = []
    
    //MARK: - IBO
    
    //MARK: - INIT
    
    override func awakeFromNib()
    {
        self.initialize()
    }

    
    private func initialize()
    {
        self.scrollGraphView = ScrollableGraphView(frame: self.bounds)
        self.scrollGraphView = self.createDarkGraph(self.bounds)
        self.addSubview(self.scrollGraphView)
        self.setUpGraphViewConstrains()
    }
    
    
    func setData(data data: WetherData)
    {
        self.data.removeAll()
        self.labels.removeAll()
        
        for item in data.singleWetherDataArray
        {
            self.data.append(Double(item.temp!)!)
            self.labels.append(NSDate(timeIntervalSince1970: item.dateSeconds!).toString(format: "dd MMM HH:mm"))
        }

        self.scrollGraphView.setData(self.data, withLabels: self.labels)
        self.scrollGraphView.layoutSubviews()
    }
    
    private func createDarkGraph(frame: CGRect) -> ScrollableGraphView
    {
        let graphView = ScrollableGraphView(frame: frame)
        
        graphView.backgroundFillColor = UIColor(hexString:"#333333")!
        
        graphView.lineWidth = 1
        graphView.lineColor = UIColor(hexString: "#777777")!
        graphView.lineStyle = ScrollableGraphViewLineStyle.Smooth
        
        graphView.shouldFill = true
        graphView.fillType = ScrollableGraphViewFillType.Gradient
        graphView.fillColor = UIColor(hexString: "#555555")!
        graphView.fillGradientType = ScrollableGraphViewGradientType.Linear
        graphView.fillGradientStartColor = UIColor(hexString: "#555555")!
        graphView.fillGradientEndColor = UIColor(hexString: "#444444")!
        
        graphView.dataPointSpacing = 110
        graphView.dataPointSize = 2
        graphView.dataPointFillColor = UIColor.whiteColor()
        
        graphView.referenceLineLabelFont = UIFont.boldSystemFontOfSize(8)
        graphView.referenceLineColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.whiteColor()
        graphView.numberOfIntermediateReferenceLines = 5
        graphView.dataPointLabelColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.adaptAnimationType = ScrollableGraphViewAnimationType.Elastic
        graphView.animationDuration = 1.5
        graphView.rangeMax = 50
        graphView.shouldRangeAlwaysStartAtZero = true
        graphView.topMargin = 80
        
        return graphView
    }
    
    private func setUpGraphViewConstrains()
    {
        self.scrollGraphView.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()
        
        let topConstraint = NSLayoutConstraint(item: self.scrollGraphView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.scrollGraphView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.scrollGraphView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.scrollGraphView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        
        //let heightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        
        graphConstraints.append(topConstraint)
        graphConstraints.append(bottomConstraint)
        graphConstraints.append(leftConstraint)
        graphConstraints.append(rightConstraint)
        
        //graphConstraints.append(heightConstraint)
        
        self.addConstraints(graphConstraints)
    }
}
