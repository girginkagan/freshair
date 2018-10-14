//
//  WeatherViewController.swift
//  freshair
//
//  Created by Kagan Girgin on 6/3/18.
//  Copyright © 2018 Kagan Girgin. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingsBarBtn: UIBarButtonItem!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var weatherForecastLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLbl: UILabel!
    var loadingView = UIView()
    var weatherDataResult: WeatherModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LoadingView
        loadingView.frame = tableView.frame
        view.addSubview(loadingView)
        tableView.tableFooterView = UIView()
    }
    
    func loadPage(){
        let city: String = SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_CITY) as! String
        let unit: String = SaveToUserDefaultsUtil.getString(key: SaveToUserDefaultsUtil.KEY_UNIT) as! String
        debugPrint(city)
        debugPrint(unit)
        var cityArr = city.components(separatedBy: ", ")
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=" + cityArr[0] + "&units=" + unit + "&APPID=7143dce5516e5adc2e1b97920dbd08cb").responseJSON{ response in
            self.weatherDataResult = try? JSONDecoder().decode(WeatherModel.self, from: response.data!)
            //debugPrint(response.data)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            
            if self.weatherDataResult != nil {
                self.cityLbl.text = cityArr[0]
                self.weatherForecastLbl.text = self.weatherDataResult?.list[0].weather[0].main
                var unitText : String = ""
                if unit == "imperial" {
                    unitText = " °F"
                }
                else if unit == "metric" {
                    unitText = " °C"
                }
                self.degreeLbl.text = String(format: "%.0f", (self.weatherDataResult?.list[0].main.temp)!) + unitText
            }
            self.loadingView.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AppDelegate.infoChanged || weatherDataResult == nil {
            loadingView.isHidden = false
            loadPage()
        }
        else{
            loadingView.isHidden = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.weatherDataResult != nil {
            return (self.weatherDataResult?.list.count)!
        }
        else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return topView.frame.height - navigationBar.frame.height - UIApplication.shared.statusBarFrame.height
        }
        else if indexPath.row == 1{
            return 100
        }
        else{
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if(indexPath.row == 0){
            cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell", for: indexPath)
        }
        else if indexPath.row == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "ListTopTableViewCell", for: indexPath)
            (cell as! ListTopTableViewCell).updateCell(model: self.weatherDataResult)
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath)
            (cell as! ListTableViewCell).updateCell(model: (self.weatherDataResult?.list[indexPath.row])!)
        }
        
        cell.selectionStyle = .none
        return cell
    }

}
