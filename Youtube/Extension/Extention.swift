//
//  Extention.swift
//  Youtube
//
//  Created by TT Nguyen on 10/2/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

enum SettingName: String {
    case Settings = "Settings"
    case TermPrivacy = "Terms & Privacy Policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Cancel & Dismiss"
}

class Setting: NSObject {
    let name: SettingName
    let image: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.image = imageName
    }
}



extension UIView {
    func addConstraintsWithForMat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        let url = NSURL(string: urlString)
        imageUrlString = urlString
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, respones, error) in
            
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            })
            
        }).resume()
    }
}
