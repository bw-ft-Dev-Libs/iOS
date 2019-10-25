//
//  CreateLibViewController.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

enum PartsOfSpeech: String {
    case noun = "NOUN"
    case nounPerson = "NOUN(PERSON)"
    case pronoun = "PRONOUN"
    case adjective = "ADJECTIVE"
    case verb = "VERB"
    case adverb = "ADVERB"
}

class CreateLibViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var wordTypeView: UIView!
    @IBOutlet weak var wordTypeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var partOfSpeechTextField: UITextField!
    
    // MARK: Properties
    
    var duration: Double { return 0.25 }
    var isDoneWithLib: Bool = false
    
    var partsOfSpeech: [PartsOfSpeech] = [.nounPerson, .noun, .verb, .adverb, .nounPerson, .adjective, .noun]
    
    var nounPerson = ""
    var noun = ""
    var verb = ""
    var adverb = ""
    var nounPerson2 = ""
    var adjective = ""
    var noun2 = ""
    
    var lib = ""
    
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    // MARK: IBActions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if isDoneWithLib == false {
            if count < partsOfSpeech.count {
                
                switch count {
                case 0:
                    
                    guard let text = partOfSpeechTextField.text, !text.isEmpty else {return}
                    nounPerson = text
                    
                    self.animateView()
                    
                    count += 1
                    wordTypeLabel.text = partsOfSpeech[1].rawValue
                    
                case 1:
                    
                    guard let text = partOfSpeechTextField.text, !text.isEmpty else {return}
                    noun = text
                    
                    self.animateView()
                    
                    count += 1
                    wordTypeLabel.text = partsOfSpeech[2].rawValue
                    
                case 2:
                    
                    guard let text = partOfSpeechTextField.text, !text.isEmpty else {return}
                    verb = text
                    
                    self.animateView()
                    
                    count += 1
                    wordTypeLabel.text = partsOfSpeech[3].rawValue
                    
                case 3:
                    
                    guard let text = partOfSpeechTextField.text, !text.isEmpty else {return}
                    
                    adverb = text
                    
                    self.animateView()
                    
                    count += 1
                    wordTypeLabel.text = partsOfSpeech[4].rawValue
                    
                case 4:
                    
                    guard let text = partOfSpeechTextField.text, !text.isEmpty else {return}
                    nounPerson2 = text
                    
                    self.animateView()
                    
                    count += 1
                    wordTypeLabel.text = partsOfSpeech[5].rawValue
                    
                case 5:
                    
                    guard let text = partOfSpeechTextField.text, !text.isEmpty else {return}
                    adjective = text
                    
                    self.animateView()
                    
                    count += 1
                    wordTypeLabel.text = partsOfSpeech[6].rawValue
                    
                case 6:
                    
                    guard let text = partOfSpeechTextField.text, !text.isEmpty else {return}
                    noun2 = text
                    
                    self.animateView()
                    
                    isDoneWithLib = true
                    
                    let lib = "On a cold December morning in 2009, my \(nounPerson) asked me to implement a new feature. He wanted his \(noun) to \(verb) \(adverb). I said no worries \(nounPerson2), I can have that done in a week. Just this year (2019) I called my \(adjective) \(noun2) and told him there was now a cocoaPod for that. Sorry sir!"
                    
                    self.lib = lib
                default:
                    break
                }
            }
        } else {
            nextButton.setTitle("VIEW LIB", for: .normal)
            performSegue(withIdentifier: "NewLibDetailSegue", sender: self)
        }
    }
    
    // MARK: Private Funcs
    
    private func moveOff(view: UIView) {
        view.center.y -= 400
    }
    
    private func moveOn(view: UIView) {
        view.center.y += 400
    }
    
    private func animateView() {
        UIView.animate(withDuration: duration, delay: 0, options: .autoreverse, animations: {
            self.moveOff(view: self.wordTypeView)
            self.partOfSpeechTextField.text = ""
            
        }) { (_) in
            self.moveOn(view: self.wordTypeView)
        }
    }
    
    private func setViews() {
        
        saveButton.isHidden = true
        
        count = 0
        
        wordTypeLabel.text = partsOfSpeech[0].rawValue
        
        wordTypeView.layer.cornerRadius = 6
        
        nextButton.layer.cornerRadius = 6
        
        wordTypeView.center = CGPoint(x: view.frame.width/2, y: -view.frame.height/2)
        
        UIView.animate(withDuration: duration, delay: 0, options: .autoreverse, animations: {
            self.moveOn(view: self.wordTypeView)})
        
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewLibDetailSegue" {
            guard let destinationVC = segue.destination as? LibDetailViewController  else {return}
            destinationVC.lib = lib
        }
    }
}
