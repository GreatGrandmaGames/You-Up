//
//  GameManager.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import SpriteKit

public class GameManager : NSObject {
        
    var senders = [Sender]()
    
    //temp
    public override init() {
        senders.append(Sender(name: "Jason", color: UIColor.blue, knownFrom: .Wink))
        senders.append(Sender(name: "Alvaro", color: UIColor.blue, knownFrom: .Wink))
        senders.append(Sender(name: "Grady", color: UIColor.blue, knownFrom: .Wink))
        senders.append(Sender(name: "Eli", color: UIColor.blue, knownFrom: .Wink))
        senders.append(Sender(name: "Frank", color: UIColor.blue, knownFrom: .Wink))
        senders.append(Sender(name: "Jordan", color: UIColor.blue, knownFrom: .Wink))
        senders.append(Sender(name: "Chris", color: UIColor.blue, knownFrom: .Wink))
        
    }
}
