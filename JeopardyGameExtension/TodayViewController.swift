//
//  TodayViewController.swift
//  JeopardyGameExtension
//
//  Created by Steven Rockarts on 2020-05-25.
//  Copyright © 2020 figure4software. All rights reserved.
//

import UIKit
import NotificationCenter
import CloudKit

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var answerLabel: UILabel!

     let questionIds:[Int] = [104, 105, 10, 103, 11, 110, 111, 113, 127, 12, 13, 14, 15, 16, 17, 2, 23, 24, 25, 26, 27, 29, 3, 37, 38, 39, 4, 40, 41, 43, 44, 45, 46, 5, 52, 53, 54, 57, 58, 59, 6, 60, 62, 63, 64, 65, 7, 72, 73, 75, 8, 81, 82, 83, 88, 89, 9, 94, 95, 96, 97]

    @IBAction func showAnswerButtonTapped(_ sender: Any) {
        answerLabel.isHidden = false
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadQuestion()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        loadQuestion()
        answerLabel.isHidden = false
        completionHandler(NCUpdateResult.newData)
    }

    func loadQuestion() {
        let myContainer = CKContainer.init(identifier: "iCloud.com.stevenrockarts.JeopardyGame")
        let publicDatabase = myContainer.publicCloudDatabase

        let randomQuestion: Int = questionIds.randomElement()!
        let id:String = String(randomQuestion)
        let questionId = CKRecord.ID(recordName: id)

        publicDatabase.fetch(withRecordID: questionId, completionHandler: {
            (record, error) in
            if let error = error {
                debugPrint(error)
            }
            else {
                let question = Question(category: record!["category"], air_date: record!["air_date"], question: record!["question"], value: record!["value"], answer: record!["answer"], round: record!["round"], show_number: record!["show_number"])
               // Display the fetched record
                debugPrint(question)
                DispatchQueue.main.async {
                    self.questionLabel.text = question.question
                    self.answerLabel.text = question.answer
                }
            }
        })
    }
}
