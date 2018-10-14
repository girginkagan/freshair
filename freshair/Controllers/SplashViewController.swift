//
//  SplashViewController.swift
//  freshair
//
//  Created by Kagan Girgin on 6/3/18.
//  Copyright © 2018 Kagan Girgin. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*DispatchQueue.main.asyncAfter(deadline: (.now() + .seconds(4)), execute: {
            
        })*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_UNIT) == nil{
            SaveToUserDefaultsUtil.setString(val: SaveToUserDefaultsUtil.METRIC_UNIT, key: SaveToUserDefaultsUtil.KEY_UNIT)
        }
        if SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_CITY) != nil{
            self.performSegue(withIdentifier: "weatherSegue", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "chooseCitySegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
