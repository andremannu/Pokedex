//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PokemonViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
        tableView.contentInset.bottom = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.tintColor = UIColor.white
    }
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCellIdentifier", for: indexPath) as! SliderCell
            cell.images = viewModel.pokemon?.sprites
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCellIdentifier", for: indexPath) as! NameCell
            cell.lblPokeName.text = viewModel.pokemon?.name?.capitalized
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypesCellIdentifier", for: indexPath) as! TypesCell
            cell.types = viewModel.pokemon?.types
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCellIdentifier", for: indexPath) as! StatsCell
            cell.stats = viewModel.pokemon?.stats
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

