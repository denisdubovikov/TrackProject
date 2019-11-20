//
//  New+CoreDataProperties.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 16/11/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//
//

import Foundation
import CoreData


extension New {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<New> {
        return NSFetchRequest<New>(entityName: "New")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var descr: String?
    @NSManaged public var url: URL?
    @NSManaged public var urlToImage: URL?
    @NSManaged public var date: Date?
    @NSManaged public var content: String?
    @NSManaged public var toListNews: ListNews?

}
