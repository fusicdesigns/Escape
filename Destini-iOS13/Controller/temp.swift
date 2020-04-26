//
//  MViewController.swift
//  Destini-iOS13
//
//  Created by Chris Stanley on 19/04/2020.
//  Copyright © 2020 Fusic. All rights reserved.
//

import Foundation
import StoreKit
import CoreData

class MViewController2: UIViewController{
    
    
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var storyLabel: UILabel!
    
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var infectionsLabel: UILabel!
    //
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var hintButtonLabel: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    
    //DB updateable values
    var score = 0
    var attempts = 1
    var level = 1
    
    var storyBrain = StoryBrain()
    var timerInterval = 0.8
    var timer = Timer()
  
    let attemptsBeforeHelp = 1  //should be 2 for public version
    let startTimerInterval = 0.008 //should be 0.07 for public version
    
    //LOad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateUI()
        storyLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        infectionsLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        reviewButton.backgroundColor = UIColor.systemGreen
        // UIColor.black.withAlphaComponent(0.7)
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        if gotData() == true {
            getData()
            print ("We need to get data")
        }else{
            initData()
            print ("initilze data")
        }
        
        
        //  storyLabel.text = storyBrain.getStoryTitle()
        
    }
    
    //Review Button Pressed
    @IBAction func reviewButtomPressed(_ sender: UIButton) {
        if level == 1{
            level = 2 }
     
        else{
            if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()}
        }
        
    }
    
    //Hint Buttom Pressed
    var hintOpen = false
    @IBAction func hintButton(_ sender: Any) {
        if hintOpen == false{
            storyLabel.text = "Hint: \(storyBrain.getStoryHint())\n\n\(storyBrain.getStoryTitle())"
            hintButtonLabel.setTitle("Hide hint", for: .normal)
            hintOpen = true
        }
        else{
            storyLabel.text = storyBrain.getStoryTitle()
            hintButtonLabel.setTitle("Hint", for: .normal)
            hintOpen = false
        }
    }
    //Info Button Pressed
    
    @IBAction func infoButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoInfo", sender: self)
        
        
        //User made a choice
    }
    @IBAction func choiceMade(_ sender: UIButton) {
       
        score = score + storyBrain.checkAnswer(userAnswer: sender.currentTitle!)
        updateData(updateScore: score)
        let userGotItRight = storyBrain.checkAnswer(userAnswer: sender.currentTitle!)
        
        
       
        if attempts > attemptsBeforeHelp{
            if storyBrain.getIsQuestion() == true {
                
                if userGotItRight == 1  {
                    //sender.setTitleColor(.green, for: .normal)
                    sender.setBackgroundImage(UIImage(imageLiteralResourceName: "choiceCorrectBackground") , for: .normal)
                }
                    
                    //backGroundImage.image = UIImage(named: "background\(storyNumber).jpg")}
                else {
                    sender.setBackgroundImage(UIImage(imageLiteralResourceName: "choiceIncorrectBackground") , for: .normal)
                    // sender.setTitleColor(.red, for: .normal)
                }
                
                
                
                
                storyBrain.nextStory(userChoice: sender.currentTitle!)
                
                
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self,  selector: #selector(updateUI), userInfo:nil,repeats: false)
            }
            else{
                storyBrain.nextStory(userChoice: sender.currentTitle!)
                updateUI()
            }
            
            
        } else{
            storyBrain.nextStory(userChoice: sender.currentTitle!)
            updateUI()
        }
        
        
        
    }
    
    func updateData(updateScore: Int){
      //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
      //  We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CurrentPosition", in: context)
        let newCurrentPosition = NSManagedObject(entity: entity!, insertInto: context)
        newCurrentPosition.setValue(updateScore, forKey: "score")
        do {
           try context.save()
             print ("updated data")
            if gotData() == true{
                //update data
                print("Updating Data")
            }else{
            print("call dataInit") }
          } catch {
           print("Failed saving")
        }
       
     
        
    }
    
    func getData(){
      //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
      //  We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CurrentPosition", in: context)
        
        
        
       // let newCurrentPosition = NSManagedObject(entity: entity!, insertInto: context)
       // newCurrentPosition.setValue( forKey: "score")
        do {
           try context.save()
             print ("updated data")
            if gotData() == true{
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentPosition")
                
                   request.returnsObjectsAsFaults = false
        
              let a  =  context.index(ofAccessibilityElement: 1)
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    var resultsArray = ""
                   // resultsArray = data.index(ofAccessibilityElement: Any)
                    
                  //  let myData = [results objectAtIndex:0]
                    
                    
                   print("Results array \(resultsArray)")
                 //  print("My data\(myData)")
                    
                    
                    print("The score is, \(data.value(forKey: "score") as! Int)")
                            print("got data")}
                
                
                
        
                print("Updating Data")
            }else{
            print("call dataInit") }
          } catch {
           print("Failed saving")
        }
       
     
        
    }
    
    
    func initData() {
      //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
      //  We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CurrentPosition", in: context)
        let newCurrentPosition = NSManagedObject(entity: entity!, insertInto: context)
        newCurrentPosition.setValue(0, forKey: "score")
        newCurrentPosition.setValue(0, forKey: "attempt")
        newCurrentPosition.setValue(0, forKey: "storyNumber")
        do {
           try context.save()
             print ("updated data")
          } catch {
           print("Failed saving")
        }
       
     
        
    }
    
    
    func gotData() -> Bool{
        var gotData = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

               let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentPosition")
     
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
               print("The score is, \(data.value(forKey: "score") as! Int)")
                print("got data")
                
            
                
                
              gotData = true
          }
            
        } catch {
            print("Failed")
           gotData = false
           
        }
        return gotData
    }
    
    
    
    
    func typeText(storyText: String, label: String){
        
        // typeTimer.invalidate()
        // typeTimer = nil
       // print (storyText)
        var chatIndex = 0.0
        let titleText = storyText
        storyLabel.text = " "
        
        
        //change before comitt
        timerInterval = startTimerInterval / Double(attempts)
        
        
        for letter in titleText{
           // print(letter)
            
            Timer.scheduledTimer(withTimeInterval: timerInterval * chatIndex , repeats: false) { (timer) in
                
                //print(self.timerInterval)
                self.storyLabel.text?.append(letter)
                
                
                
            }
            
            chatIndex += 1
        }
        
        self.showButtons(timeToRun:  Double(storyText.count) )
        
        
    }
    
    
    func showButtons(timeToRun: Double){
        self.choice1Button.setTitle("", for: .normal)
        self.choice2Button.setTitle("", for: .normal)
        self.choice1Button.isEnabled = false
        self.choice2Button.isEnabled = false
        var timeForTimer = 0.5
        timeForTimer = timeToRun * timerInterval + 0.5 / Double(attempts)
        
        
        //print (timeForTimer)
        Timer.scheduledTimer(withTimeInterval: timeForTimer , repeats: false) { (timer) in
            
            self.choice1Button.isEnabled = true
            self.choice2Button.isEnabled = true
            self.choice1Button.setBackgroundImage(UIImage(imageLiteralResourceName: "choice1Background") , for: .normal)
            self.choice2Button.setBackgroundImage(UIImage(imageLiteralResourceName: "choice2Background") , for: .normal)
            
            self.choice1Button.setTitleColor(.white, for: .normal)
            self.choice2Button.setTitleColor(.white, for: .normal)
            self.choice1Button.setTitle(self.storyBrain.getChoice1(), for: .normal)
            self.choice2Button.setTitle(self.storyBrain.getChoice2(), for: .normal)
            
            
        }
        
        
    }
    
    
    
    @objc func updateUI() {
        getData()
        
        
        choice1Button.setBackgroundImage(UIImage(imageLiteralResourceName: "choice1Background") , for: .normal)
        choice2Button.setBackgroundImage(UIImage(imageLiteralResourceName: "choice2Background") , for: .normal)
        typeText(storyText: storyBrain.getStoryTitle(), label: "storyLabel")
        
        
        
        
        hintButtonLabel.setTitle("Hint", for: .normal)
        hintOpen = false
        let storyNumber = storyBrain.getStoryNumber()
        
        
        if storyNumber > 12{
            backGroundImage.image = UIImage(named: "background\(storyNumber-12).jpg")
        }else if storyNumber > 1{
            backGroundImage.image = UIImage(named: "background\(storyNumber).jpg")
        }
            
        else{
            backGroundImage.image = #imageLiteral(resourceName: "background")
            
        }
        
        
        if storyBrain.getStoryNumber() == 11 || storyBrain.getStoryNumber() == 24 {
            infectionsLabel.isHidden = false
            choice2Button.isHidden = true
            reviewButton.isHidden = false
            storyLabel.isHidden = true
            attempts = attempts+1
           // print("Attempts:\(attempts)")
            //var finalText = ""
            
            if score == 10{
                infectionsLabel.text = ("You scored \(score) out of 10\n\nLooks You've Escaped")
                  backGroundImage.image = #imageLiteral(resourceName: "background11")
                     choice2Button.isHidden = false
               if  storyBrain.getStoryNumber() == 24 {
                    reviewButton.isHidden = false}
               else{
                reviewButton.isHidden = true
                }
                score = 0
                attempts = 1
            }
            else{
                if attempts == 3 {
                    infectionsLabel.text = ("You scored \(score) out of 10\n\nLooks like you're still trapped, so we'll give you a little help on the next round")
                    level = 2
                    
                } else if attempts == 2 {
                    infectionsLabel.text = ("You scored \(score) out of 10\n\nLooks like you're still trapped\n\nOne more round on your own\n and then we'll give you a liitle help.  Try using the hints button")
                    
                } else if attempts > 3{
                    infectionsLabel.text = ("You scored \(score) out of 10\n\nLooks like you're still trapped in the Escape room.  Try again?")
                } else{
                    infectionsLabel.text = ("You scored \(score) out of 10\n\nLooks like you're trapped in the Escape room")
                    
                }
                
                backGroundImage.image = #imageLiteral(resourceName: "background11b")
            }
            
              score = 0
            
        } else if storyBrain.getStoryNumber() == 0{
            infectionsLabel.isHidden = true
            choice2Button.isHidden = false
            reviewButton.isHidden = true
            storyLabel.isHidden = false
            score = 0
            print ("BAck to zero \(score)")
            
        } else {
            choice2Button.isHidden = false
            infectionsLabel.isHidden = true
            reviewButton.isHidden = true
            storyLabel.isHidden = false
        }
        
    }
    
    
}
