//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNum : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickedAnswer = true
        }else if sender.tag == 2{
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNum += 1
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        if questionNum <= 12 {
        progressLabel.text = "\(questionNum + 1) / 13"
        progressBar.frame.size.width = (view.frame.width / 13) * CGFloat(1 + questionNum)
        }
        
    }
    

    func nextQuestion() {
        if questionNum <= 12{
            questionLabel.text = allQuestions.list[questionNum].questionText
        }else{
            let alert = UIAlertController(title: "Awesome!!!", message: "You've finished all questions! do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            present(alert,animated: true,completion: nil)
        }
    }
    
    
    func checkAnswer() {
        if allQuestions.list[questionNum].answer == pickedAnswer{
            ProgressHUD.showSuccess("Congrats!")
            score += 1
        }else{
            ProgressHUD.showError("Sorry :(")
        }
    }
    
    
    func startOver() {
       questionNum = 0
       score = 0
       nextQuestion()
       updateUI()
       
    }
    

    
}
