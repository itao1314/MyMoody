//
//  Mood.swift
//  MyMoody
//
//  Created by TaoTao on 2020/1/8.
//  Copyright © 2020 TaoTao. All rights reserved.
//

import UIKit
import CoreData

final class Mood: NSManagedObject {
    @NSManaged fileprivate(set) var date: Date
    @NSManaged fileprivate(set) var colors: [UIColor]
}

extension Mood: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
