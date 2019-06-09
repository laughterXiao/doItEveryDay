//
//  ViewController.swift
//  doItEveryday
//
//  Created by joe on 2019/6/7.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let calendarTime:CalendarTime = CalendarTime.init()
    @IBOutlet weak var calendarView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBAction func nextMonth(_ sender: Any) {
        calendarTime.moveMonth(delta: 1)
        calendarView.reloadData()
        monthLabel.text = calendarTime.getMonthYearName()
    }
    
    @IBAction func preMonth(_ sender: Any) {
        calendarTime.moveMonth(delta: -1)
        calendarView.reloadData()
        monthLabel.text = calendarTime.getMonthYearName()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarTime.getNowMonthDaysCount()+calendarTime.getMonthFirstWeekDay()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendarView.collectionViewLayout.invalidateLayout()
    }
    
    //每格的內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            let monthFirstDay = calendarTime.getMonthFirstWeekDay()
            if indexPath.row+1-monthFirstDay>0 {
                textLabel.text = String(indexPath.row+1-monthFirstDay)
            }else{
                textLabel.text = ""
            }
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //間距調整
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    //每格的寬高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 40)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        calendarView.dataSource = self
//        calendarView.delegate = self
    }
    
    

}

