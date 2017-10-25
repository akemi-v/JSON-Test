//
//  CardCell.swift
//  JSON Test
//
//  Created by Maria Semakova on 10/23/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import UIKit

protocol Card {
    func configure()
}

class CardCell: UITableViewCell, Card {
        
    @IBOutlet weak var resultTextView: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
    }

}

class IPAddressCardCell: CardCell {
    
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
        JSONManager().getData(mode: "IP Address", parameters: nil, setLoadedData: configuration)
    }
}

class DateTimeCardCell: CardCell {
    
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
        JSONManager().getData(mode: "Date & Time", parameters: nil, setLoadedData: configuration)
    }
}

class HeadersCardCell: CardCell {
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
        JSONManager().getData(mode: "Headers", parameters: nil, setLoadedData: configuration)
    }
}

