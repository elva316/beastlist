//
//  SecondTableViewController.swift
//  BeastList
//
//  Created by elva wang on 11/18/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SecondTableViewController: UITableViewController {
    
    
    var beasted = [Beasted]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTodoItems()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchAllTodoItems()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasted.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        UIButton.tag = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeastedCell", for: indexPath) as! SecondCellController
        cell.title.text = beasted[indexPath.row].title2!
        print("pppppppppppppp\(beasted[indexPath.row].title2!)")
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.timeStyle = DateFormatter.Style.short
        let date = dateformatter.string(from: beasted[indexPath.row].beatedTime! as Date)
        print("pppppppppppppp\(date)")
        cell.time.text = date
        return cell
    }
    

    func fetchAllTodoItems() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Beasted")
            self.beasted = try managedObjectContext.fetch(request) as! [Beasted]
            self.tableView.reloadData()
        } catch {
            print(error)
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(beasted[indexPath.row])
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
                fetchAllTodoItems()
            } catch {
                print("\(error)")
            }
        }
    }


    
}

