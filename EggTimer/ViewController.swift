//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


let minute = 60
let eggTimes = ["Soft":5 * minute, "Medium":7 * minute, "Hard":12 * minute]
var timer = Timer()
var seconds = 0
var secondsPassed = 0
var player: AVAudioPlayer!

class ViewController: UIViewController {
    @IBOutlet weak var eggStatus: UILabel!
    @IBOutlet weak var RemainingTime: UILabel!
    
    @IBOutlet weak var timePassed: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        secondsPassed = 0
        let hardness = sender.currentTitle!
        eggStatus.text = "Let's Start Making a \(hardness) egg:"
        timePassed.progress = 0
        timer.invalidate()
        seconds = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(prepareEgg), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func prepareEgg(){
        secondsPassed += 1
        RemainingTime.text = "\(secondsPassed) Seconds"
        if  secondsPassed <= seconds{
            timePassed.progress = Float(secondsPassed) / Float(seconds)
        }
        else{
            timer.invalidate()
            eggStatus.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    


}
