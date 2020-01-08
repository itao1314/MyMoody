//
//  RootViewController.swift
//  MyMoody
//
//  Created by TaoTao on 2020/1/7.
//  Copyright © 2020 TaoTao. All rights reserved.
//

import UIKit
import CoreData

class RootViewController: UIViewController, SegueHandler {
    
    enum SegueIdentifier: String {
        case embedNavigation = "embedNavigationController"
        case embedCamera = "embedCamera"
    }
    
    @IBOutlet weak var hideCameraConstraint: NSLayoutConstraint!
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .embedNavigation:
            guard let nc = segue.destination as? UINavigationController, let vc = nc.viewControllers.first as? MoodsTableViewController else { fatalError("wrong view controller type") }
            vc.managedObjectContext = managedObjectContext
            nc.delegate = self
        case .embedCamera:
            guard let vc = segue.destination as? CameraViewController else { fatalError("must be camera view controller") }
        }
    }
    
}

extension RootViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
}
