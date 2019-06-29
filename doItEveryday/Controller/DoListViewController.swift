//
//  MainViewController.swift
//  doItEveryday
//
//  Created by joe on 2019/6/10.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import UIKit

protocol delegateNIC{
    func setData(item:DB_doit_item)
}

class DoListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    


    @IBOutlet weak var tableView: UITableView!
    var doListTitleArray:Array<String> = Array()
    var doListContentArray:Array<String> = Array()
    var itemArray:Array<DB_doit_item> = Array()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
  
    @IBAction func addItem(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "newItemPage"){
            present(controller, animated: true, completion: nil)
        }

    }
//    @IBAction func addItem(_ sender: Any) {
    
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.logoImage.image = UIImage(imageLiteralResourceName: "book")
        cell.titleLabel.text = itemArray[indexPath.row].title
        cell.contentLabel.text = itemArray[indexPath.row].discript
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var actionArr:Array<UITableViewRowAction> = [UITableViewRowAction]()
        // 建立編輯按鈕
        let actionEdit:UITableViewRowAction =
            UITableViewRowAction(style: UITableViewRowAction.Style.normal,
                                 title: "編輯") { (action, indexPath) in
                                    if let controller = self.storyboard?.instantiateViewController(withIdentifier: "newItemPage"){
                                        self.present(controller, animated: true, completion: nil)
                                        let delegate = controller as! NewItemController
                                        delegate.setData(item: self.itemArray[indexPath.row])
                                    }
        }
        
        // 建立刪除按鈕
        let actionDelete:UITableViewRowAction =
            UITableViewRowAction(style: UITableViewRowAction.Style.default,
                                 title: "刪除") { (action, indexPath) in
                                    let deleteArr = DB_doit_record.select(itemID: self.itemArray[indexPath.row].id)
                                    for record in deleteArr{
                                        record.delete()
                                    }
                                    self.itemArray[indexPath.row].delete()
                                    self.itemArray.remove(at: indexPath.row)
                                    tableView.reloadData() // 更新tableView
        }
        
        // 將按鈕動作加入Array，並回傳
        actionArr.append(actionEdit)
        actionArr.append(actionDelete)
        
        return actionArr;
    }
    
    
    private func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        itemArray = DB_doit_item.selectAll()
//        for item in doitlist{
//            doListTitleArray.append(item.title)
//            doListContentArray.append(item.discript)
//        }
        tableView.reloadData()

        
//        SqliteOperate.checkTabelExsist()
//        let now:Date = Date()
//        let dateFormat:DateFormatter = DateFormatter()
//        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let dateString:String = dateFormat.string(from: now)
//        DB_doit_record.insert(itemIDInt: 1, column_recordTimeStr: dateString)
//        DB_doit_record.selectAll()
    }
}
