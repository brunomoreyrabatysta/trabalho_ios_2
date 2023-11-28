//
//  ListDetailViewANS.swift
//  trabalho_ios_2
//
//  Created by BRUNO MOREIRA BATISTA on 23/11/23.
//

import SwiftUI

struct ListDetailViewANS: View {
    private let item: ListItemModelANS
    
    @State var isSheetPresented = false
    
    init(item: ListItemModelANS) {
        self.item = item
    }
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    VStack {
                        Text(item.nome_fantasia)
                            .font(.title3)
                            .foregroundColor(.black)
                        
                        Text("CNPJ.: " + item.cnpj)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Text("Razão Social.: " + item.razao_social)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Text("Registro ANS.: " + item.registro_ans)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Text("Classificação sigla.: " + item.classificacao_sigla)
                            .font(.headline)
                            .foregroundColor(.black)
                    
                        Text("Ativo.: " + (item.ativa ? "Sim" : "Não"))
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .background(Color.white)
                }
                
                
                
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            Text("Sheet Presented")
        }
    }
}

struct ListDetailViewANS_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailViewANS(
            item: .init(
                nome_fantasia: "Nome Fantasia",
                razao_social: "Razao Social",
                cnpj: "CNPJ",
                classificacao_sigla: "Classificacao Sigla",
                registro_ans: "Registro ANS",
                ativa: true))
    }
}
