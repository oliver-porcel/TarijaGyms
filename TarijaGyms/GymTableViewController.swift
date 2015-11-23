//
//  GymTableViewController.swift
//  TarijaGyms
//
//  Created by OLiVeR on 11/23/15.
//  Copyright © 2015 OLiVeR. All rights reserved.
//

import UIKit
import MapKit

class GymTableViewController: UITableViewController {
    // MARK: Properties
    
    var gyms = [Gym]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load the sample data.
        loadSampleGyms()
    }
    
    func loadSampleGyms() {
        let photo1 = UIImage(named: "Gym1")!
        let gym1 = Gym(title: "Pulseta", subtitle: "Maquinas, Aerobics, Spinning", photo: photo1, rating: 4)
        gym1.coordinate=CLLocationCoordinate2D(latitude: -21.537062, longitude: -64.728339)
        
        let photo2 = UIImage(named: "Gym2")!
        let gym2 = Gym(title: "X3M Fitness Club", subtitle: "Maquinas, Aerobics, Spinning", photo: photo2, rating: 5)
        gym2.coordinate=CLLocationCoordinate2D(latitude: -21.534218, longitude: -64.735678)
        
        
        let photo3 = UIImage(named: "Gym3")!
        let gym3 = Gym(title: "Nivel Fitness Club", subtitle: "Maquinas, Aerobics, Spinning", photo: photo3, rating: 5)
        gym3.coordinate=CLLocationCoordinate2D(latitude: -21.531216, longitude: -64.739875)
        
        gyms += [gym1, gym2, gym3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Segue
    @IBAction func unwindToGymList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? GymViewController, gym = sourceViewController.gym {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing gym.
                gyms[selectedIndexPath.row] = gym
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new gym.
                let newIndexPath = NSIndexPath(forRow: gyms.count, inSection: 0)
                gyms.append(gym)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gyms.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GymTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GymTableViewCell
        let gym = gyms[indexPath.row]
        
        cell.nameLabel.text = gym.title
        cell.photoImageView.image = gym.photo
        cell.ratingControl.rating = gym.rating
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            gyms.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let gymDetailViewController = segue.destinationViewController as! GymViewController
            
            // Get the cell that generated this segue.
            if let selectedGymCell = sender as? GymTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedGymCell)!
                let selectedGym = gyms[indexPath.row]
                gymDetailViewController.gym = selectedGym
                
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new gym.")
        }
    }
    
    
}
