//
//  ViewController.swift
//  HeyAlz
//
//  Created by Won Woo Nam on 10/21/22.
//

import UIKit
import UniformTypeIdentifiers


class ViewController: UIViewController, UIDocumentPickerDelegate {

    @IBOutlet weak var OpenButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi")
    }


    @IBAction func browseFile(_ sender: Any) {
        
        openDocumentPicker()
    }
    
    
    
    func openDocumentPicker() {
        var supportedTypes: [UTType]
        supportedTypes = [UTType.pdf, UTType.usdz]
        let glbUTType = UTType("com.app.glb")
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [
            UTType.data, UTType.content
        ],
        asCopy: true)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen

        present(documentPicker, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileURL = urls[0]
       print("hihi")
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "prompt1") as! PromptViewController
        self.present(loginVC, animated:true, completion:nil)
    }
}

