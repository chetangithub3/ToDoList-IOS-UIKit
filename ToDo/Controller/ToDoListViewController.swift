//
//  ViewController.swift
//  ToDo
//
//  Created by Chetan Dhowlaghar on 7/22/22.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController, UISearchBarDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    var todoArray: [Item] = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
        
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItem", for: indexPath)
        cell.textLabel?.text = todoArray[indexPath.row].todoItem
        cell.accessoryType = todoArray[indexPath.row].check ? .checkmark: .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        todoArray[indexPath.row].check = !todoArray[indexPath.row].check
        
        
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
       
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "hi", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            print(textField.text ?? "None")
            
            
            
            let newItem = Item(context: self.context)
            newItem.todoItem = textField.text ?? ""
            newItem.check = false
            self.saveItem()
            self.todoArray.append(newItem)
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type here"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func saveItem(){
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){

        do{
            let items = try  context.fetch(request)
            self.todoArray = items
        }catch{
            print(error)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "todoItem CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "todoItem", ascending: true)]
        
        loadItems(with: request)
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
       searchBarSearchButtonClicked(searchBar)
    }

}

