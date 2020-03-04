//
//  ViewController.swift
//  TodoTracker
//
//  Created by Tharanibabu Padmanabhan on 25/02/2020.
//  Copyright © 2020 Tharanibabu Padmanabhan. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   

    override func viewDidLoad() {
        super.viewDidLoad()
        print (dataFilePath)
        //Retrive data from plist file (Persistance store)
       // loadItems()
        
    }

    //MARK - Table view Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }

    
    //MARK - Table view Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = itemArray[indexPath.row]
       item.done = !item.done
       saveItems()
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDo Tracker", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        //What will happen once user tap on Add Item button on UIAlert
        
            let newItem = Item(context: self.context)
            if textField.text == ""{
                newItem.title = "New Item <NO NAME>"
                newItem.done = false
                self.itemArray.append(newItem)
            }else{
                 newItem.title = textField.text!
                 newItem.done = false
                 self.itemArray.append(newItem)
            }
            
            self.saveItems()
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
    
    func saveItems(){
        // Save data into User defaults for Persistance.
        let encoder = PropertyListEncoder()
        do{
            try self.context.save()
        }catch{
           print ("Save Data (context) on Core data throws Error : \(error)")
        }
        
        tableView.reloadData()
    }
    
//    func loadItems(){
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch{
//                print("Error decoding item array, \(error)")
//            }
//        }
//    }
}

