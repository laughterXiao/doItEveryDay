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
    static let column_id = Expression<Int>("id")
    static let column_title = Expression<String>("title")
    static let column_discript = Expression<String>("discript")
    static let column_remindTime = Expression<Int>("remindTime")
    
    
    init(idInt:Int, titleStr:String, discriptStr:String, remindTimeInt:Int) {
        id = idInt
        title = titleStr
        discript = discriptStr
        remindTime = remindTimeInt
    }
    
    static func insert(titleStr:String, discriptStr:String, remindTimeInt:Int){
        //table
        let doit_item = Table("doit_item")
        //insert data to table
        if let db = SqliteOperate.getDBConnection(){
            do {
                let insert = doit_item.insert(column_title <- titleStr, column_discript <- discriptStr, column_remindTime <- remindTimeInt)
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
//                    print("id: \(item[column_id]), title: \(item[column_title]), discript: \(item[column_discript]), remindTime:\(item[column_remindTime])")
                    allData.append(DB_doit_item(idInt: item[column_id], titleStr: item[column_title], discriptStr: item[column_discript], remindTimeInt: item[column_remindTime]))
                }
            } catch let error {
                print("insert error: \(error)")
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
