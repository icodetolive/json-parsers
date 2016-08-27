//
//  animalsJsonParser.playground
//  Created by Sugandha Naolekar on 08/27/16.
//  JSON files provided by Udacity as a part of Udacity iOS nanodegree
//

/*
 Following are the motives of parsing this json file:
 1. How many photos are in the JSON data set? 
 2. What is the array index of the photo that has content containing the text "interrufftion"?
 3. For the third photo in the array of photos, what animal is shown?
 */


import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAnimalsJSON = NSBundle.mainBundle().pathForResource("animals", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAnimalsJSON = NSData(contentsOfFile: pathForAnimalsJSON!)

/* Error object */
var parsingAnimalsError: NSError? = nil

/* Parse the data into usable form */
var parsedAnimalsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAnimalsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    guard let photosDictionary = parsedAnimalsJSON["photos"] as? NSDictionary else {
        print("Could not find photos key")
        return
    }
    
    guard let photoCount = photosDictionary["total"] as? Int else {
        print("Cound not find total key")
        return
    }
    
    // ----1.
    print("Total no. of photos: \(photoCount)")
    
    guard let arrayOfPhotosDictionary = photosDictionary["photo"] as? [[String: AnyObject]] else {
        print("Could not find photos key")
        return
    }
    
    for (index, photo) in arrayOfPhotosDictionary.enumerate() {
        guard let commentDict = photo["comment"] as? [String:AnyObject] else {
            print("No comment key")
            return
        }
        
        guard let content = commentDict["_content"] as? String else {
            print("No _content key")
            return
        }
        
        //----2.
        if content.rangeOfString("interrufftion") != nil {
            print(index)
        }
        
        //----3.
        if let photoURL = photo["url_m"] as? String where index == 2 {
            print(photoURL)
        }
    }
}

parseJSONAsDictionary(parsedAnimalsJSON)


