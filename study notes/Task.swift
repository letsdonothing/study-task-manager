//
//  Task.swift
//  study notes
//
//  Created by Sergius on 07.09.2018.
//  Copyright © 2018 Sergius. All rights reserved.
//

import Foundation
import RealmSwift

class Task : Object {
    @objc dynamic var desc: String?
    @objc dynamic var subject: String?
    @objc dynamic var date: Date?
    @objc dynamic var deadLine: Date?
}
