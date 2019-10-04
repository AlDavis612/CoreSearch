//
//  Document+CoreDataProperties.swift
//  DocumentCoreDataSearch
//
//  Created by Alex Davis on 10/4/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var content: String?
    @NSManaged public var size: Int64
    @NSManaged public var rawDateModified: Date?
    @NSManaged public var name: String?

}
