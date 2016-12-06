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
    
    @IBOutlet weak var votesButton: UIButton!
    @IBOutlet weak var usersTableView: UITableView!

    private var users = [User]()
    private var selectedUser: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        votesButton.layer.cornerRadius = votesButton.bounds.size.width/2;
        votesButton.layer.borderWidth = 0
        
        users = DBUtil.instance.getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newButtonClicked() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        votesButton.setTitle("0", for: .normal)
    }
    
    @IBAction func addButtonClicked() {
        let first_name = firstNameTextField.text ?? ""
        let last_name = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        if let id = DBUtil.instance.addUser(ufirst_name: first_name, ulast_name: last_name, uemail: email) {
            let user = User(id: id, first_name: first_name, last_name: last_name, email: email, votes: 0)
            users.append(user)
            usersTableView.insertRows(at: [IndexPath(row: users.count-1, section: 0)], with: .fade)
            usersTableView.selectRow(at: IndexPath(row: users.count-1, section: 0), animated: true, scrollPosition: .none)
            usersTableView.scrollToRow(at: IndexPath(row: users.count-1, section: 0), at: .bottom, animated: true)
        }
    }
    
    @IBAction func updateButtonClicked() {
      if selectedUser != nil {
        let id = users[selectedUser!].id!
        print("Selected user id: \(id)")
        let user = User(
          id: id,
          first_name: firstNameTextField.text ?? "",
          last_name: lastNameTextField.text ?? "",
          email: emailTextField.text ?? "",
          votes: Int64(votesButton.title(for: .normal)!)!)

          if DBUtil.instance.updateUser(uid: id, newUser: user) {
            users.remove(at: selectedUser!)
            users.insert(user, at: selectedUser!)
            usersTableView.reloadData()
          }
      } else {
        print("No item selected")
      }
    }

    @IBAction func deleteButtonClicked() {
      if selectedUser != nil && selectedUser! < users.count {
        if DBUtil.instance.deleteUser(uid: users[selectedUser!].id!) {
          users.remove(at: selectedUser!)
          usersTableView.deleteRows(at: [IndexPath(row: selectedUser!, section: 0)], with: .fade)
        }
      } else {
        print("No item selected")
      }
    }
    
    @IBAction func votesButtonClicked() {
        let votes = Int64(votesButton.title(for: .normal)!)! + 1
        votesButton.setTitle(String(votes), for: .normal)
        
        updateButtonClicked()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        firstNameTextField.text = users[indexPath.row].first_name
        lastNameTextField.text = users[indexPath.row].last_name
        emailTextField.text = users[indexPath.row].email
        votesButton.setTitle(String(users[indexPath.row].votes), for: .normal)
        
        selectedUser = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell")!
        var label: UILabel
        
        label = cell.viewWithTag(1) as! UILabel
        label.text = users[indexPath.row].first_name + " " + users[indexPath.row].last_name
        
        label = cell.viewWithTag(2) as! UILabel
        label.text = users[indexPath.row].email
        
        return cell
    }
    
}

