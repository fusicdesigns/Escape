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
                title: "To enter the room\n\nWhat is X?\n\n2 + X = 10",
                choice1: "X = 8", choice1Destination: 2,
                choice2: "X = 5", choice2Destination: 2,
                correctAnswer: "X = 8",
                Hint: "I ain't going to helo with this one",
                isQuestion: true
            ),
            //2
            Story(
                title: "You're in a corridor and see this on the wall\n\nIf A = B and C = D\n\n What does E=?",
                choice1: "F", choice1Destination: 3,
                choice2: "D", choice2Destination: 3,
                correctAnswer: "F",
                Hint: "An ALPHA might BET you'd get this right",
                isQuestion: true
            ),
            //3
            Story(
                title: "What's my door number?\n\nYou can shake a sharp stick in this sphere",
                choice1: "121", choice1Destination: 4,
                choice2: "21", choice2Destination: 4,
                correctAnswer: "21",
                Hint: "To be, or not to be, that is the question",
                isQuestion: true
            ),
            //4
            Story(
                title: "Solve the riddle\n\nYou go at red, but stop at green.\n\nWhat am I?",
                choice1: "Watermelon", choice1Destination: 5,
                choice2: "Radish", choice2Destination: 5,
                correctAnswer: "Watermelon",
                Hint: "I'm sweat not spicy",
                isQuestion: true
            ),
            //5
            Story(
                title: "0°N 0°E\n\n Where am I?",
                choice1: "Greenwich", choice1Destination: 6,
                choice2: "Null", choice2Destination: 6,
                correctAnswer: "Null",
                Hint: "It's in the sea",
                isQuestion: true
            ),
            //6
            Story(
                title: "I 'bet' you can find this.\n\nALPHA - 2\n\n 4th, 3rd, 2nd = ",
                choice1: "Fig", choice1Destination: 7,
                choice2: "Fij", choice2Destination: 7,
                correctAnswer: "Fij",
                Hint: "Use your keys",
                isQuestion: true
            ),
            //7
            Story(
                title: "What is the answer to everything?",
                choice1: "27", choice1Destination: 8,
                choice2: "42", choice2Destination: 8,
                correctAnswer: "42",
                Hint: "You might need someone to give you a ride to space for this one",
                isQuestion: true
            )
            ,
            //8
            Story(
                title: "0, 1, 1, 2, 3, 5, 8, 13, 21, 34\n\nIf I said 55 was the next number would I be worng or telling a Fib",
                choice1: "Fib", choice1Destination: 9,
                choice2: "wrong", choice2Destination: 9,
                correctAnswer: "Fib",
                Hint: "Who's number is it?",
                isQuestion: true
                
            )
            ,
            //9
            Story(
                title: "I can read your mind.\n\n Think of a number between 3 and 5",
                choice1: "4", choice1Destination: 10,
                choice2: "3", choice2Destination: 10,
                correctAnswer: "4",
                Hint: "Read between the numbers",
                isQuestion: true
            )
            ,
            //10
            Story(
                title: "Yellow and blue make what? ",
                choice1: "Green", choice1Destination: 11,
                choice2: "Orange", choice2Destination: 11,
                correctAnswer: "Green",
                Hint: "Leaf it out",
                isQuestion: true
            )
            ,
            //11
            Story(
                title: "Look out for updates and new apps soon",
                choice1: "Play again", choice1Destination: 0,
                choice2: "Level 2", choice2Destination: 13,
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
            ),
                // 13 - Level 2
                
                Story( title: "As you exit the Escape Room, you find yourself in front of a big locked door.\n\n Do you?",
                       choice1: "Try to open the door", choice1Destination: 14,
                       choice2: "Go back to the first room", choice2Destination: 25,
                       correctAnswer: "",
                       Hint: "The is no way back",
                       isQuestion: false
                ),// 14 - Level 2
                
                Story(
                    title: "There's a sign. To enter the room\n\nWhat is X?\n\n2 + X * 2 = 10",
                    choice1: "X = 3", choice1Destination: 15,
                    choice2: "X = 4", choice2Destination: 15,
                    correctAnswer: "X = 4",
                    Hint: "Multiply first",
                    isQuestion: true
                ),
                //15
                Story(
                    title: "You're in the room and see this two buttons on the wall and this on the wall\n\nIf A = G and C = I\n\n What does E=?",
                    choice1: "K", choice1Destination: 16,
                    choice2: "L", choice2Destination: 16,
                    correctAnswer: "K",
                    Hint: "An ALPHA might BET you'd get this right",
                    isQuestion: true
                ),
                //16
                Story(
                    title: "A secret door opens and inside there's a globe. Where am I?\n\nG & M & T + 10 =",
                    choice1: "Tokyo", choice1Destination: 17,
                    choice2: "Sydney", choice2Destination: 17,
                    correctAnswer: "Sydney",
                    Hint: "What's the time?",
                    isQuestion: true
                ),
                //17
                Story(
                    title: "On table there's a Kangeroo toy and a sign.  Solve the riddle\n\nOne enters it blind and comes out seeing\n\nWhat is it?",
                    choice1: "Hospital", choice1Destination: 18,
                    choice2: "School", choice2Destination: 18,
                    correctAnswer: "School",
                    Hint: "This is training not fixing",
                    isQuestion: true
                ),
                //18
                Story(
                    title: "The Kangeroo says 'Which London location am I?\n\n13.5° S + 72° W + Orange jam'",
                    choice1: "Station", choice1Destination: 19,
                    choice2: "Stadium", choice2Destination: 19,
                    correctAnswer: "Station",
                    Hint: "Bear with us",
                    isQuestion: true
                ),
                //19
                Story(
                    title: "There's a train on the shelf with this on the side.\n\nDECIPHER THIS -4 \n\n13th 6th 7th = ",
                    choice1: "Old", choice1Destination: 20,
                    choice2: "And", choice2Destination: 20,
                    correctAnswer: "Old",
                    Hint: "'Decipher this' needs to be deciphered",
                    isQuestion: true
                ),
                //20
                Story(
                    title: "On an old clock you see [ = 1, * =8 \n\n Find the value of },# and = to find the answer to this \n\n} + * + [ - # + = - [",
                    choice1: "=18", choice1Destination: 21,
                    choice2: "=17", choice2Destination: 21,
                    correctAnswer: "=17",
                    Hint: "The symbols are alternative iOS keys ",
                    isQuestion: true
                )
                ,
                //21
                Story(
                    title: "There are 17 candles in the room, under one you find this code\n\n--  .-  --.  ..  -.-.",
                    choice1: "Magic", choice1Destination: 22,
                    choice2: "Motel", choice2Destination: 22,
                    correctAnswer: "Magic",
                    Hint: "Detective Morse would get this",
                    isQuestion: true
                    
                )
                ,
                //22
                Story(
                    title: "Can the magic 8 ball read your mind?\n\n- Choose a number 1 and 10\n- Multiply it by 2\n- Now multiply by 5\n- Divide by your number\n- Subtract 7",
                    choice1: "3", choice1Destination: 23,
                    choice2: "7", choice2Destination: 23,
                    correctAnswer: "3",
                    Hint: "Tell me first",
                    isQuestion: true
                )
                ,
                //23
                Story(
                    title: "There are 3 dragons on the wall, in one's mouth there's a note. Solve the code \n\nQ+2  &  Z+3  &  Y-3  &  \n\nW+2  &  R-[  &  S-1+1  &  W+3 ",
                    choice1: "10517", choice1Destination: 24,
                    choice2: "8954", choice2Destination: 24,
                    correctAnswer: "8954",
                    Hint: "Use keys to get on top of the world",
                    isQuestion: true
                )
                ,
                //24
                Story(
                    title: "Look out for updates and new apps soon",
                    choice1: "Play again", choice1Destination: 0,
                    choice2: "Play again", choice2Destination: 25,
                    correctAnswer: "0",
                    Hint: "Press a button",
                    isQuestion: false
                )
                ,
                //25
                Story(
                    title: "As you turn to back to the first door, it slams shut in front of you",
                    choice1: "Try the second door", choice1Destination: 14,
                    choice2: "SCREAM", choice2Destination: 13,
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
    
    
