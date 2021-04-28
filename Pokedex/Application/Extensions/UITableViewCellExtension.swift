//
//  UITableViewCellExtension.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 27/04/2021.
//

import Foundation
import UIKit

extension UITableViewCell {
    
  func separator(hide: Bool) {
    separatorInset.left = hide ? bounds.size.width : 0
  }
    
}
