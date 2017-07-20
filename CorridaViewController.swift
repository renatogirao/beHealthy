//
//  CorridaViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 5/10/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

    import UIKit
    import MapKit
    import HealthKit
    
    class CorridaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
        
        
        
        @IBOutlet weak var map: MKMapView!
        var localizationManager = CLLocationManager()
        @IBOutlet weak var labelSpeed: UILabel!
        @IBOutlet weak var labelAddress: UILabel!
        @IBOutlet weak var labelTime: UILabel!
        @IBOutlet weak var labelDistance: UILabel!
        @IBOutlet weak var labelCalories: UILabel!
        lazy var timer = Timer()
        var seconds = 0.0
        var distance = 0.0
        var calories = 0.0
        var IMC: Double = 0.0
        var startLocation: CLLocation!
        var lastLocation: CLLocation!
        var startDate: Date!
        var traveledDistance: Double = 0
        var straightDistance: Double = 0
        @IBOutlet weak var stopButton: UIButton!
        
        //Variáveis recebidas da última view
        
        
        
        
        //Variáveis recebidas da primeira View
        
        var receivedHeight : String!
        var receivedWeight : String!
        var receivedAge : String!
        var receivedSex : String!
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print ("\n\nPASSOU PRA SEGUNDA VIEW\n\n")
            
            localizationManager.delegate = self
            localizationManager.desiredAccuracy = kCLLocationAccuracyBest
            localizationManager.requestWhenInUseAuthorization()
            localizationManager.startUpdatingLocation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(self.atualizaSegundo(timer:)),
                                         userInfo: nil,
                                         repeats: true)
            
            print ("\(receivedWeight)")
            print ("\(receivedHeight)")
            print ("\(receivedAge)")
            
            
            let convertedHeight = Double (receivedHeight)
            let convertedAge = Double(receivedAge)
            
            // altura convertida para Metros e centímetros
            let heightInMeters = (convertedHeight! * 0.010)
            
            
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            timer.invalidate()
        }
        
        func atualizaSegundo(timer: Timer) {
            
            seconds += 1
            
            
            let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds)
            labelTime.text = secondsQuantity.description
           
           
            //formula para calculo de calorias : Velocidade (km/h) x peso (kg) x 0,0175.
            
            let speedUser = Double(labelSpeed.text!)
            
            let convertedWeightDouble = Double(receivedWeight)
            
            
            if  Date().timeIntervalSince(startDate) > 0 {
                let lostCalories =  (Date().timeIntervalSince(startDate) / 60) * speedUser! * convertedWeightDouble! * 0.0175
                
                
                let quantityCalories = HKQuantity(unit:HKUnit.kilocalorie(), doubleValue: lostCalories)
                labelCalories.text = String(format: "%.2f Kcal", lostCalories)
                
            }
            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let localizacaoUsuario = locations.last!
            
            let longitude = localizacaoUsuario.coordinate.longitude
            let latitude = localizacaoUsuario.coordinate.latitude
            
            
            let velocidadeUsuario = Double(localizacaoUsuario.speed)
            let velocidadeEmKmh = velocidadeUsuario * 3.6
            
            if localizacaoUsuario.speed > 0 {
                labelSpeed.text = String(format: "%.2f", velocidadeEmKmh)
                
            }else{
                
                self.labelSpeed.text = String("0.0")
            }
            
            let deltaLat: CLLocationDegrees = 0.01
            let deltaLon: CLLocationDegrees = 0.01
            
            let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let areaExibicao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLat, deltaLon)
            let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaExibicao)
            map.setRegion(regiao, animated: true)
            
            print(locations.last ?? "none")
            if startDate == nil {
                startDate = Date()
            } else {
                print("Tempo Gasto:", String(format: "%.2fs", Date().timeIntervalSince(startDate)))
            }
            if startLocation == nil {
                startLocation = locations.first
            } else if let location = locations.last {
                traveledDistance += lastLocation.distance(from: location)
                print("Distância Percorrida:",  traveledDistance)
                print("Distância do ponto de partida:", startLocation.distance(from: locations.last!))
                
                labelDistance.text = String(format: "%.2f", traveledDistance)
                
            }
            lastLocation = locations.last
            
            
            CLGeocoder().reverseGeocodeLocation( localizacaoUsuario) { (detalhesLocal, erro) in
                
                if erro == nil {
                    
                    if let dadosLocal = detalhesLocal?.first {
                        
                        var thoroughfare = ""
                        if dadosLocal.thoroughfare != nil {
                            thoroughfare = dadosLocal.thoroughfare!
                        }
                        
                        var subThoroughfare = ""
                        if dadosLocal.subThoroughfare != nil {
                            subThoroughfare = dadosLocal.subThoroughfare!
                        }
                        
                        var locality = ""
                        if dadosLocal.locality != nil {
                            locality = dadosLocal.locality!
                        }
                        
                        var subLocality = ""
                        if dadosLocal.subLocality != nil {
                            subLocality = dadosLocal.subLocality!
                        }
                        
                        var postalCode = ""
                        if dadosLocal.postalCode != nil {
                            postalCode = dadosLocal.postalCode!
                        }
                        
                        var country = ""
                        if dadosLocal.country != nil {
                            country = dadosLocal.country!
                        }
                        
                        var administrativeArea = ""
                        if dadosLocal.administrativeArea != nil {
                            administrativeArea = dadosLocal.administrativeArea!
                        }
                        
                        var subAdministrativeArea = ""
                        if dadosLocal.subAdministrativeArea != nil {
                            subAdministrativeArea = dadosLocal.subAdministrativeArea!
                        }
                        
                        self.labelAddress.text = thoroughfare + " - "
                            + subThoroughfare + " / "
                            + locality
                        
                        print(
                            "Endereço:" + thoroughfare +
                                "\n / Número Aprox:" + subThoroughfare +
                                "\n / Estado:" + locality +
                                "\n / Bairro:" + subLocality +
                                "\n / CEP:" + postalCode +
                                "\n / País:" + country +
                                "\n / Estado:" + administrativeArea +
                            "\n / Região: + \(subAdministrativeArea) \n"
                        )
                    }
                }else{
                    print(erro)
                }
            }
        }
        
        @IBAction func parar(_ sender: UIButton) {
            
            timer.invalidate()
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SegueAposTerminarCorrida" {
                
                
                let destinyViewController = segue.destination as! DadosDaCorridaViewController
                
                destinyViewController.receivedSpeed = labelSpeed.text!
                destinyViewController.receivedCalories = labelCalories.text!
                destinyViewController.receivedTime = labelTime.text!
                destinyViewController.receivedDistance = labelDistance.text!
                destinyViewController.receivedMap = map!
                destinyViewController.receivedTimeDouble = Date().timeIntervalSince(startDate)
                
                
                
                //Passando os dados da primeira, que ja vieram pra essa(segunda) e passando pra terceira
                destinyViewController.receivedHeight2 = receivedHeight
                destinyViewController.receivedWeight2 = receivedWeight
                destinyViewController.receivedAge2 = receivedAge
                destinyViewController.receivedSex2 = receivedSex
                
                
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status != .authorizedWhenInUse {
                
                let alertaController = UIAlertController(title: "Permissão de localização",
                                                         message: "Precisamos ter acesso a sua localização, por favor habilite o GPS",
                                                         preferredStyle: .alert )
                
                let acaoConfiguracoes = UIAlertAction(title: "Configurações", style: .default , handler: { (alertaConfiguracoes) in
                    
                    if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString ) {
                        UIApplication.shared.open( configuracoes as URL )
                    }
                    
                })
                
                let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default , handler: nil )
                
                alertaController.addAction( acaoConfiguracoes )
                alertaController.addAction( acaoCancelar )
                
                present( alertaController , animated: true, completion: nil )
                
            }
        }
        
}

