//
//  TweeterTests.swift
//  TweeterTests
//
//  Created by mac on 11/23/18.
//  Copyright © 2018 NNM. All rights reserved.
//

import XCTest
@testable import Tweeter

class TweeterTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSubTweet() {
        let tweetString = "The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog"
        let tweetViewModel = TweetViewModel()
        tweetViewModel.addTweet(tweetString: tweetString)
        
        XCTAssertEqual(tweetViewModel.tweetArray[0].subArray[0], "1/2 The quick brown fox jumps over the lazy dog", "tweetViewModel.tweetArray[0].subArray[0] should be 1/2 The quick brown fox jumps over the lazy dog")
        XCTAssertEqual(tweetViewModel.tweetArray[0].subArray[1], "2/2 The quick brown fox jumps over the lazy dog", "tweetViewModel.tweetArray[0].subArray[0] should be 2/2 The quick brown fox jumps over the lazy dog")
        
        XCTAssertEqual(tweetViewModel.getTweetAtIndex(index: 0), "1/2 The quick brown fox jumps over the lazy dog (47)\n2/2 The quick brown fox jumps over the lazy dog (47)", "tweetViewModel.tweetArray[0].subArray[0] 1/2 The quick brown fox jumps over the lazy dog (47)\n2/2 The quick brown fox jumps over the lazy dog (47)")
    }

    func testValidMoreThan50Characters(){
        let tweetViewModel = TweetViewModel()
        let success = tweetViewModel.addTweet(tweetString: "ThequickbrownfoxjumpsoverthelazydogThequickbrownfoxjumpsoverthelazydog")
        XCTAssertEqual(success, false, "tweetViewModel.addTweet(tweetString: ThequickbrownfoxjumpsoverthelazydogThequickbrownfoxjumpsoverthelazydog) should be false")
    }
}
