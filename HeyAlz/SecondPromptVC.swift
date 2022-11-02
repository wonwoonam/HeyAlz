//
//  SecondPromptVC.swift
//  HeyAlz
//
//  Created by Won Woo Nam on 11/2/22.
//
import Foundation
import UIKit
import AVFoundation
import googleapis

class SecondPromptVC : UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate   {
    
    var player: AVAudioPlayer?
    var counter = 0
    var counterAdd = 0
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var playBtn2: UIButton!
    @IBOutlet weak var playBtn1: UIButton!
    
    func playSound(sname:String) {
        if let asset = NSDataAsset(name:sname){
        
              do {
                    // Use NSDataAsset's data property to access the audio file stored in Sound.
                     player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                    // Play the above sound file.
                    player?.play()
              } catch let error as NSError {
                    print(error.localizedDescription)
              }
           }
    }
    
    @IBAction func playClicked(_ sender: Any) {
        
        if counter == 0{
            playSound(sname: "first")
            counter+=1
        }else{
            playSound(sname: "second")
        }
    }
    
    @IBAction func addClicked(_ sender: Any) {
        if counterAdd == 0{
            label1.isHidden = false
            playBtn1.isHidden = false
            counterAdd+=1
        }else{
            label2.isHidden = false
            playBtn2.isHidden = false
        }
    }
    
}

