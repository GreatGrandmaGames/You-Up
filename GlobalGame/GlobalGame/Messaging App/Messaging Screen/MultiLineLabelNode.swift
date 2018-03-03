//
//  MultiLineLabelNode.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import SpriteKit

public class MultiLineLabelNode : SKNode {
    
    public let extraWidthPercentage : CGFloat = 1.1
    public let extraHeightPercentage : CGFloat = 1.3
    
    let background : SKSpriteNode
    var lines : [SKLabelNode]
    
    public init(backgroundTexture: SKTexture, backgroundColor: UIColor, text: String, fontName: String, textSize: CGFloat){
        if(text == ""){
            fatalError("Cannot create a MultiLineLabelNode with an empty string")
        }
        
        lines = [SKLabelNode]()
        
        var i = 0
        var yPos : CGFloat = 0
        var lineNums = 0
        
        while i < text.count {
            lineNums += 1
            
            var lineString = ""
            
            //this is the maxLineCharCount! Adjusrt this to adjust num chars that appear on a single line
            while(i < text.count && i < 35 * lineNums) {
                //Find word
                let startWordIndex = text.index(text.startIndex, offsetBy: i)
                var iAsIndex = startWordIndex
                
                while i < text.count && text[iAsIndex] != " "  {
                    i+=1
                    iAsIndex = text.index(text.startIndex, offsetBy: i)
                }
                
                lineString += text[startWordIndex..<iAsIndex]
                lineString += " "
                i+=1
            }
            
            let lineNode = SKLabelNode(text: lineString)
            lineNode.fontSize = textSize
            lineNode.fontName = fontName

            lineNode.position = CGPoint(x: 0, y: yPos)
            lineNode.zPosition = 0
            
            
            yPos -= lineNode.frame.height
            
            lines.append(lineNode)
        }
        
        
        //calculating the width / height of the box
        var maxWidth :CGFloat = 0
        var totalHeight : CGFloat = 0
        
        for l in lines {
            if(maxWidth < l.frame.width){
                maxWidth = l.frame.width
            }
            
            totalHeight += l.frame.height
        }
        
        self.background = SKSpriteNode(texture: backgroundTexture, color: backgroundColor, size: CGSize(width: maxWidth * extraWidthPercentage, height: totalHeight * extraHeightPercentage))
        
        self.background.colorBlendFactor = 1
        self.background.zPosition = -1
        
        super.init()
        
        self.background.move(toParent: self)
        
        print(background.position)
        
        for l in lines {
            l.move(toParent: self)
            
            print(l.position)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
