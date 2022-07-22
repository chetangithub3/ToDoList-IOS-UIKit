//
//  ViewController.swift
//  ToDo
//
//  Created by Chetan Dhowlaghar on 7/22/22.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let todoArray = ["Complete Leetcode", "Do laundry", "Applications"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItem", for: indexPath)
        cell.textLabel?.text = todoArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoArray[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItem", for: indexPath)
        cell.tintColor = UIColor.green
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

