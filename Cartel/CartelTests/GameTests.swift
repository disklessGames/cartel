//
//  CardTests.swift
//  Cartel
//
//  Created by Jannie Theron on 2014/07/31.
//  Copyright (c) 2014 Tuism. All rights reserved.
//

import XCTest
import Cartel

class GameTests: XCTestCase {
    var sut = Game()
    
    override func setUp() {
        let player1 = Player(name: "Piet")
        let player2 = Player(name: "Koos")
        
        sut.setupGame([player1,player2])
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildingCard(){
        // given
        let card = BuildingCard(buildingType: BuildingCardType.anniewares)
        
        
        //then
        XCTAssertEqual(card.type , CardType.building)
    }
    
    func testBankRollSetupCreates71Cards() {
        
        
       //then
        XCTAssertEqual(sut.bankroll.bankrollCards.count, 71)
    }
    
    
    func testCreateCityBoard(){
        
        //then
        XCTAssertEqual(sut.city.count, 2)
    }
    
    
    func testPocketCardsAre15(){
        
        //then
        
        XCTAssertEqual(sut.bankroll.pocketCardsCount(), 15)
    }
    func testRoadCardsAreThereExceptStartingStraights(){
        
        //then
        
        XCTAssertEqual(sut.bankroll.roadCardsCount(), 14)
    }
    func testBuildingCardsAre42(){
        //then
        XCTAssertEqual(sut.bankroll.buildingCardsCount(), 42)
    }
    func testStartingRoadsCreated(){
       //then
        XCTAssertEqual(sut.city[0][0].type, CardType.road)
        XCTAssertEqual(sut.city[1][0].type, CardType.road)
    }
    
    func testNewGameWith2Players(){
        //then
        XCTAssertEqual(sut.players.count, 2)
    }
    
    
    func testPlayerHas4CardsAfterDeal(){
        //when
        sut.deal()
        
        //then
        XCTAssertEqual(sut.players[0].hand.count, 4)
    }
    func testShuffle(){
        //when
        let firstcard = sut.bankroll.bankrollCards[0];
        sut.shuffle()
        //then
        XCTAssertNotEqual(sut.bankroll.bankrollCards[0], firstcard)
    }
    
    func testFlip(){
        //when
        sut.flip()
        //then
        XCTAssertEqual(sut.bankroll.isFlipped, true)
    }

    
}
