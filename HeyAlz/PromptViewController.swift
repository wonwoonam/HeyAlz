//
//  PromptViewController.swift
//  HeyAlz
//
//  Created by Won Woo Nam on 10/22/22.
//

import Foundation
import UIKit
import AVFoundation
import googleapis



let SAMPLE_RATE = 48000

class PromptViewController : UIViewController, AudioControllerDelegate {
  @IBOutlet weak var textView: UITextView!
  var audioData: NSMutableData!

  override func viewDidLoad() {
    super.viewDidLoad()
    AudioController.sharedInstance.delegate = self
  }
    @IBAction func playUnity(_ sender: Any) {
        
//        Unity.shared.show()
        UnityEmbeddedSwift.showUnity()
        UnityEmbeddedSwift.sendUnityMessage(
                            "Buttonss",
                            methodName: "SetBallColor",
                            message: textView.text
                        )
        
        let uView = UnityEmbeddedSwift.getUnityView() ?? UIView()
        //let num = self.view.subviews.count
        uView.frame = CGRect(x: 0, y: 0, width: uView.frame.height, height: uView.frame.width)
        self.view.addSubview(uView)
    }
    
    
  @IBAction func recordAudio(_ sender: NSObject) {
    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.setCategory(AVAudioSession.Category.record)
    } catch {

    }
    audioData = NSMutableData()
    _ = AudioController.sharedInstance.prepare(specifiedSampleRate: SAMPLE_RATE)
    SpeechRecognitionService.sharedInstance.sampleRate = SAMPLE_RATE
    _ = AudioController.sharedInstance.start()
  }

  @IBAction func stopAudio(_ sender: NSObject) {
    _ = AudioController.sharedInstance.stop()
    SpeechRecognitionService.sharedInstance.stopStreaming()
  }

  func processSampleData(_ data: Data) -> Void {
    audioData.append(data)

    // We recommend sending samples in 100ms chunks
    let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
      * Double(SAMPLE_RATE) /* samples/second */
      * 2 /* bytes/sample */);

    if (audioData.length > chunkSize) {
      SpeechRecognitionService.sharedInstance.streamAudioData(audioData,
                                                              completion:
        { [weak self] (response, error) in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                strongSelf.textView.text = error.localizedDescription
            } else if let response = response {
                var finished = false
                print(response)
                for result in response.resultsArray! {
                    if let result = result as? StreamingRecognitionResult {
                        if result.isFinal {
                            finished = true
                            let tmpBestResult = (response.resultsArray.firstObject as! StreamingRecognitionResult)
                            let tmpBestAlternativeOfResult = tmpBestResult.alternativesArray.firstObject as! SpeechRecognitionAlternative
                            let bestTranscript = tmpBestAlternativeOfResult.transcript
                            strongSelf.textView.text = "Hey, I'm David"
                        }
                    }
                }
                
                if finished {
                    strongSelf.stopAudio(strongSelf)
                }
            }
      })
      self.audioData = NSMutableData()
    }
  }
}





//let SAMPLE_RATE = 16000
//
//class PromptViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate, AudioControllerDelegate {
//
//    var audioData: NSMutableData!
//    func processSampleData(_ data: Data) -> Void {
//      audioData.append(data)
//
//      // We recommend sending samples in 100ms chunks
//      let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
//        * Double(SAMPLE_RATE) /* samples/second */
//        * 2 /* bytes/sample */);
//
//      if (audioData.length > chunkSize) {
//        SpeechRecognitionService.sharedInstance.streamAudioData(audioData,
//                                                                completion:
//          { [weak self] (response, error) in
//              guard let strongSelf = self else {
//                  return
//              }
//
//              if let error = error {
//                  strongSelf.spokenTextView.text = error.localizedDescription
//              } else if let response = response {
//                  var finished = false
//                  print(response)
//                  for result in response.resultsArray! {
//                      if let result = result as? StreamingRecognitionResult {
//                          if result.isFinal {
//                              finished = true
//                          }
//                      }
//                  }
//                  strongSelf.spokenTextView.text = response.description
//                  if finished {
//                      strongSelf.stopAudio(strongSelf)
//                  }
//              }
//        })
//        self.audioData = NSMutableData()
//      }
//    }
//  }
//
//
//    @IBOutlet var recordButton: UIButton!
//
//    var recordingSession: AVAudioSession!
//    var audioRecorder: AVAudioRecorder!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        recordingSession = AVAudioSession.sharedInstance()
//
//        do {
//            try recordingSession.setCategory(.playAndRecord, mode: .default)
//            try recordingSession.setActive(true)
//            recordingSession.requestRecordPermission() { [unowned self] allowed in
//                DispatchQueue.main.async {
//                    if allowed {
//                        self.loadRecordingUI()
//                    } else {
//                        // failed to record!
//                    }
//                }
//            }
//        } catch {
//            // failed to record!
//        }
//
//    }
//
//    @objc @IBAction func Recordd(_ sender: Any) {
//        if audioRecorder == nil {
//                startRecording()
//            } else {
//                finishRecording(success: true)
//            }
//    }
//
//
//    func loadRecordingUI() {
//        recordButton = UIButton(frame: CGRect(x: 64, y: 64, width: 128, height: 64))
//        recordButton.setTitle("Tap to Record", for: .normal)
//        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
//        recordButton.addTarget(self, action: #selector(Recordd), for: .touchUpInside)
//        view.addSubview(recordButton)
//    }
//
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//
//    func finishRecording(success: Bool) {
//        audioRecorder.stop()
//        audioRecorder = nil
//
//        if success {
//            recordButton.setTitle("Tap to Re-record", for: .normal)
//        } else {
//            recordButton.setTitle("Tap to Record", for: .normal)
//            // recording failed :(
//        }
//    }
//    func startRecording() {
//        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//        print(audioFilename)
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//
//        do {
//            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//
//            recordButton.setTitle("Tap to Stop", for: .normal)
//        } catch {
//            finishRecording(success: false)
//        }
//    }
//
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//            finishRecording(success: false)
//        }
//    }
//
//
//
//}
//
