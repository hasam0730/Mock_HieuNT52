//
//  CoreDataHandler.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import CoreData


class CoreDataHandler {
    static let shareInstance = CoreDataHandler()
    //-------------------------------------
    // 1.getting record to save
    func addRecord<T: NSManagedObject>(_ type : T.Type) -> T {
        var entityName = T.description()
        entityName = entityName.components(separatedBy: ".")[1]
        let context = CoreDataHandler.shareInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let record = T(entity: entity!, insertInto: context)
        return record
    }
    
    // 2.getting number of records in table
    func recordsInTable<T: NSManagedObject>(_ type : T.Type) -> Int {
        let recs = allRecords(T.self)
        return recs.count
    }
    
    // 3.getting all records in table
    func allRecords<T: NSManagedObject>(_ type : T.Type, sort: NSSortDescriptor? = nil) -> [T] {
        let context = CoreDataHandler.shareInstance.persistentContainer.viewContext
        let request = T.fetchRequest()
        do {
            let results = try context.fetch(request)
            return results as! [T]
        }
        catch {
            print("Error with request: \(error)")
            return []
        }
    }
    
    // 4.getting record by predicating and sort
    func query<T: NSManagedObject>(_ type : T.Type, search: NSPredicate?, sort: NSSortDescriptor? = nil, multiSort: [NSSortDescriptor]? = nil) -> [T] {
        let context = CoreDataHandler.shareInstance.persistentContainer.viewContext
        let request = T.fetchRequest()
        if let predicate = search {
            request.predicate = predicate
        }
        if let sortDescriptors = multiSort {
            request.sortDescriptors = sortDescriptors
        }
        else if let sortDescriptor = sort {
            request.sortDescriptors = [sortDescriptor]
        }
        
        do {
            let results = try context.fetch(request)
            return results as! [T]
        }
        catch {
            print("Error with request: \(error)")
            return []
        }
    }
    
    // 5.delete record
    func deleteRecord(_ object: NSManagedObject) {
        let context = CoreDataHandler.shareInstance.persistentContainer.viewContext
        context.delete(object)
    }
    
    // 6.deleting records by keyword
    func deleteRecords<T: NSManagedObject>(_ type : T.Type, search: NSPredicate? = nil) {
        let context = CoreDataHandler.shareInstance.persistentContainer.viewContext
        let results = query(T.self, search: search)
        for record in results {
            context.delete(record)
        }
    }
    
    // 7.save data to table
    func saveDatabase() {
        let context = CoreDataHandler.shareInstance.persistentContainer.viewContext
        do {
            try context.save()
        }
        catch {
            print("Error saving database: \(error)")
        }
    }
    
    //------------------------------------- khong duoc xoa
//    These methods can be used in the following way:
//    let name = "John Appleseed"
//    
//    let newContact = addRecord(Contact.self)
//    newContact.contactNo = 1
//    newContact.contactName = name
//    
//    let contacts = query(Contact.self, search: NSPredicate(format: "contactName == %@", name))
//    for contact in contacts
//    {
//    print ("Contact name = \(contact.contactName), no = \(contact.contactNo)")
//    }
//    
//    deleteRecords(Contact.self, search: NSPredicate(format: "contactName == %@", name))
//    
//    recs = recordsInTable(Contact.self)
//    print ("Contacts table has \(recs) records")
//    
//    saveDatabase()
    //-------------------------------------

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Mock_HieuNT52")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print(storeDescription)
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                //                return false
            }
        }
        return true
    }
}
