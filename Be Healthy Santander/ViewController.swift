//
//  ViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 5/10/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var arrayOptions: [Opcao] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        var optionCell: Opcao
        
        optionCell = Opcao(tituloOpcao: "Step Counter", foto: #imageLiteral(resourceName: "localizacao"))
        arrayOptions.append(optionCell)
        
        optionCell = Opcao(tituloOpcao: "Hidrate-se", foto: #imageLiteral(resourceName: "garrafaDeAgua"))
        arrayOptions.append(optionCell)
        
        optionCell = Opcao(tituloOpcao: "Vídeos", foto: #imageLiteral(resourceName: "botaoPlay"))
        arrayOptions.append(optionCell)
        
        optionCell = Opcao(tituloOpcao: "Quiz da Saúde", foto:#imageLiteral(resourceName: "iconeQuiz") )
        arrayOptions.append(optionCell)
        
        optionCell = Opcao(tituloOpcao: "Movimente-se", foto: #imageLiteral(resourceName: "meninoCorrendoRapido"))
        arrayOptions.append(optionCell)
        
        optionCell = Opcao(tituloOpcao: "Agenda de Exames", foto: #imageLiteral(resourceName: "calendario"))
        arrayOptions.append(optionCell)
        
        optionCell = Opcao(tituloOpcao: "Calculadora de IMC", foto: #imageLiteral(resourceName: "calculadora"))
        arrayOptions.append(optionCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOptions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedOption = arrayOptions[indexPath.row]
        
        let optionsCells = "celulaOpcoes"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: optionsCells , for: indexPath) as! OpcaoCelula
        
        cell.imagemDaOpcao.image = selectedOption.foto
        cell.tituloDaOpcao.text = selectedOption.tituloOpcao
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch (indexPath.row) {
        case 0:
            print ("Escolheu a Linha 1! - Step Counter/n")
            self.performSegue( withIdentifier: "segueStepCounter", sender: self)
        case 1:
            print ("Escolheu a Linha 2! - Hidrate-se/n")
            self.performSegue( withIdentifier: "segueLembreteAgua", sender: self)
        case 2:
            print ("Escolheu a Linha 3! - Vídeos/n")
            self.performSegue( withIdentifier: "segueVideos", sender: self)
        case 3:
            print ("Escolheu a Linha 4! - Quiz da Saúde/n")
            self.performSegue( withIdentifier: "segueQuiz", sender: self)
        case 4:
            print ("Escolheu a Linha 5! - Movimente-se/n")
            self.performSegue( withIdentifier: "segueParaTelaDeCorrida", sender: self)
        case 5:
            print ("Escolheu a Linha 6! - Agenda de Exames/n")
            self.performSegue( withIdentifier: "segueAgenda", sender: self)
            
        default:
            print ("Escolheu a Linha 7! - Calculadora de IMC/n")
            self.performSegue( withIdentifier: "segueCalculoIMC", sender: self)
        }
    }
    
    }

