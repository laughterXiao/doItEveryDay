//
//  DB_doit_record.swift
//  doItEveryday
//
//  Created by joe on 2019/6/19.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import SQLite

class DB_doit_record {
    var id:Int
    var itemID:Int
    var recordTime:String
    static let column_id = Expression<Int>("id")
    static let column_itemID = Expression<Int>("itemID")
    static let column_recordTime = Expression<String>("recordTime")
    
    init(idInt:Int, itemIDInt:Int, recordTimeStr:String) {
        id = idInt
        itemID = itemIDInt
        recordTime = recordTimeStr
    }
    
    static func insert(itemIDInt:Int, column_recordTimeStr:String){
        //chech specific ID and time exist record
        let isRepeat = checkRepeat(itemID: itemIDInt, dateStr: column_recordTimeStr)
        //table
        let doit_record = Table("doit_record")
        //insert data to table
        if isRepeat==false{
            if let db = SqliteOperate.getDBConnection(){
                do {
                    let insert = doit_record.insert(column_itemID <- itemIDInt, column_recordTime <- column_recordTimeStr)
                    try db.run(insert)
                } catch let error {
                    print("insert error: \(error)")
                }
            }else{
                print("DBConnection Error")
            }
        }else{
            print("record repeat")
        }
    }
    
    static func selectAll() ->Array<DB_doit_record> {
        var allData:Array<DB_doit_record> = Array()
//        let doit_record = Table("doit_record")
        let sql = "SELECT * FROM doit_record WHERE recordTime>'2019-06-19'"
        
        if let db = SqliteOperate.getDBConnection(){
            do {
                for item in try db.prepare(sql) {
                    allData.append(DB_doit_record(idInt: Int(item[0] as! Int64), itemIDInt: Int(item[1] as! Int64), recordTimeStr: item[2] as! String))
//                    print("id:\(item[1]) ,time:\(item[2])")
                }
            } catch let error {
                print("insert error: \(error)")
            }
        }else{
            print("DBConnection Error")
        }
        return allData
    }
    static func checkRepeat(itemID:Int, dateStr:String) -> Bool{
        var isRepeat = false
        let date = dateStr.split(separator: " ")[0]
        let sql = "SELECT * FROM doit_record WHERE itemID=\(itemID) AND recordTime>='\(date) 00:00:00' AND recordTime<='\(date) 23:59:59'"
        if let db = SqliteOperate.getDBConnection(){
            do {
                for _ in try db.prepare(sql) {
                    isRepeat = true
                }
            } catch let error {
                print("select error: \(error)")
            }
        }else{
            print("DBConnection Error")
        }
        return isRepeat
    }
    
    static func select(itemID:Int, year:Int, month:Int) ->Array<DB_doit_record> {
        var allData:Array<DB_doit_record> = Array()
//        let doit_record = Table("doit_record")
        let nextMonthCalendar = CalendarTime()
        nextMonthCalendar.setTime(yearInt: year, monthInt: month, dayInt: 1)
        nextMonthCalendar.moveMonth(delta: 1)
        let sql = "SELECT * FROM doit_record WHERE itemID=\(itemID) AND recordTime>='\(year.dateStr)-\(month.dateStr)-1 00:00:00' AND recordTime<'\(nextMonthCalendar.year.dateStr)-\(nextMonthCalendar.month.dateStr)-1 00:00:00'"
        if let db = SqliteOperate.getDBConnection(){
            do {
                for item in try db.prepare(sql) {
                    allData.append(DB_doit_record(idInt: Int(item[0] as! Int64), itemIDInt: Int(item[1] as! Int64), recordTimeStr: item[2] as! String))
                }
            } catch let error {
                print("select error: \(error)")
            }
        }else{
            print("DBConnection Error")
        }
        return allData
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
}
