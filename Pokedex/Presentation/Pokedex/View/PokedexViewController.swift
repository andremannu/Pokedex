//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import UIKit
import RxSwift

class PokedexViewController: UIViewController, PokedexRoutingLogic {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var viewModel: PokedexViewModel!
    
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.contentInset.bottom = 100
        tableView.isHidden = true
        
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.barTintColor = UIColor(netHex: 0xff9800, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.firstLoad {
            viewModel.getPokemonList(url: Const.POKEDEX_URL.rawValue)
            viewModel.firstLoad = false
        }
    }
    
    private func setupBindings() {
        
        viewModel.isLoadingViewHidden.skip(1)
            .drive(indicatorView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.errorVerified.skip(1)
            .drive { (error) in
                self.indicatorView.stopAnimating()
                let warningAlert = UIAlertController(title: "Error", message: error.debugDescription, preferredStyle: .alert)
                warningAlert.addAction( UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(warningAlert, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.pokemonLoaded.skip(1)
            .drive { _ in
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.selectedPokemon = self?.viewModel.pokedex.pokemonList[indexPath.row]
                self?.showPokemonDetails()
                self?.tableView.deselectRow(at: indexPath, animated: false)
            })
            .disposed(by: disposeBag)
    }
}


extension PokedexViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokedex.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCellIdentifier", for: indexPath) as! PokedexCell
        
        if indexPath.row == viewModel.pokedex.pokemonList.count - 1 {
            if let page = viewModel.pokedexPage {
                if let next = page.next {
                    cell.pokemonName.isHidden = true
                    cell.pokemonImageView.isHidden = true
                    cell.indicatorView.startAnimating()
                    cell.separator(hide: true)
                    viewModel.getPokemonList(url: next)
                }
            }
        }
        else {
            if let imageUrl = viewModel.pokedex.pokemonList[indexPath.row].sprites?.front_default {
                cell.setPokemonImage(url: imageUrl)
            }
            cell.pokemonName.text = viewModel.pokedex.pokemonList[indexPath.row].name?.capitalized
            cell.pokemonName.isHidden = false
            cell.pokemonImageView.isHidden = false
            cell.indicatorView.stopAnimating()
            cell.separator(hide: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == viewModel.pokedex.pokemonList.count - 1 {
            return 100
        }
        
        return UITableView.automaticDimension
    }
}

