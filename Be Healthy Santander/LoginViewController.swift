//
//  LoginViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 5/11/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cliqueFora: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(cliqueFora)
        
        buttonLogin.layer.cornerRadius = 10
        
        let usuario = Auth.auth()
        
        usuario.signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (usuario, erro) in
            if erro == nil {
                
                print ("Sucesso ao logar usuario!\n")
                
            }else{
                print ("Erro ao logar usuário! \n\(String(describing: erro?.localizedDescription))")
                
            }
        }
        
        
        
        usuario.addStateDidChangeListener { (autenticacao, usuario) in
            if let usuarioLogado = usuario {
                print("usuario esta logado tela login" + String(describing: usuarioLogado.email))
            }else{
                print ("usuario nao está logado! - tela login")
                
            }
        }
    }
    
    func dismissKeyboard(){
        //textField.resignFirstResponder()
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
