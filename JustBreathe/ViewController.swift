//
//  ViewController.swift
//  JustBreathe
//
//  Created by Aland Sinduartha on 20/05/19.
//  Copyright © 2019 Aland Sinduartha. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //gradient & pulsating background
    @IBOutlet weak var breathIndicator: UILabel!
    var bgColors: [UIColor] = [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
    var index: Int = 0
    var viewForGradient = UIView()
    var songPlayer = AVAudioFile()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        index = 0
        setupTimer()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 0.7).cgColor, UIColor(white: 1, alpha: 0.72).cgColor, UIColor(white: 1, alpha: 0.7).cgColor, UIColor(white: 1, alpha: 0).cgColor]
        gradientLayer.locations = [0, 0.48, 0.5, 0.52, 1]
        
        viewForGradient = UIView(frame: CGRect(x: 0, y: -448, width: 414, height: 1792))
        gradientLayer.frame = viewForGradient.frame
        
        self.viewForGradient.layer.addSublayer(gradientLayer)
        self.view.addSubview(viewForGradient)
    
    }
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(handleColorChange), userInfo: nil, repeats: true)
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
        UIView.animate(withDuration: 4, animations:  {
            self.view.backgroundColor = self.bgColors[self.index]
            
        })
        
        UIView.animate(withDuration: 4, animations: {
            self.breathIndicator.text = "Exhale"
            self.viewForGradient.frame = CGRect(x: 0, y: 448, width: self.viewForGradient.frame.width, height: self.viewForGradient.frame.height)
        }) { (completed) in
            UIView.animate(withDuration: 4, animations: {
                self.breathIndicator.text = "Inhale"
                self.viewForGradient.frame = CGRect(x: 0, y: -448, width: self.viewForGradient.frame.width, height: self.viewForGradient.frame.height)
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

