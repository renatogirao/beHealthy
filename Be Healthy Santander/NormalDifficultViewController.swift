//
//  EasyDifficultViewController.swift
//  PerguntasERespostas
//
//  Created by Renato on 18/03/17.
//  Copyright © 2017 Renato. All rights reserved.
//

import UIKit
import Foundation

class NormalDifficultViewController: UIViewController {
    
    @IBOutlet weak var labelQuestionNormal: UILabel!
    @IBOutlet weak var buttonAnswer1Normal: UIButton!
    @IBOutlet weak var buttonAnswer2Normal: UIButton!
    @IBOutlet weak var buttonAnswer3Normal: UIButton!
    @IBOutlet weak var buttonAnswer4Normal: UIButton!
    @IBOutlet weak var viewFeedbackNormal: UIView!
    @IBOutlet weak var labelFeedbackNormal: UILabel!
    @IBOutlet weak var buttonFeedbackNormal: UIButton!
    @IBOutlet weak var labelFinalGradeNormal: UILabel!
    @IBOutlet weak var backInicialViewButton: UIButton!
    
    
    var questions : [Question]! //vetor que contém as questões do quiz
    var currentQuestion = 0     //indica a questão atual
    var grade = 0.0             //double para o cálculo da nota
    var quizEnded = false       //Bool que indica se o quiz terminou ou não
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAnswer1Normal.layer.cornerRadius = 20
        buttonAnswer2Normal.layer.cornerRadius = 20
        buttonAnswer3Normal.layer.cornerRadius = 20
        buttonAnswer4Normal.layer.cornerRadius = 20
        
        //Questions
        let q0answer0 = Answer(answer: "Beber agua", isCorrect: true)
        let q0answer1 = Answer(answer: "Beber muito refrigerante", isCorrect: false)
        let q0answer2 = Answer(answer: "Comer bastante", isCorrect: false)
        let q0answer3 = Answer(answer: "Comer só salada", isCorrect: false)
        let question0 = Question(question: "Escolha o correto", answers: [q0answer0, q0answer1, q0answer2, q0answer3])
        
        let q1answer0 = Answer(answer: "Fazer exercícios", isCorrect: true)
        let q1answer1 = Answer(answer: "Levar uma vida leve sem suar", isCorrect: false)
        let q1answer2 = Answer(answer: "Comer porcarias", isCorrect: false)
        let q1answer3 = Answer(answer: "Comer só carne", isCorrect: false)
        let question1 = Question(question: "Escolha o errado", answers: [q1answer0, q1answer1, q1answer2, q1answer3])
  
        
        questions = [question0, question1]
        
        startQuiz() //function that iniciate the quiz
        
        //Functions
    }
    
    @IBAction func toAnswerButton1(_ sender: UIButton) {
        
        selectAnswer(answerid: 0)
    }
    
    @IBAction func toAnswerButton2(_ sender: UIButton) {
        selectAnswer(answerid: 1)
    }
    
    @IBAction func toAnswerButton3(_ sender: UIButton) {
        selectAnswer(answerid: 2)
    }
    
    @IBAction func toAnswerButton4(_ sender: UIButton) {
        selectAnswer(answerid: 3)
    }
    
    @IBAction func answerButtonFeedback(_ sender: AnyObject) {
        viewFeedbackNormal.isHidden = true
        
        if(quizEnded){
            
            startQuiz()
        }else{
            nextQuestion()
        }
    }
    
    
    //function to change to the next question
    func nextQuestion(){
        currentQuestion += 1
        
        
        if(currentQuestion < 3){
            showQuestion(questionId: currentQuestion)
        }else{
            endQuiz()
        }
    }
    
    // function that end the quiz
    
    func endQuiz() {
        grade = grade * 10
        
        if (grade < 30.0) {
            labelFinalGradeNormal.text = "Sua nota foi \(grade)\n "
        }
        if (grade > 30.0 && grade < 50.0) {
            labelFinalGradeNormal.text = "Sua nota foi \(grade)\n"
        }
        if (grade > 50.0 && grade < 60.0) {
            labelFinalGradeNormal.text = "Tá melhorando! Sua nota foi \(grade)\n "
        }
        
        if (grade > 60.0 && grade < 70.0 ){
            labelFinalGradeNormal.text = "Parabéns! Sua nota foi \(grade)\n "
        }
        if (grade > 70.0 && grade < 90.0 ){
            labelFinalGradeNormal.text = "Sua nota foi \(grade)\n"
        }
        else if(grade > 90.0){
            labelFinalGradeNormal.text = "Parabéns! Sua nota foi \(grade)\n "
        }
        quizEnded = true
        viewFeedbackNormal.isHidden = false
        buttonFeedbackNormal.setTitle("Refazer", for: UIControlState.normal)
        labelFinalGradeNormal.isHidden = false
        
    }
    //Function that iniciate the quiz
    func startQuiz () {
        questions.shuffle() //function to shuffle the questions
        
        for i in 0 ..< questions.count {
            questions[i].answers.shuffle() //Shuffle the answers of the questions too
        }
        
        //reset the progress of the player
        quizEnded = false
        grade = 0.0
        currentQuestion = 0
        labelFinalGradeNormal.isHidden = true
        viewFeedbackNormal.isHidden = true
        showQuestion(questionId: 0)
    }
    
    func showQuestion(questionId : Int){
        
        //Refresh the label of the question and yours answers
        
      

        labelQuestionNormal.text = questions[questionId].strQuestion
                
        buttonAnswer1Normal.setTitle(questions[questionId].answers[0].strAnswer, for: UIControlState.normal)
        
        buttonAnswer2Normal.setTitle(questions[questionId].answers[1].strAnswer, for: UIControlState.normal)
        
        buttonAnswer3Normal.setTitle(questions[questionId].answers[2].strAnswer, for: UIControlState.normal)
        
        buttonAnswer4Normal.setTitle(questions[questionId].answers[3].strAnswer, for: UIControlState.normal)
        
        
    }
    //Function to choose the answer
    
    func selectAnswer(answerid : Int) {
        
        buttonAnswer1Normal.isEnabled = true
        buttonAnswer2Normal.isEnabled = true
        buttonAnswer3Normal.isEnabled = true
        buttonAnswer4Normal.isEnabled = true
        
        viewFeedbackNormal.isHidden = false
        
         
        
        var answer : Answer = questions[currentQuestion].answers[answerid]
        
        if(answer.isCorrect == true){
            grade = grade + 1.0
            
            labelFeedbackNormal.text = "\nParabéns! Certa resposta!"
                   }else{
            
            labelFeedbackNormal.text = "\n Que pena, resposta errada!"
        }
        
        
        if (currentQuestion < 9){
        //If the question is not the last question, the button will show "Next question"
            backInicialViewButton.isHidden = true
            
            
            buttonFeedbackNormal.setTitle("Próxima pergunta", for: UIControlState.normal)
            
        }else{
            //If the question is the last qustion, the button will show "See my grade"
            backInicialViewButton.isHidden = false
            buttonFeedbackNormal.setTitle("Ver minha nota", for: UIControlState.normal)
            
        }
    }
}

