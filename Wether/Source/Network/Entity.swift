//
//  Entity.swift
//  Wether
//
//  Created by admin on 07.06.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import Foundation
import UIKit
import JSONJoy
import EZSwiftExtensions
import SwiftDate


public class WetherData:JSONJoy
{
    lazy var city: City = City()
    lazy var singleWetherDataArray: Array<SingleWeatherData> = Array<SingleWeatherData>()
    
    init(){}
    
    required public init(_ decoder: JSONDecoder) throws
    {
        guard let items = decoder["list"].array where items.count != 0 else
        {
            print("EmptyData")
            return
        }
        
        do{
            self.city = try City(decoder["city"])
        }
        catch JSONError.WrongType
        {
            print("Object \(decoder["city"]) have wrong type. Class - \(self)")
        }
        catch
        {
            print("Class - \(self) stop decoder")
        }
        
        for item in items
        {
            do
            {
                let data = try SingleWeatherData(item)
                self.singleWetherDataArray.append(data)
            }
            catch JSONError.WrongType
            {
                print("Object \(decoder["list"]) have wrong type. Class - \(self)")
            }
            catch
            {
                print("Class - \(self) stop decoder")
            }
        }
    }
}


public class City: JSONJoy
{
    var country: String?
    var id: String?
    var name: String?
    var coordinates: Coordinates?
    
    init(){}
    
    required public init(_ decoder: JSONDecoder) throws
    {
        self.country = decoder["country"].string
        self.id = decoder["id"].integer?.toString
        self.name = decoder["name"].string
        
        do{
             self.coordinates = try Coordinates(decoder["coord"])
        }
        catch JSONError.WrongType
        {
            print("Object \(decoder["coord"]) have wrong type. Class - \(self)")
        }
        catch
        {
            print("Class - \(self) stop decoder")
        }
    }
}


public class Coordinates: JSONJoy
{
    var latitude: Double?
    var latitudeString: String?
    
    var longitude: Double?
    var longitudeString: String?
    
    init(){}
    
    required public init(_ decoder: JSONDecoder) throws
    {
        print(decoder.description)
        
        self.latitude = decoder["lat"].double
        self.latitudeString = decoder["lat"].double?.toString
        
        self.longitude = decoder["lon"].double
        self.longitudeString = decoder["lon"].double?.toString
    }
}


public class SingleWeatherData: JSONJoy
{
    var clouds: String? //Облачность
    var dateSeconds: NSTimeInterval?
    var dateString: String?
    var humidity: String? //Влажость
    var temp: String? //Температура
    var description: String?
    var icon: String?
    var windSpeed: String?
    
    init(){}
    
    required public init(_ decoder: JSONDecoder) throws
    {        
        self.clouds = "\((decoder["clouds"]["all"].integer?.toString)!) %"
        self.dateSeconds = decoder["dt"].double
        self.dateString = NSDate(timeIntervalSince1970: decoder["dt"].double!).toString(format: "dd EEEE HH:mm")
        self.humidity = "\((decoder["main"]["humidity"].integer?.toString)!) %"
        self.temp = decoder["main"]["temp"].double?.toInt.toString
        self.description = decoder["weather"][0]["description"].string?.capitalizeFirst
        self.icon = "\(SERVER.API_URL.MAIN_ICON_URL)\(decoder["weather"][0]["icon"].string!).png"
        self.windSpeed =  "\((decoder["wind"]["speed"].double?.toString)!) м/с"
    }
}












