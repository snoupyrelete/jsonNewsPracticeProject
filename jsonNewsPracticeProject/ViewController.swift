//
//  ViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/3/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import CoreGraphics
import ChameleonFramework
import BEMCheckBox

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}




class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem)
    {
        buttonAction(sender)
    }
  
    let sources = myJSON()
    var selectedSources = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return sources.objects.count

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath)! as! NewsCell
        cell.newsLogo.layer.borderColor = UIColor.red.cgColor
        cell.checkBox.onAnimationType = BEMAnimationType.bounce
        cell.checkBox.isHidden = false
        cell.checkBox.setOn(true, animated: true)
        cell.newsDescription.isHidden = true
        
        
        let object = sources.objects[(indexPath as NSIndexPath).row]
            
        let newSource = object["id"]
        selectedSources.append(newSource!)
        print("Selected sources: \(selectedSources)")
    
     
    }
    
    // Resets borderColor to its default, unselected state.
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)! as! NewsCell
        
        let object = sources.objects[(indexPath as NSIndexPath).row]
        let sourceName = object["id"]
        
    
        cell.checkBox.offAnimationType = BEMAnimationType.bounce
        cell.checkBox.setOn(false, animated: true)
        cell.newsDescription.isHidden = false
        
        let indexToRemove = selectedSources.index(of: sourceName!)
        selectedSources.remove(at: indexToRemove!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "News Source", for: indexPath) as! NewsCell
        
        let object = sources.objects[(indexPath as NSIndexPath).row]
        
        
        let imageString: String? = object["image"]
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        cell.newsDescription.text = object["description"]
        //cell.backgroundColor = UIColor.blue
    
        
        imageView.sd_setImage(with: URL(string: imageString!))
       
        //cell.backgroundColor = FlatWhite()
        cell.backgroundColor = UIColor.white
        
//        let image = imageView.image
//        let averageImageColor = UIColor(averageColorFrom: image)
//        cell.backgroundColor = ComplementaryFlatColorOf(averageImageColor!)
        
//        if let image = imageView.image {
//        
//        imageView.frame = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
//        }
        
//        DispatchQueue.global(qos: .background).async { [weak self]
//            () -> Void in self?.sources.parseData("https://newsapi.org/v1/sources?language=en")
//            // Background thread - netowrk
//            
//            DispatchQueue.main.async(execute: {
//                // UI Updates - touch the ui
//                self?.collectionView.reloadData()
//            })
//        }

    
        
        cell.newsName.text = object["name"]
        cell.layer.cornerRadius = 50
        cell.newsLogo.clipsToBounds = true

        
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = FlatGray()
        self.setStatusBarStyle(.default)
        
        let defaults = UserDefaults.standard
        let myArray = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
        print("nsuserdefaults of selected sources: \(myArray)")
        
        //self.setStatusBarStyle(<#T##statusBarStyle: UIStatusBarStyle##UIStatusBarStyle#>)

 
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            print("This is run on the background queue abcdef")
            sources.objects = sources.parseData("https://newsapi.org/v1/sources?language=en")
            //print(self.sources.objects)
            
            
//            DispatchQueue.main.async {
//                print("This is run on the main queue, after the previous code in outer block")
//                self.collectionView.reloadData()
//            }
//        }
        
 
     
     

        // Detects first launch.
//          let launchedBefore = UserDefaults.standardUserDefaults().boolForKey("launchedBefore")
//          if launchedBefore  {
//              print("Not first launch.")
//              performSegue(withIdentifier: "toTable", sender: self)
//           
//            // grand central dispatch
//              //dispatch_async(dispatch_get_main_queue()){
//        
//                  //self.performSegueWithIdentifier("toTable", sender: self)
//        
//              //}
//          }
//          else {
//              print("First launch, setting NSUserDefault.")
//              UserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
//        }
//   
        //
//        
//        func indexPathsForSelectedItems() -> [NSIndexPath]? {
//            selectedSources.append(String(NSIndexPath))
//            
//            print("Selected sources: \(selectedSources)")
//            return [NSIndexPath]?
//        }
//    

        
           }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //let array = ["horse", "cow", "camel", "sheep", "goat"]
        
        let defaults = UserDefaults.standard
        defaults.set(selectedSources, forKey: "SavedStringArray")
        
        if segue.identifier == "toTable"
        {
            print ("seg id is toTable")
            if let destination = segue.destination as? SWViewController
            {
                destination.selectedSources = selectedSources
            }
        }
    }
    
    func buttonAction(_ sender: UIBarButtonItem)
    {
        print("Button tapped")
        if selectedSources.count < 1
        {
            print("You must select atleast 1 source.")
            let alert = UIAlertController(title: "Warning:", message: "Please subscribe to atleast 1 source.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        performSegue(withIdentifier: "toTable", sender: nil)
    }
}

