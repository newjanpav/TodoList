//
//  ViewController.swift
//  TodoList
//
//  Created by Pavel Shymanski on 26.08.22.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Buy eggs","Call Mike"]
    
    //to save new added items 
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        //to show new item in  itemArray
        
        if  let items  = defaults.array(forKey: "TodoListArray") as? [String]{
           itemArray = items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
         
        if    tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
//MARK - Add new section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title:"Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
    // what will happen once the user clicks the Add item button on our UIAlert
            self.itemArray.append(textField.text!)
            
    //add new item in an itemArray
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
            
        }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }



