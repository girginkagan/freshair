//
//  ListTopTableViewCell.swift
//  freshair
//
//  Created by Kagan Girgin on 6/6/18.
//  Copyright © 2018 Kagan Girgin. All rights reserved.
//

import UIKit

class ListTopTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var weatherResultData: WeatherModel? = nil
    var listFiltered : [WeatherList]?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func updateCell(model: WeatherModel?){
        if collectionView.dataSource == nil || AppDelegate.infoChanged {
            self.weatherResultData = model
            let currentDateTime = Date()
            let dateString: String = currentDateTime.toString(dateFormat: "yyyy-MM-dd")
            listFiltered = self.weatherResultData?.list.filter { x in x.dtTxt.substring(to: x.dtTxt.index(x.dtTxt.startIndex, offsetBy: 10)) == dateString}
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
            AppDelegate.infoChanged = false;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listFiltered != nil{
            return listFiltered!.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalListCollectionViewCell", for: indexPath) as! HorizontalListCollectionViewCell
        cell.updateCell(listFiltered: self.listFiltered, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 100)
    }

}
