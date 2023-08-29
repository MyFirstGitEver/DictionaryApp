//
//  DefinitionEntity.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import Foundation

struct DefinitionEntity : Codable {
    let definition : String
    let synonyms : [String]
    let antonyms: [String]
    let example : String?
}
