//
//  SceduleViewController.swift
//  Reservation
//
//  Created by Amol Gaikwad on 2/17/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class ScheduleViewController: UIViewController
{
    
    @IBOutlet weak var calenderDatesCollectionView: UICollectionView!
    @IBOutlet weak var availableTimeCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var partySizeTextField: UITextField!
    
    let picker = UIPickerView()
    
    var managedObjectContext : NSManagedObjectContext!
    var coreDataStack = CoreDataStack()
    

    //Array of Available Dates
    var availableTimesArray = ["09:00 AM","10:00 AM","11:00 AM","12:00 PM","01:00 PM","02:00 PM","03:00 PM","04:00 PM","05:00 PM","06:00 PM","07:00 PM","08:00 PM"]
    
    var pickerValuesArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    
    //Array of Calender Dates
    var calenderDatesArray = [CalenderDates]()
    
    let zeroString = String(0)
    var month = 0
    var isCalenderChecked  = false
    var isTimeChecked = false
    var day = 0
    var year = 0
    var weekDay  = 0
    
    //Varialbles for storing selected time and date
    var dayString = ""
    var dateString = ""
    var timeString = ""
    var monthString = ""

    func setUpUIComponents()
    {
        self.navigationItem.title = "SCHEDULE"
        self.reserveButton.isEnabled = false
        
        picker.delegate = self
        picker.dataSource = self
        
        //Binding text field to picker
        partySizeTextField.inputView = picker
        partySizeTextField.text = String(1)
        
        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .plain, target: nil, action: nil)
        // Remove the back button
        self.navigationItem.hidesBackButton = true
        
        getCalenderDate()
        
        self.monthLabel.text = Utility.getCurrentMonth(month: month)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpUIComponents()
        managedObjectContext = coreDataStack.persistentContainer.viewContext
    }
    
    @IBAction func didClickedOnReserveButton(_ sender: UIButton)
    {
        
        if self.reserveButton.isEnabled
        {
            //Adding into Core Data
            let reservationObj = Reservations(context:managedObjectContext)
            reservationObj.dayString = dayString
            reservationObj.dateString = dateString
            reservationObj.timeString = timeString
            reservationObj.yearString = String(year)
            reservationObj.monthString = monthLabel.text!
            reservationObj.partySizeString = partySizeTextField.text
            
            
            /*print(reservationObj.dayString!)
            print(reservationObj.dateString!)
            print(reservationObj.timeString!)
            print(reservationObj.yearString!)
            print(reservationObj.monthString!)
            print(reservationObj.partySizeString!)*/
            
            coreDataStack.saveContext()
            
        }
        
    }
    
    func getCalenderDate()
    {
        
        let date = Date()
        let calendar = Calendar.current
        
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        
        
        //pass current year and month to get number of days
        let dateComponents = DateComponents(year: year, month: month)
        let myCalendar = Calendar.current
        let myDate = myCalendar.date(from: dateComponents)!
        
        let range = myCalendar.range(of: .day, in: .month, for: myDate)!
        let numDays = range.count
        
        let yearString = String(year)
        let monthString = zeroString + String(month)
        var dayString : String = ""
        
        var dateString = ""
        
        
        for number in 1...numDays
        {
            
            if(number < 10)
            {
                day = number
                dayString = zeroString + String(number)
                dateString = yearString + "-" + monthString + "-" + dayString
                
            }
            else
            {
                day = number
                dateString = yearString + "-" + monthString + "-" + String(number)
            }
            weekDay = Utility.getDayOfWeek(dateString)!
            
            //Assign values to object
            var calenderDatesObj = CalenderDates()
            calenderDatesObj.date = day
            calenderDatesObj.month = month
            calenderDatesObj.year = year
            calenderDatesObj.monthDays = numDays
            calenderDatesObj.weekday = weekDay
            
            calenderDatesArray.append(calenderDatesObj)
            
        }
    }
    
    
}


// MARK: - UICollectionViewControllerDataSource Methods

@available(iOS 10.0, *)
extension ScheduleViewController : UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == calenderDatesCollectionView
        {
            return calenderDatesArray.count
        }
        if collectionView == availableTimeCollectionView
        {
            return availableTimesArray.count
        }
        return calenderDatesArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if collectionView == calenderDatesCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! CalenderDatesCollectionViewCell
            let data = calenderDatesArray[indexPath.row] as CalenderDates
            if(data.date < 10)
            {
                cell.dateLabel.text = zeroString + String(data.date)
            }
            else
            {
                cell.dateLabel.text = String(data.date)
            }
            
            cell.dayLabel.text = Utility.getWeekday(day : data.weekday)
            
            return cell
        }
            
        else if collectionView == availableTimeCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! AvailableTimesCollectionViewCell
            
            cell.timeLabel.text = availableTimesArray[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

// MARK: - UICollectionViewControllerDelegate Methods

@available(iOS 10.0, *)
extension ScheduleViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if collectionView == calenderDatesCollectionView
        {
            let cell = collectionView.cellForItem(at: indexPath) as! CalenderDatesCollectionViewCell
            
            isCalenderChecked = true
            if isCalenderChecked == true && isTimeChecked == true
            {
                reserveButton.isEnabled = true
                reserveButton.backgroundColor = UIColor.getCustomBlueColor()
            }
            cell.containerView.backgroundColor = UIColor.getSelectionBlueColor()
            dayString = cell.dayLabel.text! //wed
            dateString = cell.dateLabel.text! //10
            
        }
        
        if collectionView == availableTimeCollectionView
        {
            let cell = collectionView.cellForItem(at: indexPath) as! AvailableTimesCollectionViewCell
            isTimeChecked = true
            if isCalenderChecked == true && isTimeChecked == true
            {
                reserveButton.isEnabled = true
                reserveButton.backgroundColor = UIColor.getCustomBlueColor()
                
            }
            cell.customView.backgroundColor = UIColor.getSelectionBlueColor()
            timeString = cell.timeLabel.text! //10:00 AM
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        if collectionView == calenderDatesCollectionView
        {
            let cell = collectionView.cellForItem(at: indexPath) as! CalenderDatesCollectionViewCell
            cell.containerView.backgroundColor = UIColor.white
        }
        
        if collectionView == availableTimeCollectionView
        {
            let cell = collectionView.cellForItem(at: indexPath) as! AvailableTimesCollectionViewCell
            cell.customView.backgroundColor = UIColor.white
        }
        
    }
    
}

// MARK: - UIPickerViewControllerDataSource Methods


@available(iOS 10.0, *)
extension ScheduleViewController : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerValuesArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerValuesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        partySizeTextField.text = pickerValuesArray[row]
        self.view.endEditing(false)
    }
    
}













































