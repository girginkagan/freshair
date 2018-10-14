//
//  SettingsViewController.swift
//  freshair
//
//  Created by Kagan Girgin on 6/3/18.
//  Copyright © 2018 Kagan Girgin. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var closeBtn: UIBarButtonItem!
    @IBOutlet weak var changeCityBtn: UIButton!
    @IBOutlet weak var celciusView: UIView!
    @IBOutlet weak var fahrenheitView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        closeBtn.target = self
        closeBtn.action = #selector(closeBtnClicked)
        tableView.allowsSelection = false
        changeCityBtn.addTarget(self, action: #selector(changeCityTapped), for: .touchUpInside)
        
        let celciusTapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(celciusViewTapped))
        celciusView.addGestureRecognizer(celciusTapGesture)
        
        let fahrenheitTapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fahrenheitViewTapped))
        fahrenheitView.addGestureRecognizer(fahrenheitTapGesture)
        
        initViews()
    }
    
    func initViews(){
        if SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_UNIT) as! String == SaveToUserDefaultsUtil.METRIC_UNIT{
            celciusView.backgroundColor = UIColor(red: 59/255, green: 43/255, blue: 143/255, alpha: 1)
            fahrenheitView.backgroundColor = UIColor(red: 77/255, green: 63/255, blue: 181/255, alpha: 1)
        }
        else{
            fahrenheitView.backgroundColor = UIColor(red: 59/255, green: 43/255, blue: 143/255, alpha: 1)
            celciusView.backgroundColor = UIColor(red: 77/255, green: 63/255, blue: 181/255, alpha: 1)
        }
    }
    
    @objc func celciusViewTapped(){
        celciusView.backgroundColor = UIColor(red: 59/255, green: 43/255, blue: 143/255, alpha: 1)
        fahrenheitView.backgroundColor = UIColor(red: 77/255, green: 63/255, blue: 181/255, alpha: 1)
        SaveToUserDefaultsUtil.setString(val: SaveToUserDefaultsUtil.METRIC_UNIT, key: SaveToUserDefaultsUtil.KEY_UNIT)
        AppDelegate.infoChanged = true
    }
    
    @objc func fahrenheitViewTapped(){
        fahrenheitView.backgroundColor = UIColor(red: 59/255, green: 43/255, blue: 143/255, alpha: 1)
        celciusView.backgroundColor = UIColor(red: 77/255, green: 63/255, blue: 181/255, alpha: 1)
        SaveToUserDefaultsUtil.setString(val: SaveToUserDefaultsUtil.IMPERIAL_UNIT, key: SaveToUserDefaultsUtil.KEY_UNIT)
        AppDelegate.infoChanged = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //makeNavigationBarPurple()
        navigationItem.title = "Settings"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @objc func changeCityTapped(){
        navigationItem.title = ""
        performSegue(withIdentifier: "changeCitySegue", sender: self)
    }
    
    func makeNavigationBarPurple(){
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barTintColor = UIColor(red: 77/255, green: 63/255, blue: 181/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func closeBtnClicked(){
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
