//
//  JSONManager.swift
//  JSON Test
//
//  Created by Maria Semakova on 10/23/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation

class JSONManager {
    
    func getData(mode: String, parameters: String?, setLoadedData: @escaping ([String: Any]?, Bool) -> ()) {
        switch mode {
        case "IP Address":
            print("a")
            loadFromURL(urlString: "http://ip.jsontest.com/", setLoadedData: setLoadedData)
        case "Date & Time":
            loadFromURL(urlString: "http://date.jsontest.com/", setLoadedData: setLoadedData)
        case "Echo JSON":
            loadFromURL(urlString: "http://echo.jsontest.com/\(parameters ?? "")", setLoadedData: setLoadedData)
        case "Validation":
            let encodedParameters = parameters?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            loadFromURL(urlString: "http://validate.jsontest.com/?json=\(encodedParameters ?? "")", setLoadedData: setLoadedData)
        case "Headers":
            print("a")
            loadFromURL(urlString: "http://headers.jsontest.com/", setLoadedData: setLoadedData)
        default:
            print("Error in getting data")
        }
    }
    
    private func loadFromURL(urlString: String, setLoadedData: @escaping ([String: Any]?, Bool) -> ()) {
        let queue = DispatchQueue.global(qos: .background)
        
            guard let trueUrl = URL(string: urlString) else {
                DispatchQueue.main.async {
                    setLoadedData(nil, false)
                }
                return
            }
            queue.async{
            do {
                guard let data = NSData(contentsOf: trueUrl) else {
                    DispatchQueue.main.async {
                    setLoadedData(nil, false)
                    }
                    return
                }
                let jsonData = try JSONSerialization.jsonObject(with: data as Data, options: [])
                if let profileData = jsonData as? [String: Any] {
                    DispatchQueue.main.async {
                        setLoadedData(profileData, true)
                    }
                } else {
                    DispatchQueue.main.async {
                        setLoadedData(nil, false)
                    }
                    return
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
