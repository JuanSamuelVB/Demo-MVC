//
//  User.swift
//  Demo MVC
//
//  Created by isc on 11/29/16.
//  Copyright © 2016 isc. All rights reserved.
//

import Foundation

class User {
    let id: Int64?
    var first_name: String
    var last_name: String
    var email: String
    
    init(id: Int64) {
        self.id = id
        first_name = ""
        last_name = ""
        email = ""
    }
    
    init(id: Int64, first_name: String, last_name: String, email: String) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
    }
}
