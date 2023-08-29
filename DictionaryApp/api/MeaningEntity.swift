//
//  MeaningEntity.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import Foundation

struct MeaningEntity : Codable {
    let partOfSpeech : String
    let definitions : [DefinitionEntity]
}
