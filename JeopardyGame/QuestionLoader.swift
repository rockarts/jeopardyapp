//
//  QuestionLoader.swift
//  Jeopardy
//
//  Created by Steven Rockarts on 2020-05-24.
//  Copyright © 2020 figure4software. All rights reserved.
//

import Foundation
import CloudKit
class QuestionLoader : ObservableObject {

    var question:Question2?

    func loadQuestion() {
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase

        let questionId = CKRecord.ID(recordName: "103")
        publicDatabase.fetch(withRecordID: questionId, completionHandler: {
            (record, error) in
            if let error = error {
                debugPrint(error)
            }
            else {
                let question = Question2(category: record!["category"], air_date: record!["air_date"], question: record!["question"], value: record!["value"], answer: record!["answer"], round: record!["round"], show_number: record!["show_number"])
               // Display the fetched record
                debugPrint(question)
                self.question = question
            }
        })


    }

    func saveQuestions() {
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase

        let questions = Bundle.main.decode([Question2].self, from: "questions.json")

        for (index, question) in questions.enumerated() {
            //debugPrint(index)
            //debugPrint(question)
            let questionRecordId = CKRecord.ID(recordName: "\(index + 1)")
            let questionRecord = CKRecord(recordType: "Question", recordID: questionRecordId)
            questionRecord["category"] = (question.category ?? "") as String
            questionRecord["air_date"] = (question.air_date ?? "") as String
            questionRecord["question"] = (question.question ?? "") as String
            questionRecord["value"] = (question.value ?? "") as String
            questionRecord["answer"] = (question.answer ?? "") as String
            questionRecord["round"] = (question.round ?? "") as String
            questionRecord["show_number"] = (question.show_number ?? "") as String

            //21082
            if(index > 20875){
                publicDatabase.save(questionRecord) {
                    (record, error) in
                    if let error = error {
                        debugPrint(index)
                        debugPrint(error)
                        return
                    }

                    // Insert successfully saved record code
                    debugPrint("Question Saved Successfully")
                    debugPrint(index)
                    debugPrint(question)
                }
            }
            if(index == 100000){
                break
            }
        }
    }
}
