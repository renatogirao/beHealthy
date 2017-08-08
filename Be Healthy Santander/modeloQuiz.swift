//
//  modeloQuiz.swift
//  PerguntasERespostas
//
//  Created by Renato on 09/03/17.
//  Copyright © 2017 Renato. All rights reserved.
//

import Foundation
import UIKit

class Question{
    var strQuestion : String! //String para armazenar o texto da questão
    
    var answers : [Answer]! //Vetor de objetos da classe Answer para armazenar as respostas

    //Funcão que inicializa o objeto da classe question
    init(question : String, answers : [Answer]){
        self.strQuestion = question
        self.answers = answers
        
    }
}

class Answer{
    var strAnswer : String! //String para armazenar o texto da resposta
    var isCorrect : Bool! //Boolean para armazenar se a resposta é a correta ou não
    
    //Funcão que inicializa o objeto da classe answer
    init(answer : String, isCorrect : Bool){
        self.strAnswer = answer
        self.isCorrect = isCorrect
    }
    
    
    
    
}
