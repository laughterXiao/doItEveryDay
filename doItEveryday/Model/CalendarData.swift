//
//  CalendarData.swift
//  doItEveryday
//
//  Created by joe on 2019/6/21.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import UIKit

class CalendarData:NSObject,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    let calendarTime:CalendarTime = CalendarTime.init()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarTime.getNowMonthDaysCount()+calendarTime.getMonthFirstWeekDay()
    }
    
//    旋轉螢幕時調整
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        calendarView.collectionViewLayout.invalidateLayout()
//    }
    
    //每格的內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath)
        //clearn
        if let label = cell.contentView.subviews[0] as? UILabel{
            label.text = ""
        }
        if let image = cell.contentView.subviews[1] as? UIImageView{
            image.image = nil
        }
        cell.layer.borderWidth = 0
        //setting
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            let monthFirstDay = calendarTime.getMonthFirstWeekDay()
            if indexPath.row+1-monthFirstDay>0 {
                textLabel.text = String(indexPath.row+1-monthFirstDay)
                if let imageType=calendarTime.doitCalendar[indexPath.row-monthFirstDay]{
                    if let image = cell.contentView.subviews[1] as? UIImageView{
                        if imageType==false{
                            image.image = UIImage(imageLiteralResourceName: "fail")
                        }else if imageType==true{
                            image.image = UIImage(imageLiteralResourceName: "success-2")
                        }
                    }
                }
            }else{
                textLabel.text = ""
            }
            let com = Calendar.current.dateComponents([.year,.month,.day], from: Date())
            if com.year==calendarTime.year && com.month==calendarTime.month && indexPath.row+1-monthFirstDay==calendarTime.day{
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.red.cgColor
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
        return CGSize(width: width, height: 35)
    }
    
    
}
