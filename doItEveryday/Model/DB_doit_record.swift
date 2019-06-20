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
        //table
        let doit_record = Table("doit_record")
        //insert data to table
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
    }
    
    static func selectAll() ->Array<DB_doit_record> {
        var allData:Array<DB_doit_record> = Array()
        let doit_record = Table("doit_record")
        let sql = "SELECT * FROM doit_record WHERE recordTime>'2019-06-19'"
        
        if let db = SqliteOperate.getDBConnection(){
            do {
                for item in try db.prepare(sql) {
                    //                    print("id: \(item[column_id]), title: \(item[column_title]), discript: \(item[column_discript]), remindTime:\(item[column_remindTime])")
//                    print("id:\(item[column_id]), itemID:\(item[column_itemID]), recordTime:\(item[column_recordTime])")
//                    allData.append(DB_doit_record(idInt: item[column_id], itemIDInt: item[column_itemID], recordTimeStr: item[column_recordTime]))
                    allData.append(DB_doit_record(idInt: Int(item[0] as! Int64), itemIDInt: Int(item[1] as! Int64), recordTimeStr: item[2] as! String))
                    print(item)
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
