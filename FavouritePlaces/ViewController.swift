//
//  ViewController.swift
//  FavouritePlaces
//
//  Created by Kane Clerke on 8/4/19.
//  Copyright © 2019 Kane Clerke. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UITableViewController, UITextFieldDelegate, DetailViewControllerDelegate  {
    
   
    
    /// Used for storage
    var objects = [Places]()
    
    // Used for keeping track if the user is adding a new place or not
    var newFavPlace = false
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = editButtonItem
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController else { return }
        
        vc.delegate = self
        let indexPath: IndexPath
        
        if let i = sender as? IndexPath {
            indexPath = i
        } else if let cell = sender as? UITableViewCell,
                  let i = tableView.indexPath(for: cell) {
            indexPath = i
        } else { return }
        let place = objects[indexPath.row]
        vc.place = place
    }
    
    /// Appends the new objects at the position of the table cell in question
    @IBAction func addFavPlace(_ sender: Any) {
        let n = objects.count
        let place = Places(name: "", address: "", latitude: 0.0, longitude: 0.0)
        objects.append(place)
        let indexPath = IndexPath(row: n, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        performSegue(withIdentifier: "showDetail", sender: indexPath)
        newFavPlace = true
    }
    func okayPressed() {
         tableView.reloadData()
         newFavPlace = false
    }
    
    /// If the cancel button is pressed the last entry to the table is removed, the view is popped, and the table is reloaded.
    func cancelPressed() {
        print("Cancel")
        if newFavPlace {
            objects.removeLast()
        }
        newFavPlace = true
        navigationController?.popViewController(animated: true)
        tableView.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // - MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
        let i = indexPath.row
        let place = objects[i]
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    /// Handles editing and deletion of table view data
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert { addFavPlace(self) ; return }
        guard editingStyle == .delete else { return }
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    /// Handles reordering of the table view cells
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let object = objects.remove(at: sourceIndexPath.row)
        objects.insert(object, at: destinationIndexPath.row)
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

