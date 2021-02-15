//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //stops timer
        timer.invalidate()
        
        let hardness = sender.titleLabel!.text!
        
        let time = eggTimes[hardness]!
        print("It will take \(time) seconds to cook")
        totalTime = time
        
        //reset progress
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        //every one second call the updateCounter function
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        

    }
    
    @objc func updateCounter(){
        if secondsPassed < totalTime {
            
            secondsPassed = secondsPassed + 1
            let percentageProgess = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgess
            
        }
        else {
            //stop timer and set label to say "Done"
            timer.invalidate()
            titleLabel.text = "Done!"
            
            
            //play alarm sound
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
        
    }
    

}
