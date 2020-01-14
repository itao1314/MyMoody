//
//  MoodsTableViewController.swift
//  MyMoody
//
//  Created by TaoTao on 2020/1/7.
//  Copyright © 2020 TaoTao. All rights reserved.
//

import UIKit
import CoreData

class MoodsTableViewController: UITableViewController {

    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        let request = Mood.sortedFetchRequest
        request.fetchBatchSize = 20
        request.returnsObjectsAsFaults = false
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
    }

}
