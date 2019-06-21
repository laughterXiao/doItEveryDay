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
    var doListTitleArray:Array<String> = Array()
    var doListContentArray:Array<String> = Array()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doListTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.logoImage.image = UIImage(imageLiteralResourceName: "book")
        cell.titleLabel.text = doListTitleArray[indexPath.row]
        cell.contentLabel.text = doListContentArray[indexPath.row]
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        let doitlist = DB_doit_item.selectAll()
        for item in doitlist{
            doListTitleArray.append(item.title)
            doListContentArray.append(item.discript)
        }
        tableView.reloadData()

        
        SqliteOperate.checkTabelExsist()
        let now:Date = Date()
        let dateFormat:DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString:String = dateFormat.string(from: now)
//        DB_doit_record.insert(itemIDInt: 1, column_recordTimeStr: dateString)
        DB_doit_record.selectAll()
    }
}
