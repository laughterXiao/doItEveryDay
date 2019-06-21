//
//  MainMenuController.swift
//  doItEveryday
//
//  Created by joe on 2019/6/20.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import UIKit

class MainMenuController:UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var testArray = ["一二三四五六七","看一篇英文文章","運動","看一篇英文文章","運動","看一篇英文文章","運動","看一篇英文文章","運動","看一篇英文文章","運動"]
    let calendarController:CalendarData = CalendarData()
    @IBOutlet weak var calendarView: UICollectionView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return testArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let fontLabel = UILabel()
        fontLabel.lineBreakMode = .byWordWrapping
        fontLabel.font = UIFont(name: "Avenir-Heavy", size: 30.0)
        fontLabel.textAlignment = .center
        fontLabel.text = testArray[row]
        return fontLabel
    }

    
    override func viewDidLoad() {
        calendarView.delegate = calendarController
        calendarView.dataSource = calendarController
        calendarView.reloadData()
        calendarView.collectionViewLayout.invalidateLayout()
    }
}
