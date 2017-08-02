//
//  DadosDaCorridaViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 5/15/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

import UIKit
import HealthKit
import MapKit

class DadosDaCorridaViewController: UIViewController {
    @IBOutlet weak var labelVelocity: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelCalories: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var newRunButton: UIButton!

    //variaveis recebidas da primeira e da segunda view
    
    var receivedHeight2 : String!
    var receivedWeight2 : String!
    var receivedAge2 : String!
    var receivedSex2 : String!
    
    //-------------------------------------------
    
    var receivedSpeed: String = ""
    var receivedCalories : String = ""
    var receivedDistance : String = ""
    var receivedTime: String = ""
    var receivedMap: MKMapView!
    var averageSpeed: Double! = 0.0
    var receivedTimeDouble : TimeInterval = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("\n\nINICIOU A VIEW DE DADOS DA CORRIDA\n\n")
        
        averageSpeed = Double(receivedDistance)! / receivedTimeDouble as Double!
        let averageSpeedKmH = (averageSpeed * 3.6)
        
        print("Velocidade Média em m/s: \(averageSpeed)")
        print("Velocidade Média em Km/h: \(averageSpeedKmH)")
        print("Calorias: \(receivedCalories)")
        print ("Distância: \(receivedDistance)")
        print ("Último Tempo: \(receivedTime)")
        print ("Velocidade Média: \(averageSpeed)")
        print ("Tempo Recebido Convertido: \(receivedTimeDouble)")
        
        labelVelocity.text = String (format: "Velocidade: %.2f Km/h", averageSpeedKmH)
        labelCalories.text = "Calorias Perdidas: \(receivedCalories)"
        labelDistance.text = "Distância: \(receivedDistance) metros"
        labelDuration.text = "Tempo: \(receivedTime)"
        
        //Arredondando o botão
        newRunButton.layer.cornerRadius = 10
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueRetornarCorrida"{
            
            print ("\nSegue voltando os dados pra segunda VIew!\n")
            
            let viewControllerDeDestino2 = segue.destination as! CorridaViewController
            
            //Passando os dados da primeira, que ja vieram pra essa(segunda) e passando pra terceira
            viewControllerDeDestino2.receivedHeight = receivedHeight2
            viewControllerDeDestino2.receivedWeight = receivedWeight2
            viewControllerDeDestino2.receivedAge = receivedAge2
            viewControllerDeDestino2.receivedSex = receivedSex2
            print ("\n\nos dados da terceira, voltaram pra segunda\n\n")
            
            
        }
    }
}
