import Foundation
import UIKit
import AVFoundation
import googleapis



class PromptViewController : UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate   {
 
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var redoButton: UIButton!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
  override func viewDidLoad() {
    super.viewDidLoad()
      
     
      recordingSession = AVAudioSession.sharedInstance()

      do {
          try recordingSession.setCategory(.playAndRecord, mode: .default)
          try recordingSession.setActive(true)
          recordingSession.requestRecordPermission() { [unowned self] allowed in
              DispatchQueue.main.async {
                  if allowed {
                      print("success")
                  } else {
                      // failed to record!
                  }
              }
          }
      } catch {
          // failed to record!
      }
    
  }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordingLabel.text = "Recording..."
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            let image = UIImage(named: "play")
            recordButton.setBackgroundImage(image, for: UIControl.State.normal)
            
            
            let image2 = UIImage(named: "redo")
            redoButton.setBackgroundImage(image2, for: UIControl.State.normal)
            
            
            recordingLabel.text = ""
            
            mainLabel.text = "Play the converstation"
            minorLabel.text = "Press to play or re-record the voice"
            
        } else {
            print("again")
            //recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
  
}


//@IBAction func playUnity(_ sender: Any) {
//
////        Unity.shared.show()
//    UnityEmbeddedSwift.showUnity()
//    /*UnityEmbeddedSwift.sendUnityMessage(
//                        "Buttonss",
//                        methodName: "SetBallColor",
//                        message: textView.text
//                    )
//    */
//    let uView = UnityEmbeddedSwift.getUnityView() ?? UIView()
//    //let num = self.view.subviews.count
//    uView.frame = CGRect(x: 0, y: 0, width: uView.frame.height, height: uView.frame.width)
//    self.view.addSubview(uView)
//}
