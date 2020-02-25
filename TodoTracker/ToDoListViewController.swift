//
//  ViewController.swift
//  TodoTracker
//
//  Created by Tharanibabu Padmanabhan on 25/02/2020.
//  Copyright © 2020 Tharanibabu Padmanabhan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Learning", "Coding", "Git", "Check out", "Push"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}

