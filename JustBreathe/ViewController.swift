//
//  ViewController.swift
//  JustBreathe
//
//  Created by Aland Sinduartha on 20/05/19.
//  Copyright © 2019 Aland Sinduartha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bgColors: [UIColor] = [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
    var index: Int = 0
    var viewForGradient = UIView()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        index = 0
        setupTimer()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [#colorLiteral(red: 0.9999235272, green: 1, blue: 0.9998829961, alpha: 0).cgColor, UIColor(white: 1, alpha: 0.8).cgColor, UIColor(white: 1, alpha: 0.8).cgColor, UIColor(white: 1, alpha: 0).cgColor]
        gradientLayer.locations = [-0.4, 0.48, 0.52, 1.5]
        
        viewForGradient = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 1792))
        gradientLayer.frame = viewForGradient.frame
        
        self.viewForGradient.layer.addSublayer(gradientLayer)
        self.view.addSubview(viewForGradient)
    
    }
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(handleColorChange), userInfo: nil, repeats: true)
    }
    
    @objc func handleColorChange() {
        
        if index >= 0 && index != bgColors.count - 1{
            index += 1
            //            debugPrint("Checking index add")
        } else if index <= bgColors.count - 1 {
            index -= 1
            //            debugPrint("Checking index minus")
        }

        debugPrint(index)
        UIView.animate(withDuration: 2, animations:  {
            self.view.backgroundColor = self.bgColors[self.index]
            
        })
        
        UIView.animate(withDuration: 2, animations: {
            self.viewForGradient.frame = CGRect(x: 0, y: self.view.frame.height, width: self.viewForGradient.frame.width, height: self.viewForGradient.frame.height)
        }) { (completed) in
            UIView.animate(withDuration: 2, animations: {
                self.viewForGradient.frame = CGRect(x: 0, y: -self.view.frame.height, width: self.viewForGradient.frame.width, height: self.viewForGradient.frame.height)
            })
        }
    }
        
    
        
        //gradient animation
        /*let animation = CABasicAnimation(
            keyPath: "transform.translation.y")
        animation.duration = 2
        animation.fromValue = -view.frame.height
        animation.toValue = view.frame.height
        animation.repeatCount = Float.infinity
        
        //gradientLayer.add(animation, forKey: "upDown")*/
    
        
}

