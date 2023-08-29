//
//  Meaning.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import Foundation

struct Meaning : Identifiable{
    let id = UUID()
    let pos: String
    var definitions: [Definition]
    
    init() {
        pos = "Noun"
        definitions = []
        definitions.append(Definition())
        definitions.append(Definition())
        definitions.append(Definition())
    }
    
    init(entity: MeaningEntity) {
        pos = entity.partOfSpeech
        definitions = entity.definitions.map {
            return Definition(entity: $0)
        }
    }
}
