//
//  MainMenuController.swift
//  doItEveryday
//
//  Created by joe on 2019/6/20.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import UIKit

class MainMenuController:UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var titleArray = Array<String>()
    let calendarController:CalendarData = CalendarData()
    var doitItemArr:Array<DB_doit_item> = []
    var selectItem:Int? = nil
    @IBOutlet weak var calendarView: UICollectionView!
    @IBOutlet weak var monthyearLa: UILabel!
    @IBAction func preMonth(_ sender: Any) {
        changeMonth(delta: -1)
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        changeMonth(delta: 1)
    }
    @IBAction func confirmDoit(_ sender: Any) {
        if let selectRow=selectItem{
            let now:Date = Date()
            let dateFormat:DateFormatter = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString:String = dateFormat.string(from: now)
            DB_doit_record.insert(itemIDInt: doitItemArr[selectRow].id, column_recordTimeStr: dateString)
            changeMonth(delta: 0)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titleArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectItem = row
        changeMonth(delta:0)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let fontLabel = UILabel()
        fontLabel.lineBreakMode = .byWordWrapping
        fontLabel.font = UIFont(name: "Avenir-Heavy", size: 30.0)
        fontLabel.textAlignment = .center
        fontLabel.text = titleArray[row]
        return fontLabel
    }

    func changeMonth(delta:Int){
        calendarController.calendarTime.moveMonth(delta: delta)
        if let itemID=selectItem{
            calendarController.calendarTime.setDoitArr(startTime: doitItemArr[itemID].startTime, recordArr: DB_doit_record.select(itemID: doitItemArr[itemID].id, year: calendarController.calendarTime.year, month: calendarController.calendarTime.month))
        }
        calendarView.reloadData()
        monthyearLa.text = calendarController.calendarTime.getMonthYearName()
    }
    
    override func viewDidLoad() {
        SqliteOperate.checkTabelExsist()
        doitItemArr = DB_doit_item.selectAll()
        if doitItemArr.count>0{
            selectItem = 0
        }
        calendarView.delegate = calendarController
        calendarView.dataSource = calendarController
        
        for item in doitItemArr {
            titleArray.append(item.title)
        }
        changeMonth(delta: 0)
        calendarView.collectionViewLayout.invalidateLayout()
    }
}
