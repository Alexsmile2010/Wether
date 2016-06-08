//
//  MainViewController.swift
//  Wether
//
//  Created by admin on 08.06.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import VGParallaxHeader


class MainViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate
{

    //MARK: - LET
    
    //MARK: - VAR
    
    private var graphHeaderView = GraphView.loadFromNibNamed(GraphView.className) as! GraphView
    private var wetherData: WetherData?
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    //MARK: - IBO
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - INIT
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setUpHeaderView()
        self.setUpRefreshControl()
        self.tableView.registerCell()
        
        self.loadData()
    }
    
    private func loadData()
    {
        let request = GetWetherByFiveDaysRequest()
        request.city = "Kiev"
        request.finalizeParams()
        request.runRequest { (response) in
            
            if response.success
            {
                self.wetherData = response.wetherData
                self.graphHeaderView.setData(data: self.wetherData!)
                self.tableView.reloadData()
            }
            
            if self.refreshControl.refreshing == true
            {
                 self.refreshControl.endRefreshing()
            }
        }
    }
    
    func refresh(sender:AnyObject) {
        self.loadData()
    }
    
    
    private func setUpRefreshControl()
    {
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(MainViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    private func setUpHeaderView()
    {
        self.tableView.setParallaxHeaderView(self.graphHeaderView, mode: .Top, height: 350)
        self.tableView.parallaxHeader.stickyViewPosition = .Top
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //MARK: - TABLE_VIEW
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.wetherData != nil
        {
            return (self.wetherData?.singleWetherDataArray.count)!
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(TABLE_VIEW_CELL_ID.MAIN_CELL, forIndexPath: indexPath) as! MainTableViewCell
        
        cell.setData(data: (self.wetherData?.singleWetherDataArray[indexPath.row])!)
        
        return cell
    }

    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        self.tableView.shouldPositionParallaxHeader()
    }

    

}
