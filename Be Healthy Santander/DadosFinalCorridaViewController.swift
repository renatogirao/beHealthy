//
//  DadosFinalCorridaViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 5/10/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

import UIKit
import MapKit
import HealthKit


class DadosFinalCorridaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
        
        @IBOutlet weak var finalSpeed: UILabel!
        
        @IBOutlet weak var finalDistance: UILabel!
        
        @IBOutlet weak var finalCalories: UILabel!
        
        @IBOutlet weak var finalTimeDuration: UILabel!
        
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
        var receivedTime: Double = 0.0
        var receivedMap: MKMapView!
        var averageSpeed: Double! = 0.0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print ("INICIOU A VIEW DE DADOS DA CORRIDA")
            
            print("velocidade\(receivedSpeed)\n")
            print("calorias \(receivedCalories)\n")
            print ("distancia\(receivedDistance)\n")
            print ("tempo \(receivedTime)\n")
            print ("velocidade media \(averageSpeed)\n")
            
            
            averageSpeed = (Double(receivedTime)! / Double(receivedDistance)!)
            
            finalSpeed.text = "Velocidade: \(averageSpeed)"
            finalCalories.text = "Calorias Perdidas: \(receivedCalories)"
            finalDistance.text = "Distância Percorrida: \(receivedDistance)"
            finalTimeDuration.text = "Tempo: \(receivedTime)"
            
            //Arredondando o botão
            newRunButton.layer.cornerRadius = 10
            
            print ("velocidade média é: \(averageSpeed)")
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SegueVoltarCorrida" {
                print ("\n\nSegue voltando os Dados pra segunda View!\n\n")
                
                let viewControllerDeDestino2 = segue.destination as! CorridaViewController
                
                //Passando os dados da primeira, que ja vieram pra essa(srgunda) e passando pra terceira
                viewControllerDeDestino2.receivedHeight = receivedHeight2
                viewControllerDeDestino2.receivedWeight = receivedWeight2
                viewControllerDeDestino2.receivedAge = receivedAge2
                viewControllerDeDestino2.receivedSex = receivedSex2
                
                print ("\nOS DADOS DA TERCEIRA, VOLTARAM PRA SEGUNDA, BLZ \n\n")
            }
        }
}
