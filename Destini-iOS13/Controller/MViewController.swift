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

class MViewController: UIViewController{
    
    
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var storyLabel: UILabel!
    
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var infectionsLabel: UILabel!
    //
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var hintButtonLabel: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    var CurrentPositionArray = [CurrentPosition]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //DB updateable values
    var score = 0
    var attempts = 1
    var level = 1
    var storyNumberFromDb = 0
    var storyNumber = 0
    var storyBrain = StoryBrain()
    var timerInterval = 0.8
    var timer = Timer()
    
    let attemptsBeforeHelp = 1  //should be 2 for public version
    let startTimerInterval = 0.008 //should be 0.07 for public version
    
    //LOad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gotData() == true {
                   getData()
                   print ("We need to get data")
                   storyBrain.firstStory(currentStoryNumber: storyNumberFromDb)
            if attempts < 1  {
                
                attempts = 1}
            print("attempts\(attempts)")
                   
               }else{
                   initData()
                   print ("initilze data")
                   storyNumber = 0
      
               }
               
        updateUI()
        storyLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        infectionsLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        reviewButton.backgroundColor = UIColor.systemGreen
        // UIColor.black.withAlphaComponent(0.7)
        
        ////print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       
        
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
        
       let scoreFromAnswer = storyBrain.checkAnswer(userAnswer: sender.currentTitle!)
        //print ("answr score \(scoreFromAnswer)")
        updateScore(scoreToAdd: scoreFromAnswer, resetScore: false)
        
        
        // updateData(updateScore: score)
        let userGotItRight = storyBrain.checkAnswer(userAnswer: sender.currentTitle!)
        
        
        if attempts > attemptsBeforeHelp{
            if storyBrain.getIsQuestion() == true {
                  //print("User choose with high attempts and I''m a question")
                
                if userGotItRight == 1  {
                    //sender.setTitleColor(.green, for: .normal)
                    sender.setBackgroundImage(UIImage(imageLiteralResourceName: "choiceCorrectBackground") , for: .normal)
                }
                    
                    //backGroundImage.image = UIImage(named: "background\(storyNumber).jpg")}
                else {
                    sender.setBackgroundImage(UIImage(imageLiteralResourceName: "choiceIncorrectBackground") , for: .normal)
                    // sender.setTitleColor(.red, for: .normal)
                }
           
                
                if gotData() == true{
                    
                   
            
                    updateData(field: "storyNum", dataInt: 1000, dataStr: "")
                    
                }
                

                
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self,  selector: #selector(updateUI), userInfo:nil,repeats: false)
            }
            else{
                storyBrain.nextStory(userChoice: sender.currentTitle!)
                  //print("User choose with high attempts but I'm not a question")
                updateUI()
            }
            
            
        } else{
             //print("User choose with low attempts")
            storyBrain.nextStory(userChoice: sender.currentTitle!)

            updateData(field: "storyNum", dataInt: 0, dataStr: "")

        

            updateUI()
        }
        
        
        
    }
    
    func updateData(field: String, dataInt: Int, dataStr: String){
        if field == "score" {
            
            CurrentPositionArray[0].score = Int16(dataInt)}
        else if field == "attempt" {
            CurrentPositionArray[0].attempt = Int16(dataInt)}
        else if field == "storyNum" {
            storyNumber = storyBrain.getStoryNumber()
            //print ("storyNmu = \(storyNumber)")
            CurrentPositionArray[0].storyNumber = Int16(storyNumber)
            
        }
        else{
            //print ("Noting updated")
        }
        
        saveItems()
        
    }
    
    func getData(){
        
        //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //  We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        //this is the table
        
        let request: NSFetchRequest<CurrentPosition> = CurrentPosition.fetchRequest()
        
        do {
            CurrentPositionArray = try context.fetch(request)
        } catch {
            //print("Error fetching data from context \(error)")
        }
        
        //print ("Count,=\(CurrentPositionArray.count)")
        
        //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentPosition")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                score = (data.value(forKey: "score") as! Int)
                //updateScore(scoreToAdd: scorefromDB, resetScore: false)
                attempts = (data.value(forKey: "attempt") as! Int)
                storyNumberFromDb = (data.value(forKey: "storyNumber") as! Int)
                storyNumber = storyNumberFromDb
                if storyNumberFromDb == 13 {
                                   storyNumber = storyNumberFromDb
                    updateScore(scoreToAdd: 0, resetScore: true)
                               }else{
                            storyBrain.firstStory(currentStoryNumber: storyNumberFromDb)}
                               
                               //print("got data score = \(score) and attempts = \(attempts)")
                               
                              
                
                //print("got data score = \(score) and attempts = \(attempts)")
                
                
            }
            
        } catch {
            //print("Failed")
            
            
        }
        
        
        
        
        // End
    }
    
    
    
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            //print("Error saving context \(error)")
        }
    }
    func initData() {
        //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //  We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        //this is the table
        let entity = NSEntityDescription.entity(forEntityName: "CurrentPosition", in: context)
        
        
        let newItem = CurrentPosition(context: self.context)
        newItem.score = 0
        newItem.attempt = 1
        newItem.storyNumber = 0
        self.CurrentPositionArray.append(newItem)
         updateScore(scoreToAdd: 0, resetScore: true)
        saveItems()
        
        
        
    }
    
    
    func gotData() -> Bool{
        //check if the table has data in?
        
        var gotData = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentPosition")
        //print ("Count from gotdata,=\(CurrentPositionArray.count)")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                //print("The score is, \(data.value(forKey: "score") as! Int)")
                //print("got data")
                gotData = true
            }
            
        } catch {
            //print("Failed")
            gotData = false
            
        }
        return gotData
    }
    
    
    
    
    func typeText(storyText: String, label: String){
        
        // typeTimer.invalidate()
        // typeTimer = nil
        // //print (storyText)
        var chatIndex = 0.0
        let titleText = storyText
        storyLabel.text = " "
        
        
        //change before comitt
        timerInterval = startTimerInterval / Double(attempts)

        
        for letter in titleText{
           // //print(letter)
            
            Timer.scheduledTimer(withTimeInterval: timerInterval * chatIndex , repeats: false) { (timer) in
                
                ////print(self.timerInterval)
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
        
        
        ////print (timeForTimer)
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

        //print("Got Data")
        choice1Button.setBackgroundImage(UIImage(imageLiteralResourceName: "choice1Background") , for: .normal)
        choice2Button.setBackgroundImage(UIImage(imageLiteralResourceName: "choice2Background") , for: .normal)
        typeText(storyText: storyBrain.getStoryTitle(), label: "storyLabel")
        hintButtonLabel.setTitle("Hint", for: .normal)
        hintOpen = false
        
       
       updateIfNewLevel()
       

        
        if storyBrain.getStoryNumber() == 11 || storyBrain.getStoryNumber() == 24 {
             //print("story is 11 or 24")
            updateIfStory11Or24()
            
            
        } else if storyBrain.getStoryNumber() == 0 || storyBrain.getStoryNumber() == 13{
            infectionsLabel.isHidden = true
            choice2Button.isHidden = false
            reviewButton.isHidden = true
            storyLabel.isHidden = false
            //print ("Story is 0 - BAck to zero \(score)")
            updateScore(scoreToAdd: 0, resetScore: true)
            
       
            
        } else  {
             //print("Story not 11,24 or 0")
            choice2Button.isHidden = false
            infectionsLabel.isHidden = true
            reviewButton.isHidden = true
            storyLabel.isHidden = false
        }
    }
    
    
    
    
    func  updateIfStory11Or24(){
        //hide labels and update attempts
        infectionsLabel.isHidden = false
        choice2Button.isHidden = true
        reviewButton.isHidden = false
        storyLabel.isHidden = true
        updateData(field: "attempt", dataInt: attempts+1, dataStr: "")
        if score == 10{
            updateIfScore10()
        } else{
            updateIfNotScore10()
        }
    }
    
    
    func updateIfScore10 (){
        
        //show 10 scored message, allow move to next round
        
        infectionsLabel.text = ("You scored \(score) out of 10\n\nLooks like you've Escaped")
        backGroundImage.image = #imageLiteral(resourceName: "background11")
        choice2Button.isHidden = false
        if  storyBrain.getStoryNumber() == 24 {
            reviewButton.isHidden = false}
      choice2Button.isHidden = true
        updateData(field: "attempt", dataInt: 0, dataStr: "")
    }
    
    
    func updateIfNotScore10(){
       
        updateData(field: "attempt", dataInt: 1, dataStr: "")
        storyNumber = 0
        updateData(field: "storyNumber  ", dataInt: 0, dataStr: "")
         //updateScore(scoreToAdd: 0, resetScore: true)
        //print ("updated story to 0")
        //storyBrain.firstStory(currentStoryNumber: 0)
        
        if  storyBrain.getStoryNumber() == 24 {
            reviewButton.isHidden = false
            choice2Button.isHidden = true
            
            updateData(field: "storyNumber  ", dataInt: 13, dataStr: "")
            
        }
        
        updateAttempts()
        
        
        backGroundImage.image = #imageLiteral(resourceName: "background11b")
        
        
        updateScore(scoreToAdd: 0, resetScore: true)
        
    }
    
   
    
    func updateAttempts(){
          //("if attempts")
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
    }
    
    func updateIfNewLevel(){
                if storyNumber > 12{
                   backGroundImage.image = UIImage(named: "background\(storyNumber-12).jpg")
                     print("level 2")
               }else if storyNumber > 1{
                   backGroundImage.image = UIImage(named: "background\(storyNumber).jpg")
                     print("level 1")
               }
               else{
                   backGroundImage.image = #imageLiteral(resourceName: "background")
                     print("level 0\(storyNumber)")
                   
               }
    }
 
    
    func updateScore(scoreToAdd: Int, resetScore: Bool){
           
           var newScore: Int
           if resetScore == true {
               newScore = 0
           } else {
              

               
               newScore = scoreToAdd + score
               
           }
          
          updateData(field: "score", dataInt: newScore, dataStr: "")
           score = newScore
           
       }
}


