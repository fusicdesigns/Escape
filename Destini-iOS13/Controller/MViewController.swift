//
//  MViewController.swift
//  Destini-iOS13
//
//  Created by Chris Stanley on 19/04/2020.
//  Copyright © 2020 Fusic. All rights reserved.
//

import Foundation
import StoreKit

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
    
    
    
    var storyBrain = StoryBrain()
    var timerInterval = 0.8
    var score = 0
    var attempts = 1
    var timer = Timer()
    var level = 1
    
    //LOad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateUI()
        storyLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        infectionsLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        reviewButton.backgroundColor = UIColor.systemGreen
        // UIColor.black.withAlphaComponent(0.7)
        
        
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
        let userGotItRight = storyBrain.checkAnswer(userAnswer: sender.currentTitle!)
        
        
        //attempts should be >2
        if attempts > 0{
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
    
    
    
    func typeText(storyText: String, label: String){
        
        // typeTimer.invalidate()
        // typeTimer = nil
        print (storyText)
        var chatIndex = 0.0
        let titleText = storyText
        storyLabel.text = " "
        
        
        //change before comitt
        timerInterval = 0.01 / Double(attempts)
        
        
        for letter in titleText{
            print(letter)
            
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
        
        
        print (timeForTimer)
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
            print("Attempts:\(attempts)")
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
