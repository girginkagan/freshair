//
//  HorizontalListCollectionViewCell.swift
//  freshair
//
//  Created by Kagan Girgin on 6/6/18.
//  Copyright © 2018 Kagan Girgin. All rights reserved.
//

import UIKit

class HorizontalListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var degreeText: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var listFiltered: [WeatherList]?
    public func updateCell(listFiltered: [WeatherList]?, index: Int){
        self.listFiltered = listFiltered
        image.image = UIImage(named: "clear_s")
        var unitText : String = ""
        if (SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_UNIT) as! String) == "imperial" {
            unitText = " °F"
        }
        else if (SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_UNIT) as! String) == "metric" {
            unitText = " °C"
        }
        degreeText.text = String(format: "%.0f", listFiltered![index].main.temp) + unitText
        var timeString : String = listFiltered![index].dtTxt.substring(from: listFiltered![index].dtTxt.index(listFiltered![index].dtTxt.endIndex, offsetBy: -8))
        timeLabel.text = timeString.substring(to: timeString.index(timeString.startIndex, offsetBy: 5))
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
