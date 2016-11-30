//
//  DBUtil.swift
//  Demo MVC
//
//  Created by isc on 11/29/16.
//  Copyright © 2016 isc. All rights reserved.
//

import SQLite

class DBUtil {
  static let instance = DBUtil()
  private let db: Connection?

  private let users = Table("users")
  private let id = Expression<Int64>("id")
  private let first_name = Expression<String?>("first_name")
  private let last_name = Expression<String>("last_name")
  private let email = Expression<String?>("email")

  private init() {
    let path = NSSearchPathForDirectoriesInDomains(
      .documentDirectory, .userDomainMask, true
      ).first!

    do {
      db = try Connection("\(path)/test.sqlite3")
    } catch {
      db = nil
      print("Unable to open database")
    }

    createTable()
  }

  func createTable() {
    do {
      try db!.run(users.create(ifNotExists: true) { table in
      table.column(id, primaryKey: true)
      table.column(first_name)
      table.column(last_name)
      table.column(email)
      })
    } catch {
      print("Unable to create table")
    }
  }
}
