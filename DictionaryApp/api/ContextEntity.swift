//
//  ContextEntity.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import Foundation


struct ContextEntity : Codable {
    let word : String
    let phonetics: [PhoneticEntity]
    let meanings: [MeaningEntity]
}
