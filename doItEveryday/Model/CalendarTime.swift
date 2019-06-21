//
//  nowTime.swift
//  doItEveryday
//
//  Created by joe on 2019/6/8.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import Foundation

class CalendarTime {
    var year = 2019
    var month = 1
    var day = 1
    
    init(){
        let calendar = Calendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: Date())
        year = com.year!
        month = com.month!
        day = com.day!
    }

    func moveMonth(delta:Int){
        day = 10
        month = month+delta
        if(month>12){
            month=1
            year = year+1
        }else if(month<1){
            month=12
            year = year-1
        }
    }
    
    func getNowMonthDaysCount() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: getNowTimeDate(day:day))
        return (range?.length)!
    }
    
    func getMonthFirstWeekDay() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        var firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: getNowTimeDate())
        firstWeekDay = firstWeekDay!-1
        return firstWeekDay!
    }
    
    func getNowTimeDate(day:Int=1,dateFormat:String="yyyy-MM-dd") -> Date{
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        let timeString:String = String(year)+"-"+String(month)+"-1"
        let date = dateFormatter.date(from: timeString)!
        return date
    }
    
    func getMonthYearName() ->String {
        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        return months[month-1]+" "+String(year)
    }
}
