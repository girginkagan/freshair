//
//  SaveToUserDefaultsUtil.swift
//  freshair
//
//  Created by Kagan Girgin on 6/3/18.
//  Copyright © 2018 Kagan Girgin. All rights reserved.
//

import Foundation

public class SaveToUserDefaultsUtil{
    public static var KEY_CITY : String = "KEY_CITY"
    public static var KEY_UNIT : String = "KEY_UNIT"
    public static var METRIC_UNIT : String = "metric"
    public static var IMPERIAL_UNIT : String = "imperial"
    
    public static func getString(key: String) -> Any?{
        return UserDefaults.standard.string(forKey: key)
    }
    
    public static func setString(val: String, key: String){
        UserDefaults.standard.setValue(val, forKey: key)
    }
}
