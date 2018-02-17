//
//  Sender.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import SpriteKit

public class Sender : NSObject {
    
    let name : String
    let color : UIColor
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}
