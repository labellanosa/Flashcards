//
//  ViewController.swift
//  Flashcards
//
//  Created by Leann Abellanosa on 2/22/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        questionLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
           
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
           
        answerOne.layer.cornerRadius = 15.0
        answerOne.layer.borderWidth = 3.0
        answerOne.layer.borderColor = #colorLiteral(red: 0.2979514897, green: 0.7207366824, blue: 0.4462061524, alpha: 1)
           
        answerTwo.layer.cornerRadius = 15.0
        answerTwo.layer.borderWidth = 3.0
        answerTwo.layer.borderColor = #colorLiteral(red: 0.2979514897, green: 0.7207366824, blue: 0.4462061524, alpha: 1)
           
        answerThree.layer.cornerRadius = 15.0
        answerThree.layer.borderWidth = 3.0
        answerThree.layer.borderColor = #colorLiteral(red: 0.2979514897, green: 0.7207366824, blue: 0.4462061524, alpha: 1)
           
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer1 = answerOne.currentTitle
            creationController.initialAnswer2 = answerTwo.currentTitle
            creationController.initialAnswer3 = answerThree.currentTitle
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        questionLabel.isHidden = !questionLabel.isHidden
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        answerOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        questionLabel.isHidden = true
        }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        answerThree.isHidden = true
    }
    
    func updateFlashcard(question: String, answer1: String, answer2: String, answer3: String) {
        questionLabel.text = question
        answerLabel.text = answer2
        
        answerOne.setTitle(answer1, for: .normal)
        answerTwo.setTitle(answer2, for: .normal)
        answerThree.setTitle(answer3, for: .normal)
    }
}
