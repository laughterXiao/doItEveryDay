//
//  SqliteOperate.swift
//  doItEveryday
//
//  Created by joe on 2019/6/15.
//  Copyright © 2019 laughterXiao. All rights reserved.
//

import SQLite

class SqliteOperate{
    
    
    static func getDBConnection() ->Connection? {
        var db:Connection? = nil
        do {
            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            db = try Connection("\(documentPath)/db.sqlite3")
        } catch let error {
            print("DBConnectError: \(error)")
        }
        return db
    }
    
    
    
    static func checkTabelExsist(){
            //conect
            let db = SqliteOperate.getDBConnection()
            let doit_item = Table("doit_item")
//            drop
//            do {
//                try db?.run(doit_item.drop())
//                print("drop")
//            } catch let error {
//                print(error)
//            }
            //check doit_item
        
            do {
                // test table exist
                try db?.scalar(doit_item.exists)
            } catch let error{
                print("Not exist: \(error)")
                //create table
                do {
                    try db?.run(doit_item.create(ifNotExists: true) { t in
                        t.column(DB_doit_item.column_id, primaryKey: .autoincrement)
                        t.column(DB_doit_item.column_title)
                        t.column(DB_doit_item.column_discript)
                        t.column(DB_doit_item.column_remindTime)
                        t.column(DB_doit_item.column_startTime)
                    })
                } catch let createError {
                    print("createError is: \(createError)")
                }
                
            }
            
            //check doit_record
            let doit_record = Table("doit_record")
//            drop
//            do {
//                try db?.run(doit_record.drop())
//                print("drop")
//            } catch let error {
//                print(error)
//            }

            do {
                // test table exist
                try db?.scalar(doit_record.exists)
            } catch let error1{
                print("create doit_record")
                print("Not exist: \(error1)")
                //create table
                do {
                    try db?.run(doit_record.create(ifNotExists: true) { t in
                        t.column(DB_doit_record.column_id, primaryKey: .autoincrement)
                        t.column(DB_doit_record.column_itemID)
                        t.column(DB_doit_record.column_recordTime)
                    })
                } catch let createError {
                    print("createError is: \(createError)")
                }
            }
    }
}

