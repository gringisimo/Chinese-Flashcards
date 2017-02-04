//
//  DetailViewController.swift
//  ChineseFlashcards
//
//  Created by Daniel Galyean on 1/18/17.
//  Copyright © 2017 Daniel Galyean. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    
    @IBOutlet weak var buttonText: UIButton!

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var frontback = "front"
    var i = 0
    var mycards: Results<cards>{
        get {
            let realm = try! Realm(configuration: config)
            return realm.objects(cards.self).filter("category == %@", detailItem!)
        }
    }
    
    //var predicate: NSPredicate{
        //get{
            //return NSPredicate(format: "cat = %@",detailItem!)
        //}
    //}
    let config = Realm.Configuration(
        // Get the URL to the bundled file
        fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"),
        // Open the file in read-only mode as application bundles are not writeable
        readOnly: true)
    
    
    

    @IBOutlet weak var cardText: UILabel!
    

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        red   = (0.0/255.0)
        green = (0.0/255.0)
        blue  = (0.0/255.0)
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        cardText.text = "Card " + String(mycards[i].id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Int? {
        didSet {
            // Update the view.
            //self.configureView()
        }
    }

    /*@IBAction func showCard() {
        
         if(frontback == "front"){
            cardText.text = mycards[i].front
            frontback = "back"
            buttonText.setTitle("Show Answer", for: .normal)
        }else if(frontback == "back"){
            
            cardText.text = mycards[i].back
            i += 1
            if(i == mycards.count){
                i = 0
                buttonText.setTitle("Start Over", for: .normal)
                frontback = "front"
            }else{
                buttonText.setTitle("Next Card", for: .normal)
                frontback = "front"
            }
            
     
        }

    } */
    @IBAction func showEnglish() {
        cardText.text = mycards[i].front
    }
    @IBAction func showCharacter() {
        cardText.text = mycards[i].character
    }

    @IBAction func showPinyin() {
        cardText.text = mycards[i].back
    }
    @IBAction func nextCard() {
        i += 1
        if(i >= mycards.count){
        i = 0
        cardText.text = "Card " + String(mycards[i].id)
        }else{
        
        cardText.text = "Card " + String(mycards[i].id)
        }
    }
    
    @IBAction func previousCard() {
        if(i != 0){
        i -= 1
        cardText.text = "Card " + String(mycards[i].id)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        isSwiping    = false
        if let touch = touches.first{
            lastPoint = touch.location(in: imageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        
        isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.location(in: imageView)
            UIGraphicsBeginImageContext(self.imageView.frame.size)
            self.imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(4.0)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.strokePath()
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        if(!isSwiping) {
            // This is a single touch, draw a point
            UIGraphicsBeginImageContext(self.imageView.frame.size)
            self.imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(9.0)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.strokePath()
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }


    @IBAction func clearDrawing() {
        self.imageView.image = nil
    }

}

