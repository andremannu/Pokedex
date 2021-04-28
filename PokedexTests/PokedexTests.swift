//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import RxSwift
import Alamofire
import XCTest
@testable import Pokedex


class PokedexTests: XCTestCase {

    var sut: PokedexViewModel!
    var mockPokemonService: MockPokemonService!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockPokemonService = MockPokemonService()
        sut = PokedexViewModel(service: mockPokemonService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockPokemonService = nil
        super.tearDown()
    }
    
    func testLoading() {
        let pokedexPage = PokedexPage(count: 1, next: nil, previous: nil, results: [PokemonInfo(name: "Charizard", url: "url")])
        mockPokemonService.getPokedexPage = .success(pokedexPage)
        let pokemon = PokemonDetail(id: 1, name: "Bulbasaur", sprites: Sprite(), types: [Type()], stats: [Stat()])
        mockPokemonService.getPokemonDetail = .success(pokemon)
        
        var loadingStatus: [Bool] = []
        
        let myExpectation = XCTestExpectation(description: "Loading status updated")
        
        let disposeBag = DisposeBag()
        sut.isLoadingViewHidden.skip(1)
        .drive(onNext: { (isLoading) in
            loadingStatus.append(isLoading)
        })
        .disposed(by: disposeBag)
        
        sut.getPokemonList(url: "url")
        
        XCTAssert(loadingStatus.count == 2)
        XCTAssert(loadingStatus[0] == true)
        XCTAssert(loadingStatus[1] == false)
        
        myExpectation.fulfill()
        
        wait(for: [myExpectation], timeout: 0.1)
        
    }
    
    func testError() {
        let error = AFError.createURLRequestFailed(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error in API Response"]))
        mockPokemonService.getPokedexPage = .failure(error)

        let myExpectation = XCTestExpectation(description: "Error messages are the same")

        let disposeBag = DisposeBag()
        sut.errorVerified.skip(1)
        .drive(onNext: { (errorVerified) in
            XCTAssert(errorVerified?.localizedDescription == error.localizedDescription)
            myExpectation.fulfill()
        })
        .disposed(by: disposeBag)

        sut.getPokemonList(url: "url")
        wait(for: [myExpectation], timeout: 0.1)
    }
    
    func testSuccess() {
        let pokedexPage = PokedexPage(count: 1, next: nil, previous: nil, results: [PokemonInfo(name: "Charizard", url: "url")])
        mockPokemonService.getPokedexPage = .success(pokedexPage)
        let pokemon = PokemonDetail(id: 1, name: "Bulbasaur", sprites: Sprite(), types: [Type()], stats: [Stat()])
        mockPokemonService.getPokemonDetail = .success(pokemon)

        let myExpectation = XCTestExpectation(description: "Pokemon loaded successfully")

        let disposeBag = DisposeBag()
        sut.pokemonLoaded.skip(1)
        .drive(onNext: { (success) in
            XCTAssert(success == true)
            myExpectation.fulfill()
        })
        .disposed(by: disposeBag)

        sut.getPokemonList(url: "url")
        wait(for: [myExpectation], timeout: 0.1)
        
    }
}

