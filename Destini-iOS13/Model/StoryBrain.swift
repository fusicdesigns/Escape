    //
    //  StoryBrain.swift
    //  Destini-iOS13
    //
    //  Created by Angela Yu on 08/08/2019.
    //  Copyright © 2019 The App Brewery. All rights reserved.
    //
    
    import Foundation
    
    struct StoryBrain {
        
        var storyNumber = 0
        var infected : Float = 0.0
        var clickCount = 0
        let InfectRate: Float = 3/9
        var totalInfected = 0
        
        
        let stories = [
            
            Story(
                title: "Welcome to my first Virtual Escape Room\n\nAnswer all questions correctly to escape",
                choice1: "Walk down the stairs", choice1Destination: 1,
                choice2: "Run for your life", choice2Destination: 12,
                correctAnswer: "",
                Hint: "You'll need to play to see a hint",
                isQuestion: false
            ),// 1
            
            Story(
                title: "To enter the room\n\nWhat is X?\n\n2 + X * 2 = 10",
                choice1: "X = 3", choice1Destination: 2,
                choice2: "X = 4", choice2Destination: 2,
                correctAnswer: "X = 4",
                Hint: "Multiply first",
                isQuestion: true
            ),
            //2
            Story(
                title: "You're in a corridor and see this on the wall\n\nIf A = G and C = I\n\n What does E=?",
                choice1: "K", choice1Destination: 3,
                choice2: "L", choice2Destination: 3,
                correctAnswer: "K",
                Hint: "An ALPHA might BET you'd get this right",
                isQuestion: true
            ),
            //3
            Story(
                title: "Where am I?\n\nG & M & T + 10 =",
                choice1: "Tokyo", choice1Destination: 4,
                choice2: "Sydney", choice2Destination: 4,
                correctAnswer: "Sydney",
                Hint: "What's the time?",
                isQuestion: true
            ),
            //4
            Story(
                title: "Solve the riddle\n\nOne enters it blind and comes out seeing\n\nWhat is it?",
                choice1: "Hospital", choice1Destination: 5,
                choice2: "School", choice2Destination: 5,
                correctAnswer: "School",
                Hint: "This is training not fixing",
                isQuestion: true
            ),
            //5
            Story(
                title: "Which London location am I?\n\n13.5° S + 72° W + Orange jam",
                choice1: "Station", choice1Destination: 6,
                choice2: "Stadium", choice2Destination: 6,
                correctAnswer: "Station",
                Hint: "Bear with us",
                isQuestion: true
            ),
            //6
            Story(
                title: "DECIPHER THIS -4 \n\n13th 6th 7th = ",
                choice1: "Old", choice1Destination: 7,
                choice2: "And", choice2Destination: 7,
                correctAnswer: "Old",
                Hint: "'Decipher this' needs to be deciphered",
                isQuestion: true
            ),
            //7
                       Story(
                           title: "[ = 1, * =8 \n\n Find the value of },# and = to find the answer to this \n\n} + * + [ - # + = - [",
                           choice1: "=18", choice1Destination: 8,
                           choice2: "=17", choice2Destination: 8,
                           correctAnswer: "=17",
                           Hint: "The symbols are alternative iOS keys ",
                           isQuestion: true
                       )
            ,
            //8
                       Story(
                           title: "Crack the secret code\n\n--  .-  --.  ..  -.-.",
                           choice1: "Magic", choice1Destination: 9,
                           choice2: "Motel", choice2Destination: 9,
                           correctAnswer: "Magic",
                           Hint: "Detective Morse would get this",
                           isQuestion: true
                        
                       )
            ,
            //9
                       Story(
                           title: "Can the app read your mind?\n\n- Choose a number 1 and 10\n- Multiply it by 2\n- Now multiply by 5\n- Divide by your number\n- Subtract 7",
                           choice1: "3", choice1Destination: 10,
                           choice2: "7", choice2Destination: 10,
                           correctAnswer: "3",
                           Hint: "Tell me first",
                           isQuestion: true
                       )
            ,
            //10
                       Story(
                           title: "Solve the code \n\nQ+2  &  Z+3  &  Y-3  &  \n\nW+2  &  R-[  &  S-1+1  &  W+3 ",
                           choice1: "10517", choice1Destination: 11,
                           choice2: "8954", choice2Destination: 11,
                           correctAnswer: "8954",
                           Hint: "Use keys to get on top of the world",
                           isQuestion: true
                       )
            ,
                       //11
             Story(
                          title: "Look out for updates and new apps soon",
                          choice1: "Play again", choice1Destination: 0,
                          choice2: "Play again", choice2Destination: 0,
                          correctAnswer: "0",
                        Hint: "Press a button",
                        isQuestion: false
                      )
            ,
                                  //12
                        Story(
                                     title: "When you've stopped running and you're feeling brave...",
                                     choice1: "Enter the Escape room", choice1Destination: 1,
                                     choice2: "Or start again", choice2Destination: 0,
                                     correctAnswer: "0",
                                     Hint: "Stop running",
                                     isQuestion: false
                            
                                 )
            
        ]
        
        func getStoryTitle() -> String {
            return stories[storyNumber].title
        }
        
        func getIsQuestion() -> Bool {
            return stories[storyNumber].isQuestion
        }
        
        func getStoryHint() -> String {
                   return stories[storyNumber].Hint
               }
        
        func getChoice1() -> String {
            return stories[storyNumber].choice1
        }
        
        func getChoice2() -> String {
            return stories[storyNumber].choice2
        }
        
        func getCorrectAnswer() -> String {
            return stories[storyNumber].correctAnswer
            
        }
        
        func getStoryNumber() -> Int {
            return storyNumber
               }
        
       func checkAnswer(userAnswer: String) -> Int{
           
            if userAnswer == getCorrectAnswer() {
                   return 1
              
            } else{
                return 0}
        }
        
        
        
        mutating func nextStory(userChoice: String) {
          clickCount += 1
            
            let currentStory = stories[storyNumber]
            if userChoice == currentStory.choice1 {
                storyNumber = currentStory.choice1Destination
                
               
            } else if userChoice == currentStory.choice2 {
                storyNumber = currentStory.choice2Destination
               
                
            }
            
         
            
            
          
        
        }
        
        
        
    }
    
    
