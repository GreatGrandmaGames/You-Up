//
//  OptionNode.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import SpriteKit

public class OptionNode : MultiLineLabelNode {
    
    let option : Option
    
    public init(_ o: Option) {
        option = o
        
        super.init(backgroundTexture: SKTexture(imageNamed: "betterWhiteBox"), backgroundColor: UIColor.lightGray, text: o.text, fontName: "Avenir", textSize: 36.0)
        
        for l in super.lines {
            l.name = "Option Node"
        }

        //hardcode
        super.background.size = CGSize(width: 650.0, height: 80.0)
        super.background.name = "Option Node"
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
