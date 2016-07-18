//
//  CityCollectionViewController.swift
//  Cartel
//
//  Created by Jannie Theron on 2014/08/06.
//  Copyright (c) 2014 Tuism. All rights reserved.
//

import UIKit

class CityCollectionView: NSObject,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var city = [[Card]]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return city.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return city[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let card = city[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row] as Card
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.imageView.image = card.image
        cell.draggable = false
        return cell
    }
}
