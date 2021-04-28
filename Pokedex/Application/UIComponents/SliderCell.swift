//
//  SliderCell.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import UIKit

class SliderCell: UITableViewCell {
    
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imagesArray = [String]()
    
    var images: Sprite? {
        didSet {
            Init()
        }
    }
    
    var currentImage = 0 {
        didSet {
            self.pageControl.currentPage = currentImage
        }
    }
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(SliderCell.swipeImage(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(SliderCell.swipeImage(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.addGestureRecognizer(swipeRight)
    }
    
    private func Init() {
        self.imagesArray.removeAll()
        
        if images?.back_default != nil {
            imagesArray.append((images?.back_default!)!)
        }
        if images?.back_female != nil {
            imagesArray.append((images?.back_female!)!)
        }
        if images?.back_shiny != nil {
            imagesArray.append((images?.back_shiny!)!)
        }
        if images?.back_shiny_female != nil {
            imagesArray.append((images?.back_shiny_female!)!)
        }
        if images?.front_default != nil {
            imagesArray.append((images?.front_default!)!)
        }
        if images?.front_female != nil {
            imagesArray.append((images?.front_female!)!)
        }
        if images?.front_shiny != nil {
            imagesArray.append((images?.front_shiny!)!)
        }
        if images?.front_shiny_female != nil {
            imagesArray.append((images?.front_shiny_female!)!)
        }
        
        if self.imagesArray.count > 0 {
            self.pageControl.numberOfPages = self.imagesArray.count
            self.sliderImageView.loadImageUrlString(urlString: imagesArray[self.pageControl.currentPage], cache: self.cache)
        }
    }
    
    @objc func swipeImage(_ recognizer:UISwipeGestureRecognizer) {
        
        var index = self.pageControl.currentPage
        
        if (recognizer.direction == UISwipeGestureRecognizer.Direction.left)
        {
            index += 1
        }
        else if (recognizer.direction == UISwipeGestureRecognizer.Direction.right)
        {
            index -= 1
        }
        
        if (index >= 0 && index < imagesArray.count)
        {
            currentImage = index
            UIView.transition(with: self.sliderImageView, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                self.sliderImageView.loadImageUrlString(urlString: self.imagesArray[index], cache: self.cache)
            }, completion: nil)
        }
    }
}
