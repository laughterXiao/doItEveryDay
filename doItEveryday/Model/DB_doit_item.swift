//
//  DB_doit_item.swift
//  doItEveryday
//
//  Created by joe on 2019/6/16.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import SQLite

class DB_doit_item {
    var id:Int
    var title:String
    var discript:String
    var remindTime:Int
    var startTime:String
    static let column_id = Expression<Int>("id")
    static let column_title = Expression<String>("title")
    static let column_discript = Expression<String>("discript")
    static let column_remindTime = Expression<Int>("remindTime")
    static let column_startTime = Expression<String>("startTime")
    
    init(idInt:Int, titleStr:String, discriptStr:String, remindTimeInt:Int, startTimeStr:String) {
        id = idInt
        title = titleStr
        discript = discriptStr
        remindTime = remindTimeInt
        startTime = startTimeStr
    }
    
    static func insert(titleStr:String, discriptStr:String, remindTimeInt:Int, startTimeStr:String=""){
        //table
        let doit_item = Table("doit_item")
        //insert data to table
        if let db = SqliteOperate.getDBConnection(){
            do {
                var settingTime:String
                if startTimeStr==""{
                    let now:Date = Date()
                    let dateFormat:DateFormatter = DateFormatter()
                    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let dateString:String = dateFormat.string(from: now)
                    settingTime = dateString
                }else{
                    settingTime = startTimeStr
                }
                let insert = doit_item.insert(column_title <- titleStr, column_discript <- discriptStr, column_remindTime <- remindTimeInt, column_startTime <- settingTime)
                try db.run(insert)
            } catch let error {
                print("insert error: \(error)")
            }
        }else{
            print("DBConnection Error")
        }
    }
    
    static func selectAll() ->Array<DB_doit_item> {
        var allData:Array<DB_doit_item> = Array()
        let doit_item = Table("doit_item")
        
        if let db = SqliteOperate.getDBConnection(){
            do {
                for item in try db.prepare(doit_item) {
//                    print("id: \(item[column_id]), startTime:\(item[column_startTime]), title: \(item[column_title]), discript: \(item[column_discript]), remindTime:\(item[column_remindTime])")
                    allData.append(DB_doit_item(idInt: item[column_id], titleStr: item[column_title], discriptStr: item[column_discript], remindTimeInt: item[column_remindTime], startTimeStr: item[column_startTime]))
                }
            } catch let error {
                print("insert error: \(error)")
            }
        }else{
            print("DBConnection Error")
        }
        return allData
    }
    
    func update(title:String, descript:String, remindTime:Int) {
        let sql = "UPDATE doit_item SET title='\(title)',discript='\(descript)',remindTime=\(remindTime) WHERE id=\(self.id)"
        if let db = SqliteOperate.getDBConnection(){
            do {
                try db.run(sql)
            } catch let error {
                print("update error: \(error)")
            }
        }else{
            print("DBConnection Error")
        }
    }
    
    func delete() {
        let sql = "DELETE FROM doit_item WHERE id=\(self.id)"
        if let db = SqliteOperate.getDBConnection(){
            do {
                try db.run(sql)
            } catch let error {
                print("delete error: \(error)")
            }
        }else{
            print("DBConnection Error")
        }
    }
}
