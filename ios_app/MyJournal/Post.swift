//
//  Post.swift
//  MyJournal
//
//  Created by Cesare de Cal on 11/23/19.
//  Copyright © 2019 Cesare de Cal. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let id: Int
    let title, body: String
}
