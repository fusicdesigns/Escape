////
////  ViewController.swift
////  Destini-iOS13
////
////  Created by Angela Yu on 08/08/2019.
////  Copyright © 2019 The App Brewery. All rights reserved.
////
//
//import UIKit
//import StoreKit
//
//
//
//class ViewController: UIViewController {
//    
//    
//    
//    
//   @IBOutlet weak var backgroundImage: UIImageView!
//    @IBOutlet weak var storyLabel: UILabel!
//    @IBOutlet weak var choice1Button: UIButton!
//    @IBOutlet weak var choice2Button: UIButton!
//    @IBOutlet weak var infectionsLabel: UILabel!
//    
//    @IBOutlet weak var reviewButton: UIButton!
//    @IBOutlet weak var hintButtonLabel: UIButton!
//    @IBOutlet weak var infoButton: UIButton!
//    @IBOutlet weak var infoLabel: UILabel!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        updateUI()
//        storyLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
//        infectionsLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        reviewButton.backgroundColor = UIColor.systemGreen
//        // UIColor.black.withAlphaComponent(0.7)
//        
//        
//    }
//    
//    @IBAction func reviewButtomPressed(_ sender: UIButton) {
//        if #available( iOS 10.3,*){
//            SKStoreReviewController.requestReview()
//        }
//        
//    }
//    var hintOpen = false
//    @IBAction func hintButton(_ sender: Any) {
//        if hintOpen == false{
//            storyLabel.text = "Hint: \(storyBrain.getStoryHint())\n\n\(storyBrain.getStoryTitle())"
//            hintButtonLabel.setTitle("Hide hint", for: .normal)
//            hintOpen = true
//        }
//        else{
//            storyLabel.text = storyBrain.getStoryTitle()
//            hintButtonLabel.setTitle("Hint", for: .normal)
//            hintOpen = false
//        }
//    }
//    @IBAction func infoButton(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "gotoInfo", sender: self)
//        
//        
//        
//    }
//    @IBAction func choiceMade(_ sender: UIButton) {
//        score = score + storyBrain.checkAnswer(userAnswer: sender.currentTitle!)
//        let userGotItRight = storyBrain.checkAnswer(userAnswer: sender.currentTitle!)
//        
//        if attempts > 1{
//            if storyBrain.getStoryNumber() != (0){
//                
//                if userGotItRight == 1  {
//                    sender.setTitleColor(.green, for: .normal)
//                } else {
//                    sender.setTitleColor(.red, for: .normal)
//                }
//
//                
//            }
//            
//            storyBrain.nextStory(userChoice: sender.currentTitle!)
//            
//            
//            timer = Timer.scheduledTimer(timeInterval: 0.3, target: self,  selector: #selector(updateUI), userInfo:nil,repeats: false)
//        }
//            
//            
//        else{
//            storyBrain.nextStory(userChoice: sender.currentTitle!)
//            updateUI()
//        }
//        
//        
//        
//    }
//    
//    
//    @objc func updateUI() {
//        storyLabel.text = storyBrain.getStoryTitle()
//        print("score=\(score)")
//        choice1Button.setTitleColor(.white, for: .normal)
//        choice2Button.setTitleColor(.white, for: .normal)
//        choice1Button.setTitle(storyBrain.getChoice1(), for: .normal)
//        choice2Button.setTitle(storyBrain.getChoice2(), for: .normal)
//        
//        
//        hintButtonLabel.setTitle("Hint", for: .normal)
//        hintOpen = false
//        let storyNumber = storyBrain.getStoryNumber()
//        
//        
//        if storyNumber > 1{
//            backgroundImage.image = UIImage(named: "background\(storyNumber).jpg")}
//        else{
//            backgroundImage.image = #imageLiteral(resourceName: "background")
//            
//        }
//        
//        
//        
//        
//        if storyBrain.getStoryNumber() == 11{
//            infectionsLabel.isHidden = false
//            choice2Button.isHidden = true
//            reviewButton.isHidden = false
//            storyLabel.isHidden = true
//            attempts = attempts+1
//            print("Attempts:\(attempts)")
//            if score == 10{
//                infectionsLabel.text = ("You scored \(score) out of 10\n\nwell done, you've escaped.\n\n")
//                backgroundImage.image = #imageLiteral(resourceName: "background11")
//            }
//            else{
//                
//                infectionsLabel.text = ("You scored \(score) out of 10\n\nLooks like you're trapped in the Escape room")
//                backgroundImage.image = #imageLiteral(resourceName: "background11b")
//                
//            }
//            
//            
//            
//        } else if storyBrain.getStoryNumber() == 0{
//            infectionsLabel.isHidden = true
//            choice2Button.isHidden = false
//            reviewButton.isHidden = true
//            storyLabel.isHidden = false
//            score = 0
//            
//        } else {
//            choice2Button.isHidden = false
//            infectionsLabel.isHidden = true
//            reviewButton.isHidden = true
//            storyLabel.isHidden = false
//        }
//        
//    }
//    
//    
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
