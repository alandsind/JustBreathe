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
    var timer = Timer()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //play background music
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bgm", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        }
        catch{
            print(error)
        }
        
        //set index and timer for pulasting background
        index = 0
        setupTimer()
        
        //swiping gradient background color animation
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 0.7).cgColor, UIColor(white: 1, alpha: 0.72).cgColor, UIColor(white: 1, alpha: 0.7).cgColor, UIColor(white: 1, alpha: 0).cgColor]
        gradientLayer.locations = [0, 0.48, 0.5, 0.52, 1]
        
        viewForGradient = UIView(frame: CGRect(x: 0, y: -448, width: 414, height: 1792))
        gradientLayer.frame = viewForGradient.frame
        
        self.viewForGradient.layer.addSublayer(gradientLayer)
        self.view.addSubview(viewForGradient)
    }
    
    //pulsating background animation
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
        
        //pulsating inhale exhale text animation & swiping background position animation
        UIView.animate(withDuration: 4, delay: 0, options: .curveEaseOut, animations: {
            self.breathIndicator.text = "Exhale"
            self.breathIndicator.alpha = 0
            self.breathIndicator.alpha = 1
            self.breathIndicator.transform = CGAffineTransform.identity
            self.viewForGradient.frame = CGRect(x: 0, y: 448, width: self.viewForGradient.frame.width, height: self.viewForGradient.frame.height)
        }) { (completed) in
            UIView.animate(withDuration: 4, delay: 0, options: .curveEaseOut, animations: {
                self.breathIndicator.text = "Inhale"
                self.breathIndicator.alpha = 1
                self.breathIndicator.alpha = 0
                self.breathIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.viewForGradient.frame = CGRect(x: 0, y: -448, width: self.viewForGradient.frame.width, height: self.viewForGradient.frame.height)
            })
        }
        
        //add music but why doesnt work
         
        class MusicPlayer {
            static let shared = MusicPlayer()
            var audioPlayer: AVAudioPlayer?
            
            func startBackgroundMusic() {
                if let bundle = Bundle.main.path(forResource: "BGM", ofType: "mp3") {
                    let backgroundMusic = NSURL(fileURLWithPath: bundle)
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                        guard let audioPlayer = audioPlayer else { return }
                        audioPlayer.numberOfLoops = -1
                        audioPlayer.prepareToPlay()
                        audioPlayer.play()
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        MusicPlayer.shared.startBackgroundMusic()
        
    }
}

