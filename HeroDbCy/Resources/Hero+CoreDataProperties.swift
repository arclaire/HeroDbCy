//
//  Hero+CoreDataProperties.swift
//  
//
//  Created by Lucy on 21/09/20.
//
//

import Foundation
import CoreData


extension Hero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var localized_name: String?
    @NSManaged public var primary_attr: String?
    @NSManaged public var roles: [String]?
    @NSManaged public var img: String?
    @NSManaged public var icon: String?
    @NSManaged public var base_health: Double
    @NSManaged public var base_health_regen: Double
    @NSManaged public var base_mana: Double
    @NSManaged public var base_mana_regen: Double
    @NSManaged public var base_armor: Double
    @NSManaged public var base_mr: Double
    @NSManaged public var base_attack_min: Double
    @NSManaged public var base_attack_max: Double
    @NSManaged public var base_str: Double
    @NSManaged public var base_agi: Double
    @NSManaged public var base_int: Double
    @NSManaged public var move_speed: Double

}
