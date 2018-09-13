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
    static let shared = DBService()
    
    private var realm: Realm
    var tasks: [Task]
    
    private init() {
        realm = try! Realm()
        tasks = Array(realm.objects(Task.self))
    }
    
    // print(Realm.Configuration.defaultConfiguration.fileURL)
    
    func setTask(description: String, subject: String, till: Date) {
        let task = Task()
        
        task.desc = description
        task.subject = subject
        task.deadLine = till
        task.date = Date()
        
        try! realm.write {
            realm.add(task)
        }
        
        tasks.append(task)
    }
    
    func eraseTask(at: Int) {
        try! realm.write {
            realm.delete(realm.objects(Task.self)[at])
        }
        
        tasks.remove(at: at)
    }
}

