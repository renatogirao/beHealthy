//
//  CalculoIMCViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 5/10/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

import UIKit

class CalculoIMCViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerViewAge: UIPickerView!
    @IBOutlet weak var pickerViewWeight: UIPickerView!
    @IBOutlet weak var pickerViewHeight: UIPickerView!
    @IBOutlet weak var labelResultyIMC: UILabel!
    
    var userWeight: Double = 0.0
    var userAge: Double = 0.0
    var userHeight: Double = 0.0
    var IMC: Double = 0.0
    
    
    let arrayYears : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99]
    
    let arrayHeight: [Int] = [50, 51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230]
    
    let arrayWeight: [Int] = [30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,2382,9240,41,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerViewWeight.delegate = self
        self.pickerViewWeight.dataSource = self
        
        self.pickerViewHeight.delegate = self
        self.pickerViewHeight.dataSource = self
        
        self.pickerViewAge.delegate = self
        self.pickerViewAge.dataSource = self
    
    }
    
    @IBAction func calculateIMC(_ sender: UIButton) {
        
        let heightUserInMeters: Double = userHeight * 0.010
        
        IMC = userWeight / (heightUserInMeters * heightUserInMeters)
        
            if IMC < 17 {
            labelResultyIMC.text = String(format: "Seu IMC é %.2f \n Vocé está muito abaixo do peso", IMC)
        }
        if IMC > 17 && IMC < 18.49 {
            labelResultyIMC.text = String(format: "Seu IMC é %.2f \n Vocé está abaixo do peso", IMC)
        }
        if IMC > 18.5 && IMC < 24.49 {
            labelResultyIMC.text = String(format: "Seu IMC é %.2f \n Você está no peso normal", IMC)
        }
        if IMC > 25 && IMC < 29.99 {
            labelResultyIMC.text = String(format: "Seu IMC é %.2f \n Você está acima do peso", IMC)
        }
        if IMC > 30 && IMC < 34.99 {
            labelResultyIMC.text = String(format: "Seu IMC é %.2f \n Você está com obesidade - nível I", IMC)
        }
        if IMC > 35 && IMC < 39.99 {
            labelResultyIMC.text = String(format: "Seu IMC é %.2f \n Você está com obesidade - nível II", IMC)
        }
        if IMC > 40 {
            labelResultyIMC.text = String(format: "Seu IMC é %.2f \n Você está com obesidade - Nível III", IMC)
        }
        
    }
    @IBAction func calculateNewIMC(_ sender: UIButton) {
        
        self.pickerViewAge.selectRow(29, inComponent: 0, animated: true)
        self.pickerViewHeight.selectRow(100, inComponent: 0, animated: true)
        self.pickerViewWeight.selectRow(20, inComponent: 0, animated: true)
        labelResultyIMC.text = ""
    }
    
    // MARK: - Métodos de UIPickerViewDataSource
    
    // Método que define a quantidade de components (colunas) do pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView == pickerViewHeight {
            
            return 1
        }
        else if pickerView == pickerViewWeight {
            return 1
            
        } else {
            return 1
        }
    }
    
    // Método que define a quantidade de linhas para cada component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerViewHeight
        {
            return self.arrayHeight.count
        }
        else if pickerView == pickerViewWeight
        {
            return self.arrayWeight.count
        }
        else
        {
            return self.arrayYears.count
        }
    }
    
    
    // MARK: - Métodos de UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == pickerViewWeight {
            
            return String("\(arrayWeight[row]) Kg")
        }
        if pickerView == pickerViewHeight {
            return String("\(arrayHeight[row]) Cm")
            
        }else{
            if pickerView == pickerViewAge && arrayYears[row] == 1 {
                return String ("\(arrayYears[row]) ano")
            }else{
                return String("\(arrayYears[row]) anos")
                
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == pickerViewWeight {
            print("Linha Selecionada: \(row)")
            userWeight = Double(arrayWeight[row])
            print ("O peso do usuário é: \(userWeight)")
        }
        else if pickerView == pickerViewHeight {
            print("Linha Selecionada: \(row)")
            userHeight = Double(arrayHeight[row])
            print ("Altura do usuário: \(userHeight)")
        }
        else{
            print("Linha Selecionada: \(row)")
            userAge = Double(arrayYears[row])
            print ("Idade do usuário:\(userAge)")
        }
        
        
    }
}
