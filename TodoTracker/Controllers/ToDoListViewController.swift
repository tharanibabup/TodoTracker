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
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        //Retrive data from plist file (Persistance store)
        loadItems()
        
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
// For updating the row status
       let item = itemArray[indexPath.row]
       item.done = !item.done
        
////For Deleting the secific selected row from the permoment data store
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
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
        // Save data into User defaults for Persistance. - Comitting the change to permement data store
        do{
            try self.context.save()
        }catch{
           print ("Save Data (context) on Core data throws Error : \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print ("Error  fetch data from context : \(error)")
        }
    }
}

