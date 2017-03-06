//
//  Reservations+CoreDataProperties.swift
//  Reservation
//
//  Created by Amol Gaikwad on 2/19/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import Foundation
import CoreData


extension Reservations
{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reservations>
    {
        return NSFetchRequest<Reservations>(entityName: "Reservations");
    }

    @NSManaged public var dayString: String?
    @NSManaged public var dateString: String?
    @NSManaged public var timeString: String?
    @NSManaged public var monthString: String?
    @NSManaged public var yearString: String?
    @NSManaged public var partySizeString: String?

}
