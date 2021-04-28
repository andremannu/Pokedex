//
//  StatsCell.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import UIKit

class StatsCell: UITableViewCell {
    
    @IBOutlet weak var statsStackView: UIStackView!
    
    var stats: [Stat]? {
        didSet {
            Init()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func Init() {
        for v in self.statsStackView.subviews{
           v.removeFromSuperview()
        }
        if self.stats != nil {
            for elem in self.stats! {
                if elem.base_stat != nil && elem.stat != nil {
                    let hStackView = UIStackView()
                   
                    hStackView.axis = .horizontal
                    hStackView.alignment = .fill
                    hStackView.distribution = .fillEqually
                    hStackView.spacing = 8
                    
                    let lblStatName = UILabel()
                    lblStatName.text = elem.stat!.name?.capitalized
                    hStackView.addArrangedSubview(lblStatName)
                    
                    let lblStatValue = UILabel()
                    lblStatValue.text = String(elem.base_stat!)
                    lblStatValue.textAlignment = .right
                    hStackView.addArrangedSubview(lblStatValue)
                    
                    lblStatName.widthAnchor.constraint(equalTo: hStackView.widthAnchor, multiplier: 0.8).isActive = true
                    lblStatValue.widthAnchor.constraint(equalTo: hStackView.widthAnchor, multiplier: 0.2).isActive = true
                    self.statsStackView.addArrangedSubview(hStackView)
                }
            }
        }
    }
}
