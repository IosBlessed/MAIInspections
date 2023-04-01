//
//  Violator+CoreDataProperties.swift
//  MAIInspections
//
//  Created by Никита Данилович on 25.03.2023.
//
//

import Foundation
import CoreData


extension Violator {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Violator> {
        return NSFetchRequest<Violator>(entityName: "Violator")
    }

    @NSManaged public var personImagePath: String?
    @NSManaged public var carNumber: String?
    @NSManaged public var dateBirth: String?
    @NSManaged public var firstName: String?
    @NSManaged public var idnp: String?
    @NSManaged public var secondName: String?

}

extension Violator : Identifiable {

}
