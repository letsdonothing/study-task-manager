//
//  DBService.swift
//  study notes
//
//  Created by Sergius on 09.09.2018.
//  Copyright © 2018 Sergius. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DBService {
    
    let realm = try! Realm()
    
    // print(Realm.Configuration.defaultConfiguration.fileURL)
    
    var countOfTasks: Int {
        return realm.objects(Task.self).count
    }
    
    func getTask(at: Int) -> Task {
        return realm.objects(Task.self)[at]
    }
    
    func setTask(description: String, subject: String, till: Date) {
        
        let task = Task()
        
        task.desc = description
        task.subject = subject
        task.deadLine = till
        task.date = Date()
        
        try! self.realm.write {
            self.realm.add(task)
        }
    }
    
    func eraseTask(at: Int) {
        try! realm.write {
            realm.delete(self.realm.objects(Task.self)[at])
        }
        
    }
}
