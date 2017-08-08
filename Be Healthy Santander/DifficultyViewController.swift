//
//  DifficultyViewController.swift
//  PerguntasERespostas
//
//  Created by Renato on 22/03/17.
//  Copyright © 2017 Renato. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {
    @IBOutlet weak var buttonChooseEasy: UIButton!
    @IBOutlet weak var buttonChooseMedium: UIButton!
    @IBOutlet weak var labelChooseYourDifficulty: UILabel!
    @IBOutlet weak var buttonChooseHard: UIButton!
    @IBOutlet weak var buttonImageEasy: UIButton!
    @IBOutlet weak var buttonImageNormal: UIButton!
    @IBOutlet weak var buttonImageHard: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonChooseEasy.layer.cornerRadius = 15
        buttonChooseMedium.layer.cornerRadius = 15
        buttonChooseHard.layer.cornerRadius = 15
        labelChooseYourDifficulty.layer.cornerRadius = 15

        }
   

}
