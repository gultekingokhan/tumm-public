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

protocol CoreDataHelperProcotol {

    func save(currency: Currency, failure: @escaping(_ error: Error?) -> Void)
    func fetch() -> [Currency]
}

final class CoreDataHelper: NSObject, CoreDataHelperProcotol {
   
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    public func save(currency: Currency, failure: @escaping(_ error: Error?) -> Void) {
        
        let entity = NSEntityDescription.entity(forEntityName: "CurrencyModel", in: context)
        let newCurrencyModel = NSManagedObject(entity: entity!, insertInto: context)
        
        let objectID = newCurrencyModel.objectID.uriRepresentation().absoluteString
        print("Object ID: \(objectID)")
        
        newCurrencyModel.setValue(objectID, forKey: "id")
        newCurrencyModel.setValue(currency.country, forKey: "name")
        newCurrencyModel.setValue(currency.symbol, forKey: "symbol")
        
        do {
            try context.save()
            failure(nil)
        } catch let anError {
            failure(anError)
        }
    }
    
    public func fetch() -> [Currency] {
        // TODO: Add completion block and fetch them asynchronously.
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrencyModel")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            var currencies: [Currency] = []
            
            for result in results as! [NSManagedObject] {
                
                //let id = result.value(forKey: "id") as! String
                let symbol = result.value(forKey: "name") as! String
                let name = result.value(forKey: "name") as! String
                
                let country = Country(cc: "", symbol: symbol, name: name)
                let currency = Currency(symbol: symbol, value: 0, country: country)
                
                currencies.append(currency)
            }
            
            return currencies
            
        } catch _ {
            return []
        }
    }
}
