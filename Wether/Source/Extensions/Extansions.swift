//
//  Extansions.swift
//  Wether
//
//  Created by admin on 07.06.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import Foundation
import UIKit
import Async
import MBProgressHUD
import EZSwiftExtensions

//MARK: - NETWORKMANAGER

extension NetworkManager
{
    public enum RequestType: String
    {
        case POST,GET
    }
    
    public func showHUD()
    {
        Async.main { () -> Void in
            if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window
            {
                MBProgressHUD.showHUDAddedTo(window, animated: true)
            }
        }
    }
    
    public func hideHUD()
    {
        Async.main { () -> Void in
            if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window
            {
                MBProgressHUD.hideAllHUDsForView(window, animated: true)
            }
        }
    }
}

//MARK: - TABLE_VIEW

extension UITableView
{
    public func registerCell()
    {
        self.registerNib(UINib(nibName: MainTableViewCell.className, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL_ID.MAIN_CELL)
    }
}


//MARK: - UIVIEW

extension UIView
{
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView?
    {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}