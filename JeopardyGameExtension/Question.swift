//
//  Question.swift
//  JeopardyGameExtension
//
//  Created by Steven Rockarts on 2020-05-25.
//  Copyright © 2020 figure4software. All rights reserved.
//

import Foundation

struct Question: Codable {
    let category: String?
    let air_date: String?
    let question: String?
    let value: String?
    let answer: String?
    let round: String?
    let show_number: String?
}
