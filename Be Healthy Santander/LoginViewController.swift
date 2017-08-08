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
        
        
        
      
    }
    
    func dismissKeyboard(){
        //textField.resignFirstResponder()
        view.endEditing(true)
    }
    
    func criarAlerta (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logarUsuario(_ sender: Any) {
    let usuario = Auth.auth()
        usuario.signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (usuario, erro) in
            if erro == nil {
                
                print ("Sucesso ao logar usuario!\n")
                self.performSegue( withIdentifier: "SegueLoginFeito", sender: self)
            }else{
                print ("Erro ao logar usuário! \n\(String(describing: erro?.localizedDescription))")
                self.criarAlerta(title: "ACESSO NEGADO", message: "Acesso Negado por causa de \(erro!.localizedDescription)")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
