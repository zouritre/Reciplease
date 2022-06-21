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

    ///Get the context of persistentContainer
    var viewContext: NSManagedObjectContext {
      
      return persistentContainer.viewContext

    }
    
    /// Save the context to the data model
    func saveContext() {
        
        appDelegate.saveContext()
    
    }
    
    /// Create a request to be sent to the persistentContainer for fetching
    /// - Parameter entity: The entity to get data from
    /// - Returns: A NSFetchRequest of the specified entity
    func request<T>(entity: T) -> NSFetchRequest<NSFetchRequestResult> where T:NSManagedObject {
        
        return T.fetchRequest()
        
    }

}
