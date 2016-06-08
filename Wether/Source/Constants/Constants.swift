//
//  Constants.swift
//  Wether
//
//  Created by admin on 07.06.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import Foundation


public struct SERVER
{
    public struct API_URL
    {
        static let MAIN_API_URL = "http://api.openweathermap.org"
        static let MAIN_ICON_URL = "http://openweathermap.org/img/w/"
    }
    
    public struct METHODS
    {
        static let FIVE_DAY_WETHER = "/data/2.5/forecast?"
    }
}


public struct API_KEYS
{
    static let WETHER_API_KEY = "0c45622ef7046cd6e18eb1681c43d1ad"
}


public struct TABLE_VIEW_CELL_ID
{
    static let MAIN_CELL = "MainTableViewCell"
}