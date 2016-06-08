//
//  ResponseHandler.swift
//  Wether
//
//  Created by admin on 07.06.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import Foundation
import JSONJoy
import Alamofire
import Async

public class ResponceHandler
{
    var success : Bool = false
    var errorMessage: String = ""
    var response: AnyObject?
    
    lazy var wetherData = WetherData()
    
    public func decodeRequest(){}
}


public class GetWetherByFiveDaysResponse: ResponceHandler
{
    public override init()
    {
        super.init()
    }
    
    public override func decodeRequest()
    {
        do
        {
            self.wetherData = try WetherData(JSONDecoder(self.response!))
            self.success = true
        }
        catch JSONError.WrongType
        {
            print("Object \(JSONDecoder(self.response!)) have wrong type. Class - \(self)")
        }
        catch
        {
            print("Class - \(self) stop decoder")
        }
    }
}