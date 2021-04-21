//
//  TabBarVC.swift
//  swipable-segment
//
//  Created by Shaik abdul mazeed on 21/04/21.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        var swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        // Do any additional setup after loading the view.
    }
    @objc func swipeGesture(swipe: UISwipeGestureRecognizer){
        
        switch swipe.direction {
        case .left:
            if selectedIndex > 0{
                self.selectedIndex = self.selectedIndex - 1
            }
            break
        case .right:
            if selectedIndex < 4{
                self.selectedIndex = self.selectedIndex + 1
            }
            break
        default:
            break
        }
        
    }
}
extension TabBarVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabViewAnimation()
    }
}
class TabViewAnimation: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        destination.transform = CGAffineTransform(translationX: 0, y: destination.frame.height)
        transitionContext.containerView.addSubview(destination)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            destination.transform = .identity
        } completion: { transitionContext.completeTransition($0)
        }

    }
    
    
}
