//
//  NetworkManager.swift
//  Wether
//
//  Created by admin on 07.06.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import Foundation
import Alamofire
import Async

public class NetworkManager
{
    var alamoFireManager : Alamofire.Manager?
    var serverAdressSring =  SERVER.API_URL.MAIN_API_URL
    var requestMethod = ""
    var paramsString = ""
    var usingHud: Bool = true
    var city = ""
    
    
    //MARK: MAIN_OPTIONS
    
    let lang = "ru"
    let units = "metric"
    let mode = "json"
    
    
    
    init()
    {
        if self.alamoFireManager == nil
        {
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.timeoutIntervalForRequest = 30 // seconds timeout
            self.alamoFireManager = Alamofire.Manager(configuration: configuration)
        }
    }
    
    
    public func finalizeParams(){}
    
    public func runGETRequest(handler: ResponceHandler ,compleate: ((ResponceHandler) -> Void))
    {
        print(self.serverAdressSring)
        
        if usingHud { self.showHUD() }
        
        self.alamoFireManager!.request(.GET, self.serverAdressSring).response { (_, _, data, error) -> Void in
            
            if error == nil
            {
                handler.response = data!
                handler.decodeRequest()
                
                compleate(handler)
            }
            else
            {
                print(error)
            }
            
            
            if self.usingHud
            {
                self.hideHUD()
            }
        }
    }
    
    public func runPOSTRequest(handler: ResponceHandler ,compleate: ((ResponceHandler) -> Void))
    {
        print(self.serverAdressSring)
        print(self.paramsString)
        
        if usingHud { self.showHUD() }
        
        self.alamoFireManager!.request(.POST, self.serverAdressSring, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            mutableRequest.HTTPBody = self.paramsString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            return (mutableRequest, nil)
        })).response {(_, _, data, error) -> Void in
            
            if error == nil
            {
                handler.response = data!
                handler.decodeRequest()
                
                compleate(handler)
            }
            else
            {
                print(error)
            }
            
            if self.usingHud
            {
                self.hideHUD()
            }
        }
    }
}


public class GetWetherByFiveDaysRequest: NetworkManager
{
    public override init()
    {
        super.init()
        
        self.requestMethod = SERVER.METHODS.FIVE_DAY_WETHER
        self.serverAdressSring = self.createUrl()
    }
    
    private func createUrl() -> String
    {
        return self.serverAdressSring + self.requestMethod
    }
    
    override public func finalizeParams()
    {
        self.serverAdressSring = "\(self.serverAdressSring)lang=\(self.lang)&units=\(self.units)&q=\(self.city)&mode=\(self.mode)&APPID=\(API_KEYS.WETHER_API_KEY)"
    }
    
    public func runRequest(compleate: ((ResponceHandler) -> Void))
    {
        Async.background { () -> Void in
            let handler = GetWetherByFiveDaysResponse()
            self.runGETRequest(handler, compleate: { (response) -> Void in
                
                compleate(response)
                
            })
        }
    }
}

