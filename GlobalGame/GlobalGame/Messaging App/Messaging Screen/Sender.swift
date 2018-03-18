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
    
    let name : String //name
    let color : UIColor //text color
    let knownFrom : SenderKnownFrom //where the player knows them from
    let newMessage : Bool //whether or not there is a new message from this person that the player has not read yet
    //could be unnecessary, but I think it would look nice and give a bit more visual indication. could be helpful for other things too to have this property
    
    public init(name: String, color: UIColor, knownFrom : SenderKnownFrom) {
        self.name = name
        self.color = color
        self.knownFrom = knownFrom
        self.newMessage = true; //true for now just to see how it would look visually. proly should set to false at v beginning REMINDER TO NINA: setback to false before pushing please
    }
}

public enum SenderKnownFrom {
    case Contacts
    case Wink
}
