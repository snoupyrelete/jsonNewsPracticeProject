//
//  parseJSON.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 10/1/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import Foundation

class myJSON {
    
//    
//    var sourceInfo = [[String: String]].self
//    var articleInfo = [[String: String]].self
//    var articleContent = [[String: String]].self
    
//    var _objects = 1
//    var objects = [[String: String]]()
    
//    var objects = [[String: String]]()

    var _objects = [[String: String]]()
    var objects: [[String: String]] {
        get {
              return _objects
        } set(newObjects) {
            _objects = newObjects
        }
    }



    func parseJSON(_ json: JSON, inputURL: String)
    {
        if inputURL.hasPrefix("https://newsapi.org/v1/articles?source")
        {
            print("has prefix of an article")
            for article in json["articles"].arrayValue
            {
                let title = article["title"].stringValue
                let description = article["description"].stringValue
                let author = article["author"].stringValue
                let image = article["urlToImage"].stringValue
                let date = article["publishedAt"].stringValue
                let url = article["url"].stringValue
                let obj = ["title": title, "author": author, "image": image, "description": description, "date": date, "url": url]
            
                //print("obj in myJSON are  \(objects)")
                //change newstables variable from here? PUT FOR LOOP IN INIT METHOD OF THIS CLASS?
                self.objects.append(obj)
                print(objects)
            
            }
        } else if inputURL == "https://newsapi.org/v1/sources?language=en"{
            print("it's a source url")
            for source in json["sources"].arrayValue
            {
                let id = source["id"].stringValue
                let name = source["name"].stringValue
                let description = source["description"].stringValue
                let url = source["url"].stringValue
                let category = source["category"].stringValue
                let language = source["language"].stringValue
                let country = source["country"].stringValue
                let image = source["urlsToLogos"]["large"].stringValue
                let obj = ["id": id,"name": name, "description": description, "url": url, "category": category, "language": language , "country": country , "image": image]
                objects.append(obj)
            
            }
                print("MARKER GCD: DONE")
        } else if inputURL.hasPrefix("https://boilerpipe-web.appspot.com/extract?"){
            print("it's an invalid url or it's from boilerpipe")
            print(json["response"].arrayValue)
            
       
                let content = json["response"]["content"].stringValue
                
                let obj = ["content": content]
                objects.append(obj)
        }
    }
    
    /**
    parseData takes in url paramater and parses:
     1.) newsapi.org for sources and their info, to be displayed in the collection view controller (subscriptions)
        - id, name, description, url, category, language, country, urlsToLogos(small, medium and large), sortBysAvailable
        - https://newsapi.org/v1/sources?language=en

     2.) newsapi.org for articles and their info, to be displayed in the table view controller
        - author, title, description, url, urlToImage, publishedAt
        - https://newsapi.org/v1/articles?source=...

     3.) and boilerpipe's api for the article's "content" (body text) to be displayed in the detail view controller
        - content
        -
    */
    
    // create 3 funcs? getArticleSource, getArticleInfo, getArticleContent?
    // return -> sourceInfo, articleInfo, articleContent?
    func parseData(_ inputURL: String ) -> [[String: String]]
    {
        let myUrlStringInput: String = inputURL
        //print("myJSON inputURL: \(inputURL)")
        
        if let nsurlStringInput = URL(string: myUrlStringInput)
        { // We have to convert to NSURL because contentsOfUrl takes NSURL as a paramater.
            //print("NSURL string input: \(nsurlStringInput)")
        
            if let websiteNSData = try? Data(contentsOf: nsurlStringInput, options: [])
            { // We have to convert it to NSData because swiftyJSON's type JSON uses NSData as a paramter.
                //print("Website's NSDATA: \(websiteNSData)")
            
                let websiteJSONData = JSON(data: websiteNSData)
                //print("Website JSON Data: \(websiteJSONData)")
            
                self.parseJSON(websiteJSONData, inputURL: inputURL)
            }
        }
        return objects
    }
        
 

        

        
}
