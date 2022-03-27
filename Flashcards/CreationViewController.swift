//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Leann Abellanosa on 3/12/22.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    var initialQuestion: String?
    var initialAnswer1: String?
    var initialAnswer2: String?
    var initialAnswer3: String?
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var extraAnswer1: UITextField!
    @IBOutlet weak var extraAnswer2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer1
        extraAnswer1.text = initialAnswer2
        extraAnswer2.text = initialAnswer3
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let answerOne = extraAnswer1.text
        let answerTwo = extraAnswer2.text
        
        let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer.", preferredStyle: UIAlertController.Style .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        if questionText == nil || questionText!.isEmpty || answerText == nil || answerText!.isEmpty {
            present(alert, animated: true)
            
        } else {
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        }

        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
