
//  achievementsJsonParser.playground
//  Created by Sugandha Naolekar on 08/27/16.
//  JSON files provided by Udacity as a part of Udacity iOS nanodegree
//

/*
 Following are the motives of parsing this json file:
 1. How many achievements with point value > 10?
 2. What is the average point value for achievements?
 3. To accomplish "Cool Running" achievement, what mission you must complete?
 */

import Foundation

var Points10Counter = 0
var pointsTotal = 0

/* Path for JSON files bundled with the Playground */
var pathForAchievementsJSON = NSBundle.mainBundle().pathForResource("achievements", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAchievementsJSON = NSData(contentsOfFile: pathForAchievementsJSON!)

/* Error object */
var parsingAchivementsError: NSError? = nil

/* Parse the data into usable form */
var parsedAchievementsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAchievementsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    guard let achievementsDictionaries = parsedAchievementsJSON["achievements"] as? [NSDictionary] else {
        print("No achievements key")
        return
    }
    
    for achievementDict in achievementsDictionaries {
        
        guard let points = achievementDict["points"] as? Int else {
            print("No points key")
            return
        }
        
        //----1.
        if points > 10 {
            Points10Counter += 1
        }
        
        pointsTotal += points
        
        //----3.
        if let title = achievementDict["title"] as? String,
            let description = achievementDict["description"] as? String
            where title == "Cool Running" {
            print(description)
        }
    }
    
    //----2.
    let pointsAvg = Double(pointsTotal/achievementsDictionaries.count)
    print(pointsAvg)
}

parseJSONAsDictionary(parsedAchievementsJSON)