//
//  ListNews+CoreDataProperties.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 16/11/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//
//

import Foundation
import CoreData


extension ListNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListNews> {
        return NSFetchRequest<ListNews>(entityName: "ListNews")
    }

    @NSManaged public var toNew: NSSet?

}

// MARK: Generated accessors for toNew
extension ListNews {

    @objc(addToNewObject:)
    @NSManaged public func addToToNew(_ value: New)

    @objc(removeToNewObject:)
    @NSManaged public func removeFromToNew(_ value: New)

    @objc(addToNew:)
    @NSManaged public func addToToNew(_ values: NSSet)

    @objc(removeToNew:)
    @NSManaged public func removeFromToNew(_ values: NSSet)

}
