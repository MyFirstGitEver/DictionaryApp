//
//  WordView.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import SwiftUI
import AVFoundation

struct WordView: View {
    @State var player : AVPlayer? = nil
    @Environment(\.dismiss) var dismiss
    
    @State private var contexts : [WordContext] = []
    let word: String
    
    var body: some View {
        VStack {
            topDisplay
            Divider()
            phoneticPart
            
            TabView {
                ForEach(contexts) { context in
                    ScrollView {
                        VStack(spacing: 30) {
                            ForEach(context.meanings) { meaning in
                                buildMeaningView(meaning: meaning)
                            }
                        }
                    }
                }
            }.tabViewStyle(PageTabViewStyle())
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            APICaller.callWithResult(urlPath: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)", methodName: "GET", onComplete: { data, response, err in
                do {
                    let contexts = try DataConverter<[ContextEntity]>.fromData(data!)
                    let mappedContexts = contexts.map {
                        return WordContext(entity: $0)
                    }
                    
                    self.contexts.append(contentsOf: mappedContexts)
                    
                }
                catch let err {
                    print(err.localizedDescription)
                }
            })
            
        }
    }
    
    var topDisplay: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 18, height: 25)
                    .padding([.leading], 10)
                    .foregroundColor(.black)
            }
            
            Text("#\(word)")
                .font(.system(size: 30))
            Spacer()
        }
    }
    
    var phoneticPart: some View {
        HStack {
            Text("Read as \"\(contexts.count == 0 ? "" : contexts[0].phonetic)\"")
                .padding([.leading], 10)
                .font(.system(size: 20))
            Spacer()
            Button(action: {
                guard let url = URL(string: contexts[0].audioLink) else { return }
                let playerItem = AVPlayerItem(url: url)
                player = AVPlayer(playerItem: playerItem)
                player?.play()
            }) {
                Image(systemName: "waveform.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding([.trailing], 10)
            }
        }
    }
    
    func buildMeaningView(meaning: Meaning) -> some View {
        VStack(spacing: 20) {
            HStack {
                Text(meaning.pos)
                    .bold()
                    .font(.system(size: 30))
                    .padding([.leading], 15)
                
                Spacer()
            }
            
            ForEach(meaning.definitions) { definition in
                buildDefinitionView(definition: definition)
            }
        }
    }
    
    func buildDefinitionView(definition: Definition) -> some View {
        VStack(alignment: .leading){
            Text("- \(definition.content)")
                .padding([.leading], 15)
            HStack {
                Text("Example:")
                    .bold()
                    .foregroundColor(.orange)
                    .padding([.leading], 10)
                Spacer()
            }
            Text(definition.example)
                .padding([.leading], 20)
            
            HStack {
                Text("Synonnyms:")
                    .bold()
                    .foregroundColor(.green)
                    .padding([.leading], 10)
                Spacer()
            }
            Text(definition.synonnyms.joined(separator: ","))
                .padding([.leading], 20)
            
            HStack {
                Text("Antonyms:")
                    .bold()
                    .foregroundColor(.red)
                    .padding([.leading], 10)
                Spacer()
            }
            Text(definition.antonyms.joined(separator: ","))
                .padding([.leading], 20)
            Divider()
        }
        .font(.system(size: 20))
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        WordView(word: "The")
    }
}
