//
//  ListTableViewCell.swift
//  freshair
//
//  Created by Kagan Girgin on 6/3/18.
//  Copyright © 2018 Kagan Girgin. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var forecastImg: UIImageView!
    @IBOutlet weak var forecastText: UILabel!
    @IBOutlet weak var degreeText: UILabel!
    @IBOutlet weak var dayText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func updateCell(model: WeatherList){
        var unitText : String = ""
        if (SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_UNIT) as! String) == "imperial" {
            unitText = " °F"
        }
        else if (SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_UNIT) as! String) == "metric" {
            unitText = " °C"
        }
        degreeText.text = String(format: "%.0f", model.main.temp) + unitText
        dayText.text = model.dtTxt.substring(to: model.dtTxt.index(model.dtTxt.startIndex, offsetBy: 10))
//        var timeString : String = listFiltered![index].dtTxt.substring(from: listFiltered![index].dtTxt.index(listFiltered![index].dtTxt.endIndex, offsetBy: -8))
//        timeLabel.text = timeString.substring(to: timeString.index(timeString.startIndex, offsetBy: 5))
        forecastText.text = model.weather[0].main
    }
}
