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
    
    func criarAlerta (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func cadastrarUsuario(_ sender: UIButton) {
        
        
        usuario.createUser(withEmail: textFieldUsernameRegistrar.text!, password: textFieldPasswordRegistro.text!) { (usuario, erro) in
            
            if erro == nil {
                print ("\nusuario está logado\n" + String (describing: usuario?.email))
                self.performSegue( withIdentifier: "SegueVoltarLogin", sender: self)
            }else{
                self.criarAlerta(title: "ACESSO NEGADO", message: "Acesso Negado por causa de \(erro!.localizedDescription)")
            print ("\nusuário nao esta logado!\n" + String(describing: erro?.localizedDescription))
                
               
            }
        }
    }
}
