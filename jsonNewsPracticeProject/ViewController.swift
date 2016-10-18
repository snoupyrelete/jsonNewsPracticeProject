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

extension Array where Element:Equatable
{
    func removeDuplicates() -> [Element]
    {
        var result = [Element]()
        
        for value in self
        {
            if result.contains(value) == false
            {
                result.append(value)
            }
        }
        
        return result
    }
}


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem)
    {
        buttonAction(sender)
    }
  
    let sources = myJSON()
    var selectedSources = UserDefaults.standard.stringArray(forKey: "SavedStringArray") ?? [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return sources.objects.count

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath)! as! NewsCell
        cell.checkBox.onAnimationType = BEMAnimationType.bounce
        cell.checkBox.isHidden = false
        cell.checkBox.setOn(true, animated: true)
        cell.newsDescription.isHidden = true
        
        
        let object = sources.objects[(indexPath as NSIndexPath).row]
        
        let newSource = object["id"]
        
        selectedSources.append(newSource!)
        print("Selected sources: \(selectedSources)")
        
        selectedSources = selectedSources.removeDuplicates()

        UserDefaults.standard.set(selectedSources, forKey: "SavedStringArray")
        UserDefaults.standard.synchronize()
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)! as! NewsCell
        
        let object = sources.objects[(indexPath as NSIndexPath).row]
        let sourceName = object["id"]
        
    
        cell.checkBox.offAnimationType = BEMAnimationType.bounce
        cell.checkBox.setOn(false, animated: true)
        cell.newsDescription.isHidden = false
        
        let indexToRemove = selectedSources.index(of: sourceName!)
        selectedSources.remove(at: indexToRemove!)
        
        UserDefaults.standard.set(selectedSources, forKey: "SavedStringArray")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "News Source", for: indexPath) as! NewsCell
        
        let object = sources.objects[(indexPath as NSIndexPath).row]
        
        
        let imageString: String? = object["image"]
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        cell.newsDescription.text = object["description"]
        
        imageView.sd_setImage(with: URL(string: imageString!))
       
        cell.backgroundColor = UIColor.white
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
        
        print("nsuserdefaults of selected sources: \(selectedSources)")
        
                    sources.objects = sources.parseData("https://newsapi.org/v1/sources?language=en")
    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
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
        checkForSubscriptions()
        performSegue(withIdentifier: "toTable", sender: nil)
    }
    
    
    func checkForSubscriptions()
    {
        if selectedSources.count < 1
        {
            print("You must select atleast 1 source.")
            let alert = UIAlertController(title: "Warning:", message: "Please subscribe to atleast 1 source.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

