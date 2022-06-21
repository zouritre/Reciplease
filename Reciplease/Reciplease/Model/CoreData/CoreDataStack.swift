//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 21/06/2022.
//

import Foundation
import CoreData

final class CoreDataStack {

    // MARK: - Singleton

    static let sharedInstance = CoreDataStack()
    
    private init() {
        
        appDelegate = AppDelegate()
        
        persistentContainer = appDelegate.persistentContainer
    
    }
    
    // MARK: - Private
    
    private var appDelegate: AppDelegate
    
    private var persistentContainer: NSPersistentCloudKitContainer

    // MARK: - Public

    var viewContext: NSManagedObjectContext {
      
      return persistentContainer.viewContext

    }
    
    func saveContext() {
        
        appDelegate.saveContext()
    
    }

}
