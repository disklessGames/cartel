//
//  UserDO.swift
//  Cartel
//
//  Created by Jannie Theron on 2014/08/05.
//  Copyright (c) 2014 Tuism. All rights reserved.
//

import Foundation

class Player {
    var name:String
    var hand:[Card]
    init(name:String){
        self.name = name
        self.hand = []
    }
}