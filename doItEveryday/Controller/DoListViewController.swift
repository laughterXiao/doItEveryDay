//
//  MainViewController.swift
//  doItEveryday
//
//  Created by joe on 2019/6/10.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import UIKit

class DoListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    


    @IBOutlet weak var tableView: UITableView!
    var doListTitleArray = ["一二三四五六七","看一篇英文文章","運動","看英文影片"]
    var doListContentArray = ["一二三四五六七八九十\n一二三四五六七八九十\n一二三四五六七八九十\n一二三四五六七八九十\n一二三四五六七八九十","看一篇英文文章看一篇英文文章","運動","看英文影片"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doListTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.logoImage.image = UIImage(imageLiteralResourceName: "book")
        cell.titleLabel.text = doListTitleArray[indexPath.row]
        cell.contentLabel.text = doListContentArray[indexPath.row]
        
//        cell.textLabel?.text = doListTitleArray[indexPath.row]
//        cell.textLabel?.numberOfLines = 0
        
//        cell.imageView?.image = UIImage(imageLiteralResourceName: "book")
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
//    @IBAction func test(_ sender: Any) {
//        if let controller = storyboard?.instantiateViewController(withIdentifier: "calendarView") {
//            present(controller, animated: true, completion: nil)
//        }
//    }
}
