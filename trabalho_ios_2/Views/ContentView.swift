//
//  ContentView.swift
//  trabalho_ios_2
//
//  Created by BRUNO MOREIRA BATISTA on 21/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var listViewModelANS: ListViewModelANS = .init(service: ANSOperadoraService()
    )
    
    var body: some View {
        ListViewANS(viewModel: listViewModelANS)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
