//
//  TweetViewModel.swift
//  Tweeter
//
//  Created by mac on 11/22/18.
//  Copyright © 2018 NNM. All rights reserved.
//

import UIKit

class TweetViewModel: NSObject {
    var tweetArray : [TweetModel] = []
    
    func addTweet(tweetString : String) -> Bool{
        var success = true
        let maxLengthOfSub = 50
        
        let tweetModel = TweetModel()
        tweetModel.raw = tweetString
        
        var estTotal = tweetString.count/maxLengthOfSub
        if (estTotal == 0){
            tweetModel.subArray.append(tweetString)
            tweetModel.displayTweet = tweetString + " (\(tweetString.count))"
            
            tweetArray.append(tweetModel)
        }else{
            var condition = true
            while condition {
                var tempArray = tweetString.split(separator: " ")
                tweetModel.subArray = [String]()
                
                var currentTotal = 0
                
                var tempString = "\(currentTotal + 1)/\(estTotal)"
                
                while (currentTotal < estTotal && tempArray.count != 0){
                    let item = tempArray.first!
                    if (tempString.count + item.count + 1 <= 50){
                        tempString = tempString + " " + item
                        tempArray.removeFirst()
                    }else{
                        tweetModel.subArray.append(tempString)
                        currentTotal += 1
                        tempString = "\(currentTotal + 1)/\(estTotal)"
                        if (tempArray.count != 0){
                            let nextCount = tempString.count + tempArray.first!.count
                            if (nextCount > 50){
                                success = false
                                condition = false
                                break
                            }
                        }
                    }
                    if (tempArray.count == 0){
                        tweetModel.subArray.append(tempString)
                    }
                }
                
                if (tempArray.count == 0){
                    condition = false
                }else{
                    estTotal += 1
                }
                
                if (!condition && success){
                    var displayTweet = ""
                    var count = 0
                    for item in tweetModel.subArray {
                        displayTweet = displayTweet + item + " (\(item.count))"
                        count+=1
                        if (count < tweetModel.subArray.count){
                            displayTweet = displayTweet + "\n"
                        }
                    }
                    tweetModel.displayTweet = displayTweet
                    
                    tweetArray.append(tweetModel)
                }
            }
        }
        
        return success
    }
    
    func count() -> Int{
        return tweetArray.count
    }
    
    func getTweetAtIndex(index : Int) -> String {
        return tweetArray[index].displayTweet
    }
    
    static func validTweet(tweetString : String) -> Bool{
        if (tweetString.rangeOfCharacter(from: .whitespaces) != nil){
            let tempArray = tweetString.components(separatedBy: .whitespaces)
            for item in tempArray{
                if (item.count > 50){
                    return false
                }
            }
            return true
        }
        
        if (tweetString.count <= 50){
            return true
        }
        
        return false
    }
}
