//
//  QuestionsManager.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 15/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class QuestionsManager {
    static func insert() {
        let questions = [
            "Am I using my time wisely?",
            "Am I taking anything for granted?",
            "Am I employing a healthy perspective?",
            "Am I living true to myself?",
            "Am I waking up in the morning ready to take on the day?",
            "Am I thinking negative thoughts before I fall asleep?",
            "Am I putting enough effort into my relationships?",
            "Am I taking care of myself physically?",
            "Am I letting matters that are out of control stress me out?",
            "Am I achieving the goals that I’ve set for myself?",
            "Who am I really?",
            "What worries me most about the future?",
            "If this were the last day of my life, would I want to do what I am about to do today?",
            "What am I really scared of?",
            "Am I holding on to something I need to let go of?",
            "If not now, then when?",
            "What matters most in my life?",
            "What am I doing about the things that matter most in my life?",
//            "What do I matter?",
            "Have I done anything lately worth remembering?",
            "Have I made someone smile today?",
            "What have I given up on?",
            "When did I last push the boundaries of my comfort zone?",
            "If I had to instill one piece of advice in a newborn baby’s mind, what advice would I give?",
            "What small act of kindness was I once shown that I will never forget?",
            "How shall I live, knowing I will die?",
            "What do I need to change about myself?",
            "Is it more important to love or be loved?",
            "How many of my friends would I trust with my life?",
            "Who has had the greatest impact on my life?",
            "Would I break the law to save a loved one?",
            "Would I steal to feed a starving child?",
            "What do I want most in life?",
            "What is life calling of me?",
            "Which is worse: failing or never trying?",
            "If I try to fail, and succeed, what have I done?",
            "What’s the one thing I’d like others to remember about me at the end of my life?",
            "Does it really matter what others think about me?",
            "To what degree have I actually controlled the course my life has taken?",
            "When it’s all said and done, what will I have said more than I’ve done?",
            "My favorite way to spend the day is…",
            "If I could talk to my younger self, the one thing I would say is…",
            "The two moments I’ll never forget in my life are… Describe them in great detail, and what makes them so unforgettable.",
            "What are the 10 things that make me smile?",
            "The words I’d like to live by are…",
            "I couldn’t imagine living without…",
            "When I’m in pain — physical or emotional — the kindest thing I can do for myself is…",
            "Who are the people in my life that genuinely support me and that I can genuinely trust? (What about making time to hang out with them?)",
            "What does unconditional love look like for me?",
            "What would I do if I loved myself unconditionally? How can I act on these things whether I do or don’t?",
            "I really wish others knew this about me…",
            "What is enough for me?",
            "If my body could talk, it would say…",
            "In which compassionate way I’ve supported a friend recently. Then write down how I can do the same for myself.",
            "What do I love about life?",
//            "What always brings tears to my eyes? (As Paulo Coelho has said, “Tears are words that need to be written.”)",
            "When work felt real to me, necessary and satisfying, paid or unpaid, professional or domestic, physical or mental?",
            "What do I have to say about my first love — whether a person, place or thing?",
            "How would I describe myself using 10 words?",
            "What’s surprised me the most about my life or life in general?",
            "What can I learn from my biggest mistakes?",
            "I feel most energized when…",
            "What are the questions I urgently need answers?",
            "What inspires me — from books to websites to quotes to people to paintings to stores to the stars?",
            "What’s one topic I need to learn more about to help me live a more fulfilling life?",
            "I feel happiest in my skin when…",
            "Make a list of everything I’d like to say no to.",
            "Make a list of everything I’d like to say yes to.",
            "What are the words that I need to hear?",
            "What is my definitons of success?",
            "What type of friend do I want to be?",
            "Do I engage in activities to escape my reality?",
            "Do I believe every thought I think?",
            "What is the best advice I've ever received?",
            "What is currently worrying me?"
            
        ]
        
        AuthorDAO.shared.create(authorName: "System") { (author, error) -> (Void) in
            CategoryDAO.shared.create(name: "Default") { (category, error) -> (Void) in
                for question in questions {
                    DissertativeQuestionDAO.shared.create(questionText: question, category: category!, author: author!, completion: { (_, _) -> (Void) in })
                }
            }
        }
        
    }
    
    static func generateQuestionsForToday(){
        DissertativeQuestionDAO.shared.fetchAll { (questions, error) -> (Void) in
            guard error == nil && questions != nil else{
                fatalError("Impossible fetch the dissertative questions from the CoreDate")
            }
            
            var todayQuestions: [DissertationQuestion] = Array()
            
            if var unansweredQuestions = questions?.filter({ (question) -> Bool in
                return question.answers?.count == 0
            }) {
            
                
                if unansweredQuestions.count < 3 {
                    let alreadyAnsweredQuestions = questions?.filter({ (question) -> Bool in
                        return !unansweredQuestions.contains(question)
                    })
                    
                    todayQuestions.append(contentsOf: unansweredQuestions)
                    while todayQuestions.count < 3 {
                        
                        let random = alreadyAnsweredQuestions!.randomElement()
                        
                        if !(todayQuestions.contains(random!)) {
                            todayQuestions.append(random!)
                        }
                    }
                } else {
                    while todayQuestions.count < 3 {
                        
                        let random = unansweredQuestions.randomElement()
                        
                        if !(todayQuestions.contains(random!)) {
                            todayQuestions.append(random!)
                        }
                        
                        
                    }
                }
            }
            
            let questionsDescriptions: [String] = todayQuestions.map({ (question) -> String in
                return question.questionText!
            })
            
            UserDefaults.standard.set(questionsDescriptions, forKey: "todayQuestions")
            
        }
    }
}
