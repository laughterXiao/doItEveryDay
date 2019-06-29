//
//  NewItemController.swift
//  doItEveryday
//
//  Created by joe on 2019/6/27.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import UIKit

class NewItemController:UIViewController{
    var item:DB_doit_item?
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var descriptInput: UITextField!
    @IBOutlet weak var remindTimeInput: UITextField!
    @IBAction func save(_ sender: Any) {
        let title:String = titleInput.text!
        let descript:String = descriptInput.text!
        let remindTime:Int = Int(remindTimeInput.text!)!
        if let item=item{
            item.update(title: title, descript: descript, remindTime: remindTime)
        }else{
            if titleInput.text != "" && descriptInput.text != "" && remindTimeInput.text != ""{
                DB_doit_item.insert(titleStr: title, discriptStr: descript, remindTimeInt: remindTime)
            }else{
                print("some thing space")
            }
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "doListPage"){
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension NewItemController:delegateNIC{
    func setData(item:DB_doit_item) {
//        print("id:\(item.id), title:\(item.title), descript:\(item.discript), remindTime:\(item.remindTime)")
        self.item = item
        titleInput.text = item.title
        descriptInput.text = item.discript
        remindTimeInput.text = String(item.remindTime)
    }
}
