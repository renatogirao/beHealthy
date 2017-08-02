//
//  RegistroViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 19/07/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegistroViewController: UIViewController {
    @IBOutlet weak var logoBeHealthyAzulClaro: UIImageView!
    @IBOutlet weak var botaoRegistrarFacebook: UIButton!
    @IBOutlet weak var textFieldUsernameRegistrar: UITextField!
    @IBOutlet weak var textFieldPasswordRegistro: UITextField!
    @IBOutlet weak var botaoRegistrarCadastro: UIButton!
    
    let usuario = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Arredondando as bordas dos elementos
        
        botaoRegistrarFacebook.layer.cornerRadius = 10
        botaoRegistrarCadastro.layer.cornerRadius = 10
        textFieldPasswordRegistro.layer.cornerRadius = 10
        textFieldUsernameRegistrar.layer.cornerRadius = 10
        
        let cliqueFora: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(cliqueFora)
        
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
    
    @IBAction func cadastrarUsuario(_ sender: UIButton) {
        
        usuario.createUser(withEmail: textFieldUsernameRegistrar.text!, password: textFieldPasswordRegistro.text!) { (usuario, erro) in
            if erro == nil {
                print ("usuario está logado\n" + String (describing: usuario?.email))
                
            }else{
                print ("usuário nao ta logado!\n" + String(describing: erro?.localizedDescription))
                
            }
        }
    }
}
