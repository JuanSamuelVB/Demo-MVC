//
//  ViewController.swift
//  Demo MVC
//
//  Created by isc on 11/25/16.
//  Copyright © 2016 isc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usersTableView: UITableView!

    private var users = [User]()
    private var selectedUser: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonClicked() {
        let first_name = firstNameTextField.text ?? ""
        let last_name = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        let user = User(id: 0, first_name: first_name, last_name: last_name, email: email)
        users.append(user)
        usersTableView.insertRows(at: [NSIndexPath(forRow: users.count-1, inSection: 0)], with: .Fade)
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        firstNameTextField.text = users[indexPath.row].first_name
        lastNameTextField.text = users[indexPath.row].last_name
        emailTextField.text = users[indexPath.row].email
        
        selectedUser = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")!
        var label: UILabel
        label = cell.viewWithTag(1) as! UILabel
        label.text = users[indexPath.row].first_name
        
        return cell
    }
    
}

