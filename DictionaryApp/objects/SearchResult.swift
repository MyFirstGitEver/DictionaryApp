//
//  SearchResult.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 29/08/2023.
//

import Foundation

struct SearchResult : Identifiable {
    let id = UUID()
    let distance : Int
    let word : String
}
