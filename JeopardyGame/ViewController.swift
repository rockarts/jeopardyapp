//
//  ViewController.swift
//  JeopardyGame
//
//  Created by Steven Rockarts on 2020-05-24.
//  Copyright © 2020 figure4software. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //QuestionLoader().saveQuestions()

        loadQuestion()
    }

    @IBAction func showAnswerTapped(_ sender: Any) {
        answerLabel.isHidden = false
        statsLabel.isHidden = false
    }

    @IBAction func newQuestionTapped(_ sender: Any) {
        answerLabel.isHidden = true
        statsLabel.isHidden = true
        loadQuestion()
    }

    func loadQuestion() {
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase

        let randomQuestion = Int.random(in: 2 ... 5000)
        //let randomQuestion: Int = questionIds.randomElement()!
        let id:String = String(randomQuestion)
        let questionId = CKRecord.ID(recordName: id)

        publicDatabase.fetch(withRecordID: questionId, completionHandler: {
            (record, error) in
            if let error = error {
                debugPrint(error)
                if(error.localizedDescription.contains("Record not found")) {
                    self.loadQuestion()
                }
            }
            else {
                let question = Question2(category: record!["category"], air_date: record!["air_date"], question: record!["question"], value: record!["value"], answer: record!["answer"], round: record!["round"], show_number: record!["show_number"])
               // Display the fetched record
                debugPrint(question)
                DispatchQueue.main.async {
                    self.questionLabel.text = question.question
                    self.answerLabel.text = question.answer
                    self.categoryLabel.text = question.category
                    self.valueLabel.text = question.value
                    self.statsLabel.text = "Round: \(question.round!) \nAir Date: \(question.air_date!) \nShow Number: \(question.show_number!)"
                }
            }
        })
    }
}
