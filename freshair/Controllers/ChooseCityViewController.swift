//
//  ChooseCityViewController.swift
//  freshair
//
//  Created by Kagan Girgin on 6/3/18.
//  Copyright © 2018 Kagan Girgin. All rights reserved.
//

import UIKit
import Alamofire

class ChooseCityViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var tblArray = [String]()
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //makeNavigationBarWhite()
    }
    
    func makeNavigationBarWhite(){
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 77/255, green: 63/255, blue: 181/255, alpha: 1)]
        navigationController?.navigationBar.tintColor = UIColor(red: 77/255, green: 63/255, blue: 181/255, alpha: 1)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count)! > 2 {
            Alamofire.request("http://gd.geobytes.com/AutoCompleteCity?callback=?&q=" + self.searchBar.text!).responseJSON { response in
                let array = String(data: response.data!, encoding: .utf8)?.replacingOccurrences(of: "?([", with: "").replacingOccurrences(of: "]);", with: "").components(separatedBy: "\",")
                self.tblArray = array!
                self.tableView.reloadData()
            }
        }
        else{
            self.tblArray = [String]()
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityListTableViewCell", for: indexPath) as! CityListTableViewCell
        
        cell.cityName.text = self.tblArray[indexPath.row].replacingOccurrences(of: "\"", with: "")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        SaveToUserDefaultsUtil.setString(val: tblArray[indexPath.row].replacingOccurrences(of: "\"", with: ""), key: SaveToUserDefaultsUtil.KEY_CITY)
        performSegue(withIdentifier: "weatherModalSegue", sender: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }

}
