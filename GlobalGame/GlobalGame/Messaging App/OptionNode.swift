//
//  OptionNode.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import SpriteKit

public class OptionNode : MessageNode {
    
    let option : Option
    
    public init(_ o: Option) {
        option = o
        
        super.init(o.messageToDisplay)
        
        //hardcode
        super.background.size = CGSize(width: 100.0, height: 60.0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
