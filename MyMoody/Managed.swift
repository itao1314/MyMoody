//
//  Managed.swift
//  MyMoody
//
//  Created by TaoTao on 2020/1/9.
//  Copyright © 2020 TaoTao. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol Managed: class, NSFetchRequestResult {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}

extension Managed where Self: NSManagedObject {
    static var entityName: String {
        entity().name!
    }
}


