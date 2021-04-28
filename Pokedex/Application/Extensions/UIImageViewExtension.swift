//
//  UIImageViewExtension.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    static let cache = NSCache<AnyObject, AnyObject>()
    
    // Load image async
    func loadImageUrlString(urlString: String, cache: NSCache<AnyObject, AnyObject>){
    
        let imageUrlString = urlString
        let url = NSURL(string: urlString)
        
        
        if let imageFromCache = UIImageView.cache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        let request = URLRequest(url: url! as URL)
        
        self.alpha = 0.0
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: request, completionHandler: {(data, responses,error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                print(responses!)
                
                DispatchQueue.main.async {
                    if(data != nil){
                        let imgToCache = UIImage(data: data!)
                        if(imgToCache != nil){
                            if imageUrlString == urlString {
                                self.image = imgToCache!
                                self.alpha = 1.0
                            }
                            UIImageView.cache.setObject(imgToCache!, forKey: urlString as AnyObject)
                        }
                    }
                }
            }).resume()
        }
    }
}
