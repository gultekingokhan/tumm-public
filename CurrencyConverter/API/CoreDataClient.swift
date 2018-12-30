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

    static func save(rate: Rate, failure: @escaping(_ error: Error?) -> Void)
    static func fetch() -> [Rate]
}

struct CoreDataClient: CoreDataClientProcotol {
   
    static private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func save(rate: Rate, failure: @escaping(_ error: Error?) -> Void) {
        
        let entity = NSEntityDescription.entity(forEntityName: "RateModel", in: context)
        let newRateModel = NSManagedObject(entity: entity!, insertInto: context)
        
        let objectID = newRateModel.objectID.uriRepresentation().absoluteString
        
        newRateModel.setValue(objectID, forKey: "id")
        newRateModel.setValue(rate.name, forKey: "name")
        newRateModel.setValue(rate.code, forKey: "code")
        newRateModel.setValue(rate.type.rawValue, forKey: "type")

        do {
            try context.save()
            failure(nil)
        } catch let anError {
            failure(anError)
        }
    }
    
    static func fetch() -> [Rate] {
        // TODO: Add completion block and fetch them asynchronously.
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RateModel")
        //request.predicate = NSPredicate(format: "age = %@", "12")
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
            
            return rates
            
        } catch _ {
            return []
        }
    }
}
