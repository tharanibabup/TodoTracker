//
//  ViewController.swift
//  TodoTracker
//
//  Created by Tharanibabu Padmanabhan on 25/02/2020.
//  Copyright © 2020 Tharanibabu Padmanabhan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Learning", "Coding", "Git", "Check out", "Push"]
    let defaults = UserDefaults.standard
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (defaults.array(forKey: "TodoListArray") as! [String])
        if let item = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = item
        }
        
    }

    //MARK - Table view Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    
    //MARK - Table view Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print ("\(indexPath.row) - \(itemArray[indexPath.row])" )
        if  tableView.cellForRow(at:  indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at:  indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at:  indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDo Tracker", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once user tap on Add Item button on UIAlert
            print(textField.text!)
            if textField.text == ""{
                self.itemArray.append("New Item <NO NAME>")
            }else{
                self.itemArray.append(textField.text!)
            }
            // Save data into User defaults for Persistance.
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            
            self.tableView.reloadData()
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            //What will happen once user tap on Cancel button on UIAlert
            print("Cancel Pressed")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new ToDo Tracker item"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

