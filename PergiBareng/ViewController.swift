//
//  ViewController.swift
//  PergiBareng
//
//  Created by Reza Pahlevi on 9/23/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, CoreApiDelegate {
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photoData : [PhotoObjects] = []
    var photoApi : PhotoApi!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let nav = self.navigationController?.navigationBar
        self.navigationItem.title = "Example Rezaplepi"
        nav?.barTintColor = UIColor.lightGray
        nav?.tintColor = UIColor.black
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        photoApi = PhotoApi()
        photoApi.delegate = self
        photoApi.start();
    }
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 10, 0);
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func finish(interFace: CoreApiInterface, result: AnyObject) {
        //        let data = result as! NSDictionary
        
        if let array = (result as? NSDictionary)?["results"] as? [NSDictionary] {
            
            for p in array {
                let photo = PhotoObjects()
                photo.email = p["email"] as? String
                
                photo.gender = p["gender"] as! String?
                let picture = p["picture"] as! NSDictionary
                photo.thumbnail = picture["thumbnail"] as? String
                photo.photo = picture["medium"] as! String?
                
                photoData.append(photo)
            }
            print(photoData)
            collectionView.reloadData();
        }
        
    }
    
}

extension UITextField {
    
    @IBInspectable var borderColor : UIColor? {
        get {
            if let cgcolor = layer.borderColor {
                return UIColor(cgColor: cgcolor)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
            
            // width must be at least 1.0
            if layer.borderWidth < 1.0 {
                layer.borderWidth = 1.0
            }
        }
    }
    @IBInspectable var cornerRadius : CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoViewCell
        cell.emailLbl.text = photoData[indexPath.item].email!
        let url = NSURL(string: photoData[indexPath.item].photo!)! as URL
        let data = NSData(contentsOf: url)
        let imgLayer : CALayer = cell.imgPhoto.layer
        
        imgLayer.cornerRadius = 10
        cell.imgPhoto.clipsToBounds = true
        cell.imgPhoto.image = UIImage(data: data! as Data)
        cell.layoutIfNeeded()
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: IndexPathNSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        
//        let temp = photoData.removeAtIndex(sourceIndexPath.item)
//        photoData.insert(temp, atIndex: destinationIndexPath.item)
//    }
    
}
