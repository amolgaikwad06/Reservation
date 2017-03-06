//
//  Utility.swift
//  Reservation
//
//  Created by Amol Gaikwad on 2/19/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    class func getCustomBlueColor() -> UIColor{
        return UIColor(red: 2.0/255.0, green: 107.0/255.0, blue: 197.0/255.0, alpha: 1.0)
    }
    
    class func getSelectionBlueColor() -> UIColor{
        return UIColor(red: 168.0/255.0, green: 203.0/255.0, blue: 235.0/255.0, alpha: 1.0)
    }
}

struct Utility
{
    static func getCustomizedNavigationBar()
    {
        UINavigationBar.appearance().barTintColor = UIColor(red: 97.0/255.0, green:179.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        if let barFont = UIFont(name: "Helvetica Neue", size: 15.0)
        {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:barFont]
        }
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    static func getCurrentMonth(month : Int) -> String
    {
        switch month
        {
        case 1:
            return "JANUARY"
        case 2:
            return "FEBRUARY"
        case 3:
            return "MARCH"
        case 4:
            return "APRIL"
        case 5:
            return "MAY"
        case 6:
            return "JUNE"
        case 7:
            return "JULY"
        case 8:
            return "AUGUST"
        case 9:
            return "SEPTEMBER"
        case 10:
            return "OCTOBER"
        case 11:
            return "NOVEMBER"
        case 12:
            return "DECEMBER"
        default:
            return ""
        }
        
    }
    
    static func getDayOfWeek(_ today:String) -> Int?
    {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    static func getWeekday(day : Int) -> String
    {
        
        switch day
        {
        case 1:
            return "SUN"
        case 2:
            return "MON"
        case 3:
            return "TUE"
        case 4:
            return "WED"
        case 5:
            return "THU"
        case 6:
            return "FRI"
        case 7:
            return "SAT"
        default:
            return "SUN"
        }
        
    }
    
}
