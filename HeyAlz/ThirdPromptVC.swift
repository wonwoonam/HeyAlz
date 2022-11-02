//
//  ThirdPromptVC.swift
//  HeyAlz
//
//  Created by Won Woo Nam on 11/2/22.
//
import Foundation
import UIKit
import AVFoundation
import googleapis

class ThirdPromptVC : UIViewController, UITextFieldDelegate    {

    @IBOutlet weak var s1: UITextField!
    @IBOutlet weak var s2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        s1.delegate = self
        s1.returnKeyType = .done
        
        s2.delegate = self
        s2.returnKeyType = .done
        
        
    }

   
    @IBAction func unityPressed(_ sender: Any) {
        //        Unity.shared.show()
            UnityEmbeddedSwift.showUnity()
            /*UnityEmbeddedSwift.sendUnityMessage(
                                "Buttonss",
                                methodName: "SetBallColor",
                                message: textView.text
                            )
            */
            let uView = UnityEmbeddedSwift.getUnityView() ?? UIView()
            //let num = self.view.subviews.count
            uView.frame = CGRect(x: 0, y: 0, width: uView.frame.height, height: uView.frame.width)
            self.view.addSubview(uView)

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
}

