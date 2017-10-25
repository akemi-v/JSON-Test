//
//  CardWithRequest.swift
//  JSON Test
//
//  Created by Maria Semakova on 10/23/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import UIKit

class CardWithRequestCell: CardCell {
    @IBOutlet weak var requestTextView: UITextView!
    
    @IBAction func pressSubmitButton(_ sender: UIButton) {
        self.configure()
        UIView.animate(withDuration: 0.5, animations: {
            sender.alpha = 0.3
        })
        UIView.animate(withDuration: 0.5, animations: {
            sender.alpha = 1.0
        })
    }
    
}

class EchoJSONCardCell: CardWithRequestCell {
    override func configure() {
        let configuration: ([String: Any]?, Bool) -> () = { [weak self] data, correct in
            
            let queue = DispatchQueue.global(qos: .userInitiated)
            queue.async{
                if correct, data != nil {
                    
                    let result = dictToStringJSON(dict: data!)
                    DispatchQueue.main.async {
                        self?.resultTextView.text = "Result:\n\(result)"
                        
                        guard let newFrame = updateTextViewFrame(textView: self?.resultTextView) else { return }
                        self?.resultTextView.frame = newFrame
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.resultTextView.text = "Result:\nError"
                        
                        guard let newFrame = updateTextViewFrame(textView: self?.resultTextView) else { return }
                        self?.resultTextView.frame = newFrame
                    }
                }
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationUpdateCellHeight"), object: nil)
        }
        JSONManager().getData(mode: "Echo JSON", parameters: self.requestTextView.text, setLoadedData: configuration)
    }
    
}

class ValidationCardCell: CardWithRequestCell {
    override func configure() {
        let configuration: ([String: Any]?, Bool) -> () = { [weak self] data, correct in
            
            let queue = DispatchQueue.global(qos: .userInitiated)
            queue.async{
                if correct, data != nil {
                    
                    let result = dictToString(dict: data!)
                    DispatchQueue.main.async {
                        self?.resultTextView.text = "Result:\n\(result)"
                        
                        guard let newFrame = updateTextViewFrame(textView: self?.resultTextView) else { return }
                        self?.resultTextView.frame = newFrame
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.resultTextView.text = "Result:\nError"
                        
                        guard let newFrame = updateTextViewFrame(textView: self?.resultTextView) else { return }
                        self?.resultTextView.frame = newFrame
                    }
                }
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationUpdateCellHeight"), object: nil)
        }
        JSONManager().getData(mode: "Validation", parameters: self.requestTextView.text, setLoadedData: configuration)
    }
}

