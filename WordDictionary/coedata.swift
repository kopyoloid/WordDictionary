//
//  coedata.swift
//  WordDictionary
//
//  Created word kopyoloid on 17/02/21.
//

import UIKit
import CoreData

struct islist {
    
    var image:String?
    var desc:String?
    var word:String?
    
    init() {
        image = ""
        word = ""
        desc = ""
    }
    init(image:String,word:String,desc:String) {
        self.image = image
        self.word = word
        self.desc = desc
    }
}

class coedata: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///store obj into core data
    class func storeObj(image:String,word:String,desc:String) {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Store", in: context)
        
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObj.setValue(image, forKey: "image")
        managedObj.setValue(word, forKey: "word")
        managedObj.setValue(desc, forKey: "desc")
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///fetch all the objects from core data
    class func fetchObj(selectedScopeIdx:Int?=nil,targetText:String?=nil) -> [Store]{
        var aray = [Entity]()
        
        let fetchRequest:NSFetchRequest<Entity> = Entity.fetchRequest()
        
        if selectedScopeIdx != nil && targetText != nil{
            
            var filterKeyword = ""
            switch selectedScopeIdx! {
            case 0:
                filterKeyword = "image"
            case 1:
                filterKeyword = "word"
            default:
                filterKeyword = "desc"
            }

            var predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            //predicate = NSPredicate(format: "word == %@" , "wang")
            //predicate = NSPredicate(format: "desc > %@", "2015")
        
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let img = Store(image: image!, word: word!, desc: desc!)
                islist.append(img)
                print("image: "+img.image!+"\word:"+img.word!+"\nimage by:"+img.desc!+"\n")
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return aray
    }

    ///delete all the data in core data
    class func cleanCoreData() {
        
        let fetchRequest:NSFetchRequest<Entity> = Entity.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all contents")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
        
    }
}
