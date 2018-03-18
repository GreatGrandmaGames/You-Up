//
//  AnimationController.swift
//  GlobalGame
//
//  Created by Nina Demirjian on 3/15/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

//IGNORE THIS FOR NOW! WAS trying to get transitions going adn failed
import Foundation
import UIKit

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    //private let originFrame: CGRect
    
   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
            else {
                return
        }
        
        // 2
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        // 3
        //snapshot.frame = originFrame
        snapshot.layer.masksToBounds = true
        
        
        // 1
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.isHidden = true
        
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
              
               
        },
            // 5
            completion: { _ in
                toVC.view.isHidden = false
                snapshot.removeFromSuperview()
                fromVC.view.layer.transform = CATransform3DIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    
    
}
