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

  private let dbFileName = "test.sqlite3"

  private let users = Table("users")
  private let id = Expression<Int64>("id")
  private let first_name = Expression<String?>("first_name")
  private let last_name = Expression<String>("last_name")
  private let email = Expression<String>("email")

  private init() {
    if !openExistingDatabase() {
      let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!

      do {
        db = try Connection("\(path)/\(dbFileName)")
      } catch {
        db = nil
        print("Unable to open database")
      }
    }

    createTable()
  }

  func openExistingDatabase() -> Bool {
    let resourcePath = NSBundle.mainBundle().resource!.absoluteString
    let dbPath = resourcePath?.stringAppendingPathComponent(dbFileName)

    do {
      db = try Connection(dbPath)
      return true
    } catch {
      db = nil
      print("Unable to open preloaded database")
      return false
    }
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

  func addUser(ufirst_name: String, ulast_name: String, uemail: String) -> Int64? {
    do {
      let insert = users.insert(
        first_name <- ufirst_name, 
        last_name <- ulast_name,
        email <- uemail
      )
      let id = try db!.run(insert)

      return id
    } catch {
      print ("Insert failed")
      return -1
    }
  }

  func getUsers() -> [User] {
    var users = [User]()

    do {
      for user in try db!.prepare(self.users) {
        users.append(User(
          id: user[id],
          first_name: user[first_name]!,
          last_name: user[last_name],
          email: user[email]))
        }
    } catch {
      print("Select failed")
    }

    return users
  }

  func deleteUser(uid: Int64) -> Bool {
    do {
      let user = users.filter(id == uid)
      try db!.run(user.delete())
      return true
    } catch {
      print("Delete failed")
    }
    
    return false
  }

  func updateUser(uid: Int64, newUser: User) -> Bool {
    let user = users.filter(id == uid)
    do {
      let update = user.update([
        first_name <- newUser.first_name,
        last_name <- newUser.last_name,
        email <- newUser.email
        ])
      if try db!.run(update) > 0 {
        return true
      }
    } catch {
      print("Update failed: \(error)")
    }

    return false
  }
}
