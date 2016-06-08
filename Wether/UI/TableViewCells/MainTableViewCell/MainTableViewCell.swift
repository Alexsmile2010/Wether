//
//  MainTableViewCell.swift
//  Wether
//
//  Created by admin on 08.06.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import Nuke
import UIImageViewWithWords

class MainTableViewCell: UITableViewCell
{

    //MARK: - LET
    
    //MARK: - VAR
    
    //MARK: - IBO
    @IBOutlet weak var cloudsImageView: UIImageView!
    @IBOutlet weak var temperatureImageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudlyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var windPowerLabel: UILabel!
    @IBOutlet weak var skyStateLabel: UILabel!
    //MARK: - INIT
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data data:SingleWeatherData)
    {
        self.cloudsImageView.nk_setImageWith(NSURL(string: data.icon!)!)
        self.temperatureImageView.imageWithString(word: "\(data.temp!)°C", color: self.imageColor(temperature: data.temp!))
        self.humidityLabel.text = data.humidity
        self.cloudlyLabel.text = data.clouds
        self.dateLabel.text = data.dateString
        self.windPowerLabel.text = data.windSpeed
        self.skyStateLabel.text = data.description
    }
    
    
    private func imageColor(temperature temperature: String) -> UIColor
    {
        let tepmFloat = Double(temperature)!// temperature.toDouble()!
        
        switch tepmFloat
        {
        case -40.0...0.1:
            return UIColor(hexString: "348CFF")!
            
        case 0.0...10.0:
            return UIColor(hexString: "B1DDFF")!
            
        case 10.1...13.0:
            return UIColor(hexString: "F0D200")!
            
        case 13.1...18.0:
            return UIColor(hexString: "F0BE00")!
            
        case 18.1...21.0:
            return UIColor(hexString: "F6A506")!
            
        case 21.1...25.0:
            return UIColor(hexString: "F67A03")!
            
        case 25.1...30.0:
            return UIColor(hexString: "F6521C")!
            
        case 31.1...40.0:
            return UIColor(hexString: "F62F2B")!
            
        default:
            return UIColor(hexString: "F66FDF")!
        }
    }
    
}
