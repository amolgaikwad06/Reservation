//
//  MyReservationsViewController.swift
//  Reservation
//
//  Created by Amol Gaikwad on 2/16/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class MyReservationsViewController: UIViewController
{
    
    var managedObjectContext : NSManagedObjectContext!
    var coreDataStack = CoreDataStack()
    var reservationsArray:[Reservations] = []
    var reservationsObj = Reservations()
    
    
    @IBOutlet weak var myReservationsTableView: UITableView!
    
    func setupUI()
    {
        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .plain, target: nil, action: nil)
        
        // Remove the back button
        self.navigationItem.hidesBackButton = true
        
        managedObjectContext = coreDataStack.persistentContainer.viewContext
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        myReservationsTableView.allowsSelection = false
        setupUI()
        populateTableViewWithData()
    }
    
    func populateTableViewWithData()
    {
        let request: NSFetchRequest<Reservations> = Reservations.fetchRequest()
        let context = coreDataStack.persistentContainer.viewContext
        do
        {
            reservationsArray = try context.fetch(request)
            if reservationsArray.count != 0
            {
                //data is there
                print("Count : \(reservationsArray.count)")
                
                for item in reservationsArray as [NSManagedObject]
                {
                    
                    reservationsObj = item as! Reservations
                    
                }
                
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
}

// MARK: - UITableViewDatasource

@available(iOS 10.0, *)
extension MyReservationsViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return reservationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyReservationsTableViewCell
        reservationsObj = reservationsArray[indexPath.row]
        
       /* print(reservationsObj.dayString!)
        print(reservationsObj.dateString!)
        print(reservationsObj.timeString!)
        print(reservationsObj.yearString!)
        print(reservationsObj.monthString!)*/
        
        let fullDateString = reservationsObj.dayString! + "," +  "" + reservationsObj.monthString! + " " + reservationsObj.dateString! + "," + "" + reservationsObj.yearString!
        print(fullDateString)
        
        cell.dateLabel.text = fullDateString
        cell.timeLabel.text = reservationsObj.timeString!
        cell.partySizeLabel.text = reservationsObj.partySizeString!
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

/*@available(iOS 10.0, *)
extension MyReservationsViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            reservationsArray.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}*/













