//
//  hearthstoneJsonParser.playground
//  Created by Sugandha Naolekar on 08/27/16.
//  JSON files provided by Udacity as a part of Udacity iOS nanodegree
//

/*
 Following are the motives of parsing this json file:
 1. How many minions have a cost 5?
 2. How many weapons have a durability of 2?
 3. How many minions have a "Battlecry" effect mentioned in their text??
 4. What is the average cost of common minions?
 */


import Foundation

/* Path for JSON files bundled with the Playground */
var pathForHearthstoneJSON = NSBundle.mainBundle().pathForResource("hearthstone", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawHearthstoneJSON = NSData(contentsOfFile: pathForHearthstoneJSON!)

/* Error object */
var parsingHearthstoneError: NSError? = nil

/* Parse the data into usable form */
var parsedHearthstoneJSON = try! NSJSONSerialization.JSONObjectWithData(rawHearthstoneJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    
    var minionCost5Counter = 0
    var weaponDurability2Counter = 0
    var battleCryCounter = 0
    var commonMinionCardsCount = 0
    var commonMinionCardsSum = 0.0
    
    guard let arrayOfBasicCardDictionaries = parsedHearthstoneJSON["Basic"] as? [[String: AnyObject]] else {
        print("Basic key doesn't exist")
        return
    }
    
    for cardDict in arrayOfBasicCardDictionaries {
        guard let cardType = cardDict["type"] as?String else {
            print("No type key")
            return
        }
        
        if cardType == "Minion" {
            
            guard let minCost = cardDict["cost"] as? Int else {
                print("No cost key")
                return
            }
            
            //---1.
            if minCost == 5 {
                minionCost5Counter += 1
            }
            
            //---3.
            if let cardText = cardDict["text"] as? String where cardText.rangeOfString("Battlecry") != nil {
                battleCryCounter += 1
            }
            
            guard let rarity = cardDict["rarity"] as? String else {
                print("No rarity key ")
                return
            }
            
            if rarity == "Common" {
                commonMinionCardsCount += 1
                commonMinionCardsSum += Double(minCost)
            }
        }
        
       
        
        if cardType == "Weapon" {
            guard let durability = cardDict["durability"] as? Int else {
                print("No durability key")
                return
            }
            
            //----2.
            if durability == 2 {
                weaponDurability2Counter += 1
            }
        }
    }
    
     //----4.
    let average = commonMinionCardsSum/Double(commonMinionCardsCount)
    
 }

parseJSONAsDictionary(parsedHearthstoneJSON)
