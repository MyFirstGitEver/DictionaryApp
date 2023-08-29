//
//  WordContext.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import Foundation

struct WordContext : Identifiable {
    let id = UUID()

    let phonetic : String
    let audioLink : String
    var meanings : [Meaning]
    
    init() {
        phonetic = "/ði/"
        audioLink = "https://api.dictionaryapi.dev/media/pronunciations/en/the-ca-unstressed.mp3"
        meanings = []
        
        meanings.append(Meaning())
        meanings.append(Meaning())
        meanings.append(Meaning())
    }
    
    init(entity: ContextEntity) {
        var text = ""
        var audio = ""

        // find audio link and phontic
        for phonetic in entity.phonetics {
            if text != "" && audio != "" {
                break
            }
            
            if phonetic.text != "" {
                text = phonetic.text
            }
            
            if phonetic.audio != "" {
                audio = phonetic.audio
            }
        }
        
        self.phonetic = text
        self.audioLink = audio
        meanings = entity.meanings.map {
            return Meaning(entity: $0)
        }
    }
}
