//
//  MoodyStack.swift
//  MyMoody
//
//  Created by TaoTao on 2020/1/8.
//  Copyright © 2020 TaoTao. All rights reserved.
//

import Foundation
import CoreData

func createMoodyContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    let container = NSPersistentContainer(name: "Moody")
    container.loadPersistentStores { (_, error) in
        guard error == nil else { fatalError("Failed to load store: \(error!)") }
        DispatchQueue.main.async {
            completion(container)
        }
    }
}
