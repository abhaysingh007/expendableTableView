//
//  Model.swift
//  Expandble Table View
//
//  Created by abhay singh on 10/02/17.
//  Copyright © 2017 abhay singh. All rights reserved.
//

import Foundation

struct Detail{
    var team: String!
    var name: [String]!
    var isCollapsed: Bool!
    
    init(team: String, name: [String], isCollapsed: Bool = true) {
        self.team = team
        self.name = name
        self.isCollapsed = isCollapsed
    }
}
