//
//  ContentView.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var searchWord: String = ""
    @State private var vocabulary : [String] = []
    @State private var filteredData: [SearchResult] = []
    @State private var showsSearchBar = false
    
    var body: some View {
        NavigationStack {
            VStack {
                topDisplay
                vocabList
            }
        }
    }
    
    var topDisplay : some View {
        ZStack {
            VStack {
                HStack {
                    Text("Từ điển Tiếng anh")
                        .bold()
                        .font(.system(size: 25))
                        .offset(y: showsSearchBar ? -300 : 0)
                        .opacity(showsSearchBar ? 0.0 : 1.0)
                }
                Rectangle()
                    .frame(height: 0.7)
                    .background(.gray)
            }
            
            TextField("Tìm kiếm từ. A, an, the, .etc", text: $searchWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .padding([.bottom], 10)
                .opacity(showsSearchBar ? 1.0 : 0.0)
                .onChange(of: searchWord) { newValue in
                    DispatchQueue.global(qos: .userInitiated).async {
                        filteredData.removeAll()
                        
                        if newValue == "" {
                            filteredData.append(contentsOf: vocabulary.map {
                                SearchResult(distance: 0, word: $0)
                            })
                            return
                        }
                        
                        for word in vocabulary {
                            let distance = Solution().minDistance(
                                word, newValue)
                            
                            if distance < 3 {
                                filteredData.append(SearchResult(
                                    distance: distance, word: word))
                            }
                        }
                        
                        filteredData.sort(by:  {
                            if $0.distance != $1.distance {
                                return $0.distance < $1.distance
                            }
                            
                            return $0.word < $1.word
                        })
                    }
                }
            
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.spring()) {
                        showsSearchBar.toggle()
                    }
                }) {
                    Image(systemName: showsSearchBar ? "xmark.circle.fill" : "magnifyingglass.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding([.trailing, .bottom], 10)
                }.foregroundColor(.gray)
            }
        }
    }
    
    var vocabList : some View {
        ScrollView {
            LazyVStack {
                ForEach(filteredData) { result in
                    buildVocabView(vocab: result.word)
                }
            }
            .onAppear {
                if vocabulary.count == 0 {
                    vocabulary.append(contentsOf: getVocab())
                    filteredData.append(contentsOf: vocabulary.map { SearchResult(distance: 0, word: $0) })
                }
            }
        }
    }
    
    func getVocab() -> [String]{
        let url = Bundle.main.url(forResource: "oxford_3000", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let products = try? decoder.decode([String].self, from: data)
        return products!
    }
    
    func buildVocabView(vocab: String) -> some View {
        VStack {
            HStack {
                Image(systemName: "doc.fill")
                    .resizable()
                    .frame(width: 30, height: 40)
                    .padding([.leading], 10)
                Text(vocab)
                Spacer()
                NavigationLink {
                    WordView(word: vocab)
                } label: {
                    Image(systemName: "info.circle.fill")
                        .padding([.trailing], 10)
                        .foregroundColor(.blue)
                }
            }
            Divider()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
