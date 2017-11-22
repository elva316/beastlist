//
//  ViewController.swift
//  BeastList
//
//  Created by elva wang on 11/18/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import UIKit
import CoreData

protocol BeastDelegation {
    func cancelFunc(by:UIViewController)
    func doneFunc(by: UIViewController, title: String, at indexPath: NSIndexPath?)
}


class FirstTableViewController: UITableViewController, BeastDelegation {
    
    var beast = [Beast]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTodoItems()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //********************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beast.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        UIButton.tag = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToBeastCell", for: indexPath) as! CustomCellOne
        cell.title.text = beast[indexPath.row].title1
        cell.beastButton.tag = indexPath.row
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //*************    delegation function   ********
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "doneSegue", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddingViewController
        controller.delegate = self

        if segue.identifier == "doneSegue" {
            let indexP = sender as! NSIndexPath
            let item = beast[indexP.row]
            controller.prePopulate = item.title1!
            controller.indexPath = indexP
            print( item.title1!)
            print( indexP)
        }
    }
/////**********  protocol functions
    func cancelFunc(by:UIViewController ){
        dismiss(animated: true, completion: nil)
    }
    func doneFunc(by: UIViewController, title: String, at indexPath: NSIndexPath? ) {
        print("xxxxxxxxx\(title)")
        if let ip = indexPath {
            let item = beast[ip.row]
            item.title1 = title
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "Beast", into: managedObjectContext) as! Beast
            item.title1 = title
            beast.append(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
//    func isValidInput(Input:String) -> Bool {
//        let RegEx = "a-zA-Z"
//        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
//        return Test.evaluate(with: Input)
//    }

    @IBAction func beastButtonFromCustomCell(_ sender: UIButton) {
        print("nnnnnnnnnnnnnnnnnnnn \(sender.tag)  ")
//        print(sender.tag.name)
        let beasted = NSEntityDescription.insertNewObject(forEntityName: "Beasted", into: managedObjectContext) as! Beasted
        beasted.title2 = beast[sender.tag].title1
        beasted.beatedTime = NSDate() as Date
        managedObjectContext.delete(beast[sender.tag])
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
                fetchAllTodoItems()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
    
    
    ////*******   featch & save data
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    func fetchAllTodoItems() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Beast")
            self.beast = try managedObjectContext.fetch(request) as! [Beast]
            self.tableView.reloadData()
        } catch {
            print(error)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        beast.remove(at: indexPath.row)
//        saveContext()
//        tableView.reloadData()
        managedObjectContext.delete(beast[indexPath.row])
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

