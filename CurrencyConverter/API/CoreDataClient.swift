//
//  CoreDataHelper.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 25.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataClientProcotol {
    
    static func save(rate: Rate, completion:() -> Void)
    static func remove(rate: Rate, completion:() -> Void)
    static func update(oldRate: Rate, newRate: Rate, completion:() -> Void)
    static func fetch(completion:(_ rates: [Rate]) -> Void)
    
}

struct CoreDataClient: CoreDataClientProcotol {
    
    enum Entity: String {
        case RateModel
    }
    
    static private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func save(rate: Rate, completion:() -> Void) {

        let entity = NSEntityDescription.entity(forEntityName: Entity.RateModel.rawValue, in: context)
        let newRateModel = NSManagedObject(entity: entity!, insertInto: context)
        
        let objectID = newRateModel.objectID.uriRepresentation().absoluteString
        
        newRateModel.setValue(objectID, forKey: "id")
        newRateModel.setValue(rate.name, forKey: "name")
        newRateModel.setValue(rate.code, forKey: "code")
        newRateModel.setValue(rate.type.rawValue, forKey: "type")

        do {
            try context.save()
            completion()
        } catch {
            fatalError("Error while saving rate.")
        }
    }
    
    static func remove(rate: Rate, completion:() -> Void) {

        guard let id = rate.id else { return }

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.RateModel.rawValue)
        request.predicate = NSPredicate(format: "id = %@", id)
        request.returnsObjectsAsFaults = false
        let objects = try! context.fetch(request)
        for obj in objects as! [NSManagedObject]  {
            context.delete(obj)
        }
        
        do {
            try context.save()
            completion()
        } catch {
            fatalError("Error while removing rate.")
        }
    }
    
    static func update(oldRate: Rate, newRate: Rate, completion:() -> Void) {

        guard let id = oldRate.id else { return }

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.RateModel.rawValue)
        request.predicate = NSPredicate(format: "id = %@", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    result.setValue(newRate.name, forKey: "name")
                    result.setValue(newRate.code, forKey: "code")
                    result.setValue(oldRate.type.rawValue, forKey: "type")
                }
            }
            completion()
        } catch {
            fatalError("Error while updating rates.")
        }
    }
    
    static func fetch(completion:(_ rates: [Rate]) -> Void) {
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.RateModel.rawValue)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            var rates: [Rate] = []
            
            for result in results as! [NSManagedObject] {
                
                let id = result.value(forKey: "id") as! String
                let code = result.value(forKey: "code") as! String
                let name = result.value(forKey: "name") as! String
                let type = result.value(forKey: "type") as! String
                
                let rate = Rate(id: id,
                                code: code,
                                type: RateType(rawValue: type)!,
                                name: name)
                
                rates.append(rate)
            }
            
            completion(rates)
        } catch {
            fatalError("Error while fetching rates.")
        }
    }
}
