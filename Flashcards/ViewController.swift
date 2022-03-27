//
//  ViewController.swift
//  Flashcards
//
//  Created by Leann Abellanosa on 2/22/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.5
        
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
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Norway?", answer: "Oslo")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        questionLabel.isHidden = false
        let flashcard = Flashcard(question: question, answer: answer)
        flashcards.append(flashcard)
        
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (questionLabel.isHidden == true) {
            questionLabel.isHidden = false;
        } else {
            questionLabel.isHidden = true
        }
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
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
            
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
            currentIndex = currentIndex - 1
            updateLabels()
            updateNextPrevButtons()
    }
        
    @IBAction func didTapOnNext(_ sender: Any) {
            currentIndex = currentIndex + 1
            updateLabels()
            updateNextPrevButtons()
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
            
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            questionLabel.isHidden = false
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer1 = answerLabel.text
        }
    }
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = flashcards.map { (card) -> [String: String?] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map{ (dictionary) -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
}
