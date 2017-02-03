//
//  cards.swift
//  ChineseFlashcards
//
//  Created by Daniel Galyean on 1/18/17.
//  Copyright © 2017 Daniel Galyean. All rights reserved.
//

import Foundation
import RealmSwift

class cards: Object {
    dynamic var id = 0
    dynamic var front = ""
    dynamic var back = ""
    dynamic var character = ""
    dynamic var category = 0
}

class cat: Object {
    dynamic var category = 0
    dynamic var title = ""
}
