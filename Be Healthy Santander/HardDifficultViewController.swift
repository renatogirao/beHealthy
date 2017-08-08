//
//  EasyDifficultViewController.swift
//  PerguntasERespostas
//
//  Created by Renato on 18/03/17.
//  Copyright © 2017 Renato. All rights reserved.
//

import UIKit
import Foundation

class HardDifficultViewController: UIViewController {
    
    @IBOutlet weak var labelQuestionHard: UILabel!
    @IBOutlet weak var buttonAnswer1Hard: UIButton!
    @IBOutlet weak var buttonAnswer2Hard: UIButton!
    @IBOutlet weak var buttonAnswer3Hard: UIButton!
    @IBOutlet weak var buttonAnswer4Hard: UIButton!
    @IBOutlet weak var viewFeedbackHard: UIView!
    @IBOutlet weak var labelFeedbackHard: UILabel!
    @IBOutlet weak var buttonFeedbackHard: UIButton!
    @IBOutlet weak var labelFinalGradeHard: UILabel!
    @IBOutlet weak var buttonBackInicialViewHard: UIButton!

    
    
    var questions : [Question]! //vetor que contém as questões do quiz
    var currentQuestion = 0     //indica a questão atual
    var grade = 0.0             //double para o cálculo da nota
    var quizEnded = false       //Bool que indica se o quiz terminou ou não
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAnswer1Hard.layer.cornerRadius = 20
        buttonAnswer2Hard.layer.cornerRadius = 20
        buttonAnswer3Hard.layer.cornerRadius = 20
        buttonAnswer4Hard.layer.cornerRadius = 20
    
        //Questions
        let q0answer0 = Answer(answer: "1 hora", isCorrect: true)
        let q0answer1 = Answer(answer: "2 horas", isCorrect: false)
        let q0answer2 = Answer(answer: "3 horas", isCorrect: false)
        let q0answer3 = Answer(answer: "4 horas", isCorrect: false)
        let question0 = Question(question: "A cada quantas horas é recomendado beber um copo de água aproximadamente?", answers: [q0answer0, q0answer1, q0answer2, q0answer3])
        
        let q1answer0 = Answer(answer: "Praticar esportes regularmente", isCorrect: true)
        let q1answer1 = Answer(answer: "Não praticar esportes", isCorrect: false)
        let q1answer2 = Answer(answer: "Compensar a falta de esportes, forçando quando o fizer", isCorrect: false)
        let q1answer3 = Answer(answer: "Quanto mais exercício, melhor", isCorrect: false)
        let question1 = Question(question: "Qual o correto?", answers: [q1answer0, q1answer1, q1answer2, q1answer3])
        
        let q2answer0 = Answer(answer: "Entre 20 e 25", isCorrect: true)
        let q2answer1 = Answer(answer: "Quanto maior, melhor", isCorrect: false)
        let q2answer2 = Answer(answer: "Acima de 25", isCorrect: false)
        let q2answer3 = Answer(answer: "Quanto menor, melhor", isCorrect: false)
        let question2 = Question(question: "Qual o IMC ideal?", answers: [q2answer0, q2answer1, q2answer2, q2answer3])

        questions = [question0, question1, question2]
        
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
    
    @IBAction func ButtonFeedback(_ sender: AnyObject) {
        viewFeedbackHard.isHidden = true
        
        
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
        
        if (grade < 20) {
            labelFinalGradeHard.text = "Você tirou só \(grade)\n, estude mais"
        }
        if (grade > 20 && grade < 30) {
            labelFinalGradeHard.text = "Sua nota foi \(grade)\n Ainda pode melhorar um pouco"
        }
        if (grade > 30 && grade < 40) {
            labelFinalGradeHard.text = "Tá melhorando! Sua nota foi \(grade)\n"

        }
        if (grade > 40 && grade < 50) {
            labelFinalGradeHard.text = "Vish, sua nota foi \(grade)\n Você consegue ir um pouquinho melhor, vai..."
        }
        if (grade > 50 && grade < 60) {
            labelFinalGradeHard.text = "Tá melhorando! Sua nota foi \(grade)\n "
        }
        
        if (grade > 60 && grade < 70 ){
            labelFinalGradeHard.text = "Parabéns! Sua nota foi \(grade)\n"
        }
        if (grade > 70 && grade < 80 ){
            labelFinalGradeHard.text = "Parabéns! Sua nota foi \(grade)\n"
        }
        if (grade > 80 && grade < 90) {
            labelFinalGradeHard.text = "Sua nota foi \(grade)\n Muito bem, tá muito fitness!"
        }
        else if (grade > 90)
        {
            labelFinalGradeHard.text = "Parabéns! Sua nota foi \(grade)\n muito bom!"

        }
        quizEnded = true
        viewFeedbackHard.isHidden = false
        buttonFeedbackHard.setTitle("Refazer", for: UIControlState.normal)
        labelFinalGradeHard.isHidden = false
        
        
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
        labelFinalGradeHard.isHidden = true
        viewFeedbackHard.isHidden = true
        showQuestion(questionId: 0)
       
    }
    
    func showQuestion(questionId : Int){
        
        
        //Refresh the label of the question and yours answers
        
        labelQuestionHard.text = questions[questionId].strQuestion
        
        buttonAnswer1Hard.setTitle(questions[questionId].answers[0].strAnswer, for: UIControlState.normal)
        
        buttonAnswer2Hard.setTitle(questions[questionId].answers[1].strAnswer, for: UIControlState.normal)
        
        buttonAnswer3Hard.setTitle(questions[questionId].answers[2].strAnswer, for: UIControlState.normal)
        
        buttonAnswer4Hard.setTitle(questions[questionId].answers[3].strAnswer, for: UIControlState.normal)
        
    }
    //Function to choose the answer
    
    func selectAnswer(answerid : Int) {
        
        buttonAnswer1Hard.isEnabled = true
        buttonAnswer2Hard.isEnabled = true
        buttonAnswer3Hard.isEnabled = true
        buttonAnswer4Hard.isEnabled = true
        
        viewFeedbackHard.isHidden = false
        
        
        var answer : Answer = questions[currentQuestion].answers[answerid]
        
        if(answer.isCorrect == true){
            grade = grade + 1.0
            
            labelFeedbackHard.text = "\nParabéns! Certa resposta!"
           
            
        }else{
    
            labelFeedbackHard.text = "\n Que pena, resposta errada!, o correto era a \(questions[currentQuestion].answers[answerid])"
            
        }
        
        if (currentQuestion < 9){
            //If the question is not the last question, the button will show "Next question"
            buttonBackInicialViewHard.isHidden = true
            buttonFeedbackHard.setTitle("Próxima pergunta", for: UIControlState.normal)
            
        }else{
            //If the question is the last qustion, the button will show "See my grade"
            buttonBackInicialViewHard.isHidden = false
            buttonFeedbackHard.setTitle("Ver minha nota", for: UIControlState.normal)
            
        }
    }
}

