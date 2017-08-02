//
//  LembreteAguaViewController.swift
//  Be Healthy Santander
//
//  Created by Flex Administrador on 5/10/17.
//  Copyright © 2017 Flex Administrador. All rights reserved.
//

import UIKit
import AVFoundation

class LembreteAguaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var pickerViewWaterAlarm: UIPickerView!
    @IBOutlet weak var buttonStartTimer: UIButton!
    @IBOutlet weak var stopTimer: UIButton!
    @IBOutlet weak var labelSugestao: UILabel!
    
    // MARK: - Propriedades
    
    // Arrays que usaremos para popular o picker
    var arrayHours : [String] = []
    var arrayMinutes : [String] = []
    var arraySeconds : [String] = []
    
    // Variável que armazenará o total de segundos
    var  totalSeconds : Float = 0.0
    
    // Variável que armazenará os seguntos atuais
    var currentSeconds : Float = 0.0
    
    // Temporizador que tratará o evento de alteração do picker
    var timer : Timer!
    
    var player = AVAudioPlayer()
    
    // Variável recebida da view Anterior
    
    var pesoRecebido: Double!
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("PESOOO \(pesoRecebido!)/n")
        
        let quantidadeAgua = (35 * pesoRecebido)
        
        let quantidadeCopos = (quantidadeAgua / 250)
        
        let numeroDeVezesBeber = (quantidadeCopos / 0.24)
        
        let numeroArredondado = String(format:"%.1f", numeroDeVezesBeber)
        
        
        labelSugestao.text = "É recomendado que você beba um copo de 250 ml a cada \(numeroArredondado) minutos"
        
        
        if let path = Bundle.main.path(forResource: "alarme", ofType: "mp3"){
            let url = URL(fileURLWithPath: path)
            
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                
            } catch {
                print("Erro ao executar o som!")
            }
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
        stopTimer.isHidden = true
        self.setup()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Métodos
    
    func loadingArrays() {
        
        
        // Valores para as horas
        for i in 0...24{
            
            self.arrayHours += ["\(i)"]
        }
        // Valores para os minutos
        for i in 0...59 {
            self.arrayMinutes += ["\(i)"]
        }
        // Valores para os segundos
        for i in 0...59 {
            self.arraySeconds += ["\(i)"]
        }
    }
    
    func setup() {
        
        self.pickerViewWaterAlarm.dataSource = self
        self.pickerViewWaterAlarm.delegate = self
        self.loadingArrays()
    }
    
    func tocarAlarme () {
        
        if(self.pickerViewWaterAlarm.selectedRow(inComponent: 2) == 0) && self.pickerViewWaterAlarm.selectedRow(inComponent: 1) == 0 && self.pickerViewWaterAlarm.selectedRow(inComponent: 0) == 0 {
            
            player.play()
            print ("tocando alarme!")
            buttonStartTimer.isHidden = false
            stopTimer.isHidden = true
        }else{
            print ("erro ao executar som")
            buttonStartTimer.isHidden = false
            stopTimer.isHidden = true
        }
    }
    
    func verifySeconds() {
        
        
        // Verificando se o contador de segundos já chegou a seu limite
        
        if(self.pickerViewWaterAlarm.selectedRow(inComponent: 2) == 0){
            
            // Caso a seleção no picker de segundos seja 0 ele precisa voltar para o 59
            
            self.pickerViewWaterAlarm.selectRow(self.arraySeconds.count - 1, inComponent: 2, animated: true)
            
        }else{
            
            // Caso ele não esteja
            
            // O picker precisa voltar um na seleção
            
            self.pickerViewWaterAlarm.selectRow(self.pickerViewWaterAlarm.selectedRow(inComponent: 2) - 1, inComponent: 2, animated: true)
            
        }
        
    }
    
    func verifyMinutes(){
        
        
        // Verificando se o contador de segundos é igual a zero e o contador de minutos é diferente de zero.
        
        if(self.pickerViewWaterAlarm.selectedRow(inComponent: 2) == 0 && self.pickerViewWaterAlarm.selectedRow(inComponent: 1) != 0){
            
            
            // Caso seja decrescemos 1 no minuto
            self.pickerViewWaterAlarm.selectRow(self.pickerViewWaterAlarm.selectedRow(inComponent: 1) - 1, inComponent: 1, animated: true)
            
        }else if (self.pickerViewWaterAlarm.selectedRow(inComponent: 1) == 0) && (self.pickerViewWaterAlarm.selectedRow(inComponent: 2) == 0){
            
            // Caso ambos forem igual a zero ele volta pra 59
            
            self.pickerViewWaterAlarm.selectRow(self.arrayMinutes.count - 1, inComponent: 1, animated: true)
        }
        
    }
    
    func verifyHours(){
        
        
        // Verificando a cndição da hora
        
        if(self.pickerViewWaterAlarm.selectedRow(inComponent: 2) == 0) && self.pickerViewWaterAlarm.selectedRow(inComponent: 1) == 0{
            
            self.pickerViewWaterAlarm.selectRow(self.pickerViewWaterAlarm.selectedRow(inComponent: 0) - 1, inComponent: 0, animated: true)
            
            
        }
    }
    

    
    func invalidateTimer() {
        
        if(self.currentSeconds <= 0){
            player.play()
            self.timer.invalidate()
            self.pickerViewWaterAlarm.isUserInteractionEnabled = true
            self.buttonStartTimer.isHidden = false
        }
    }
    // MARK: - Actions
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        if (self.pickerViewWaterAlarm.selectedRow(inComponent: 0) == 0) &&
            (self.pickerViewWaterAlarm.selectedRow(inComponent: 1) == 0) &&
            (self.pickerViewWaterAlarm.selectedRow(inComponent: 2) == 0)
            
        {labelSugestao.text = "O alarme já está parado!"
            stopTimer.isHidden = true
            buttonStartTimer.isHidden = false

        }
        
        else
        { labelSugestao.text = ""
        // Criando a variável para receber as horas
        let hours = self.arrayHours[self.pickerViewWaterAlarm.selectedRow(inComponent: 0)]
        
        // Criando a variável para receber os minutos
        let minutes = self.arrayMinutes[self.pickerViewWaterAlarm.selectedRow(inComponent: 1)]
        
        // Criando a variável que receberá os segundos
        let seconds = self.arraySeconds[self.pickerViewWaterAlarm.selectedRow(inComponent: 2)]
        
        
        // Juntando os valores e convertendo em segundos
        
        self.totalSeconds = Float(hours)! * 3600 + Float(minutes)! * 60 + Float(seconds)!
        
        print("Total segundos: \(self.totalSeconds)")
        
        
        // Igualando os segundo atuais com o total segundos
        self.currentSeconds = self.totalSeconds
        
        // ---------- Timer -------
        
        // Depois dos segundos resgatados disparamos o timer desde que o tempo seja maior que zero.
        
        
        if(self.totalSeconds > 0){
            
            
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LembreteAguaViewController.metodoDisparadoPeloTimer), userInfo: nil, repeats: true)
            
            
            // Tiramos a interação do picker e escondemos o botão
            self.pickerViewWaterAlarm.isUserInteractionEnabled = false
            self.buttonStartTimer.isHidden = true
            stopTimer.isHidden = false
            
            }}
        
        player.stop()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.selectedRow(inComponent: 0) == pickerViewWaterAlarm.selectedRow(inComponent: 0) {
            print("Linha Selecionada dos segundos: \(row)")
            var linhaEscolhidaSegundos = (arraySeconds[row])
            
        }
        else if pickerView.selectedRow(inComponent: 1) == pickerViewWaterAlarm.selectedRow(inComponent: 1) {
            print("Linha Selecionada dos minutos: \(row)")
            var linhaEscolhidaMinutos = (arrayMinutes[row])
            
            
        }
        else{
            print("Linha Selecionada das horas: \(row)")
            var linhaEscolhidaHoras = (self.arrayHours[row])
        }
        
    }
    
    
    @IBAction func stopTimer(_ sender: UIButton) {
        
        
        if (self.pickerViewWaterAlarm.selectedRow(inComponent: 0) == 0) &&
            (self.pickerViewWaterAlarm.selectedRow(inComponent: 1) == 0) &&
            (self.pickerViewWaterAlarm.selectedRow(inComponent: 2) == 0)
        
        {//labelSugestao.text = "O alarme já está parado!"
            stopTimer.isHidden = true
            buttonStartTimer.isHidden = false
            player.stop()
            
        }else{
            
            self.pickerViewWaterAlarm.selectRow(0, inComponent: 0, animated: true)
            self.pickerViewWaterAlarm.selectRow(0, inComponent: 1, animated: true)
            self.pickerViewWaterAlarm.selectRow(0, inComponent: 2, animated: true)
            
            timer.invalidate()
            player.stop()
            stopTimer.isHidden = true
            buttonStartTimer.isHidden = false
            self.pickerViewWaterAlarm.isUserInteractionEnabled = true
            
        }
        
    }
    
    func metodoDisparadoPeloTimer() {
        
        // Diminuindo os segundos (A cada um segundo)
        
        self.currentSeconds = self.currentSeconds - 1.0
        
        // Verificamos se o timer precisa ser parado
        invalidateTimer()
        
        // Método que verifica as horas
        self.verifyHours()
        
        // Método que verifica os minutos
        self.verifyMinutes()
        
        // Método que verifica os segundos
        self.verifySeconds()
        
        //
        
        print("Segundos atuais: \(self.currentSeconds)")
    }
    
    
    // MARK: - Métodos de UIPickerViewDatasource
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerView {
            
            switch component {
            case 0:
                return self.arrayHours.count
            case 1:
                return self.arrayMinutes.count
            case 2:
                return self.arraySeconds.count
            default:
                return 0
            }}
        else
        {
            switch component {
            case 0:
                return self.arrayHours.count
            case 1:
                return self.arrayMinutes.count
            case 2:
                return self.arraySeconds.count
            default:
                return 0
            }
        }
    }
    // MARK: - Métodos de UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerView {
            
            
            switch component {
            case 0:
                return "\(self.arrayHours[row]) H"
            case 1:
                return "\(self.arrayMinutes[row]) min"
            case 2:
                return "\(self.arraySeconds[row]) seg"
                
            default:
                return ""
            }
        }
            
        else{
            
            
            switch component {
            case 0:
                return "\(self.arrayHours[row]) H"
            case 1:
                return "\(self.arrayMinutes[row]) min"
            case 2:
                return "\(self.arraySeconds[row]) seg"
                
            default:
                return ""
            }
            
            
        }
    }
    
    
}
