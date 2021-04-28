//
//  PokemonService.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import Foundation
import Alamofire
import RxSwift


protocol PokemonServiceProtocol {
    
    //Get Pokedex
    func getPokedexPage(url: String) -> Observable<PokedexPage>
    
    //Get Pokemon by url
    func getPokemon(url: String) -> Observable<PokemonDetail>
}


class PokemonService: PokemonServiceProtocol {
    
    //Get Pokedex Page
    func getPokedexPage(url: String) -> Observable<PokedexPage> {
        return Observable.create{ observer in
            
            AF.request(url).responseDecodable(of: PokedexPage.self) { responseData in
                debugPrint("Response: \(responseData)")
                
                let result = responseData.result
                switch(result){
                case .failure(let error):
                    observer.onError(error)
                    return
                case .success:
                    do {
                        let response = try result.get()
                        observer.onNext(response)
                    }
                    catch {
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    //Get Pokemon by url
    func getPokemon(url: String) -> Observable<PokemonDetail> {
        return Observable.create{ observer in
            
            AF.request(url).responseDecodable(of: PokemonDetail.self) { responseData in
                debugPrint("Response: \(responseData)")
                
                let result = responseData.result
                switch(result){
                case .failure(let error):
                    observer.onError(error)
                    return
                case .success:
                    do {
                        let response = try result.get()
                        observer.onNext(response)
                    }
                    catch {
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
}
