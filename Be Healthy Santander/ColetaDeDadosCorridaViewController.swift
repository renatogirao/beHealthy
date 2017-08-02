//
//  ColetaDeDadosCorridaViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 5/10/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

import UIKit

class ColetaDeDadosCorridaViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textFieldWeight: UITextField!
    @IBOutlet weak var textFieldHeight: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var labelMissingFill: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var userSex: String = ""
    @IBOutlet weak var manButton: UIButton!
    @IBOutlet weak var girlButton: UIButton!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelCmHeight: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        startButton.layer.cornerRadius = 15
        labelAge.layer.cornerRadius = 10
        labelWeight.layer.cornerRadius = 50
        labelCmHeight.layer.cornerRadius = 02
        textFieldWeight.becomeFirstResponder()
        
        
        textFieldHeight.delegate = self
        textFieldAge.delegate = self
        textFieldWeight.delegate = self
        
        let cliqueFora: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(cliqueFora)
        
        startButton.layer.cornerRadius = 15
        labelAge.layer.cornerRadius = 04
        labelWeight.layer.cornerRadius = 04
        labelCmHeight.layer.cornerRadius = 04
        
        print ("\nAplicativo Rodando  \0/ \n")
        
    }
    
    @IBAction func selecionouMulher(_ sender: UIButton) {
        
        userSex = "Mulher"
        manButton.setImage(#imageLiteral(resourceName: "menino.png"), for: UIControlState.normal)
        girlButton.setImage(#imageLiteral(resourceName: "meninoComemorandoEscolhido.png"), for: UIControlState.normal)
        print ("Selecionou Mulher\n")
    }
    
    @IBAction func selecionouHomem(_ sender: UIButton) {
        
        userSex = "Homem"
        manButton.setImage(#imageLiteral(resourceName: "meninoComemorandoEscolhido.png"), for: UIControlState.normal)
        girlButton.setImage(#imageLiteral(resourceName: "menina.png"), for: UIControlState.normal)
        print ("Selecionou Homem\n")
    }
    
    
    
    func dismissKeyboard(){
        
        view.endEditing(true)
        
        verificacaoDeDadosDoUsuario()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == textFieldHeight) {
            
            textFieldWeight.becomeFirstResponder()
            verificacaoDeDadosDoUsuario()
        }
        
        if (textField == textFieldWeight) {
            
            textFieldAge.becomeFirstResponder()
            verificacaoDeDadosDoUsuario()
        } else if (textField == textFieldAge) {
            
            verificacaoDeDadosDoUsuario()
        }
        return true
    }
    
    func verificacaoDeDadosDoUsuario() {
        
        if textFieldWeight.text == ""
        {
            labelMissingFill.text = "Favor preencher seu peso!"
            startButton.isHidden = true
        }
        
        if textFieldAge.text == ""
        {
            labelMissingFill.text = "Favor preencher sua idade!"
            startButton.isHidden = true
        }
        
        if textFieldHeight.text == ""
        {   labelMissingFill.text = "Favor preencher sua altura!"
            startButton.isHidden = true
        }
        if  textFieldAge.text == "" &&
            textFieldHeight.text == "" &&
            textFieldWeight.text == ""
        {
            labelMissingFill.text = "Favor preencher os campos!"
            startButton.isHidden = true
        }
        if  textFieldHeight.text == "" &&
            textFieldWeight.text == "" && textFieldAge.text != ""
        {
            labelMissingFill.text = "Favor preencher o peso e a altura"
            startButton.isHidden = true
        }
        
        if  textFieldAge.text == "" &&
            textFieldWeight.text == "" && textFieldHeight.text != ""
        {
            labelMissingFill.text = "Favor preencher a o peso e a idade!"
            startButton.isHidden = true
        }
        
        if  textFieldHeight.text == "" &&
            textFieldAge.text == "" && textFieldWeight.text != ""
        {
            labelMissingFill.text = "Favor preencher a altura e a idade!"
            startButton.isHidden = true
        }
        
        if  userSex == "" && textFieldAge.text != "" &&
            textFieldHeight.text != "" &&
            textFieldWeight.text != ""
        {
            labelMissingFill.text = "Favor escolher seu sexo!"
            startButton.isHidden = true
            
        }
        
        if textFieldAge.text != "" &&
            textFieldHeight.text != "" &&
            textFieldWeight.text != "" && userSex != "" {
            labelMissingFill.text = "Podemos começar!"
            startButton.isHidden = false
            
        } else {
            
            startButton.isHidden = true
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueIniciarCorrida" {
            
            let viewControllerDestino = segue.destination as! CorridaViewController
            
            viewControllerDestino.receivedHeight = textFieldHeight.text!
            viewControllerDestino.receivedWeight = textFieldWeight.text!
            viewControllerDestino.receivedAge = textFieldAge.text!
            viewControllerDestino.receivedSex = userSex
            
           
            
        }
    }
}
