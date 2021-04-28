//
//  TypesCell.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import UIKit

class TypesCell: UITableViewCell {
    
    @IBOutlet weak var typesStackView: UIStackView!
    
    var types: [Type]? {
        didSet {
            Init()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func Init() {
        for v in self.typesStackView.subviews{
           v.removeFromSuperview()
        }
        if self.types != nil {
            for elem in self.types! {
                if elem.type != nil {
                    let button = UIButton()
                    button.setTitle(elem.type!.name?.capitalized, for: .normal)
                    if elem.type!.name != nil {
                        switch elem.type!.name! {
                        case Const.NORMAL.rawValue:
                            button.backgroundColor = UIColor.init(red: 170, green: 170, blue: 153, alpha: 1)
                        case Const.FIGHTING.rawValue:
                            button.backgroundColor = UIColor.init(red: 187, green: 85, blue: 68, alpha: 1)
                        case Const.FLYING.rawValue:
                            button.backgroundColor = UIColor.init(red: 136, green: 153, blue: 255, alpha: 1)
                        case Const.POISON.rawValue:
                            button.backgroundColor = UIColor.init(red: 170, green: 85, blue: 153, alpha: 1)
                        case Const.GROUND.rawValue:
                            button.backgroundColor = UIColor.init(red: 221, green: 187, blue: 85, alpha: 1)
                        case Const.ROCK.rawValue:
                            button.backgroundColor = UIColor.init(red: 187, green: 170, blue: 102, alpha: 1)
                        case Const.BUG.rawValue:
                            button.backgroundColor = UIColor.init(red: 170, green: 187, blue: 34, alpha: 1)
                        case Const.GHOST.rawValue:
                            button.backgroundColor = UIColor.init(red: 102, green: 102, blue: 187, alpha: 1)
                        case Const.STEEL.rawValue:
                            button.backgroundColor = UIColor.init(red: 170, green: 170, blue: 187, alpha: 1)
                        case Const.FIRE.rawValue:
                            button.backgroundColor = UIColor.init(red: 255, green: 68, blue: 34, alpha: 1)
                        case Const.WATER.rawValue:
                            button.backgroundColor = UIColor.init(red: 51, green: 153, blue: 255, alpha: 1)
                        case Const.GRASS.rawValue:
                            button.backgroundColor = UIColor.init(red: 119, green: 204, blue: 85, alpha: 1)
                        case Const.ELECTRIC.rawValue:
                            button.backgroundColor = UIColor.init(red: 255, green: 204, blue: 51, alpha: 1)
                        case Const.PSYCHIC.rawValue:
                            button.backgroundColor = UIColor.init(red: 255, green: 85, blue: 153, alpha: 1)
                        case Const.ICE.rawValue:
                            button.backgroundColor = UIColor.init(red: 102, green: 204, blue: 255, alpha: 1)
                        case Const.DRAGON.rawValue:
                            button.backgroundColor = UIColor.init(red: 119, green: 102, blue: 238, alpha: 1)
                        case Const.DARK.rawValue:
                            button.backgroundColor = UIColor.init(red: 119, green: 85, blue: 68, alpha: 1)
                        case Const.FAIRY.rawValue:
                            button.backgroundColor = UIColor.init(red: 238, green: 153, blue: 238, alpha: 1)
                        case Const.UNKNOWN.rawValue:
                            button.backgroundColor = UIColor.black
                        case Const.SHADOW.rawValue:
                            button.backgroundColor = UIColor.init(red: 54, green: 47, blue: 36, alpha: 1)
                        default:
                            break
                        }
                    }
                    self.typesStackView.addArrangedSubview(button)
                }
            }
        }
    }
}

