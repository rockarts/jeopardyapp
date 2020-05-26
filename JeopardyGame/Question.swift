//
//  Question.swift
//  Jeopardy
//
//  Created by Steven Rockarts on 2020-05-24.
//  Copyright © 2020 figure4software. All rights reserved.
//


import UIKit
import MapKit
import CloudKit
import CoreLocation

struct Question2: Codable {
    let category: String?
    let air_date: String?
    let question: String?
    let value: String?
    let answer: String?
    let round: String?
    let show_number: String?
}

class Question {

  static let recordType = "Question"
  private let recordId: CKRecord.ID

  let id: Int64
  let category: String
  let air_date: String
  let question: String
  let value: String
  let answer: String
  let round: String
  let show_number: String

  //private(set) var notes: [Note]? = nil

  init?(record: CKRecord, database: CKDatabase) {

    recordId = record.recordID
    self.id = record["id"] as! Int64
    self.category = record["category"] as! String
    self.air_date = record["air_date"] as! String
    self.question = record["question"] as! String
    self.value = record["value"] as! String
    self.answer = record["answer"] as! String
    self.round = record["round"] as! String
    self.show_number = record["show_number"] as! String
  }
}

extension Question: Hashable {
  static func == (lhs: Question, rhs: Question) -> Bool {
    return lhs.recordId == rhs.recordId
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
