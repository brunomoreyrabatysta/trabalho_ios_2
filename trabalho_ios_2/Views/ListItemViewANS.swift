//
//  ListItemViewANS.swift
//  trabalho_ios_2
//
//  Created by BRUNO MOREIRA BATISTA on 23/11/23.
//

import SwiftUI

struct ListItemModelANS: Identifiable, Hashable {
    let id = UUID()
    let nome_fantasia: String
    let razao_social: String
    let cnpj: String
    let classificacao_sigla: String
    let registro_ans: String
    let ativa: Bool
}

struct ListItemViewANS: View {
    private let nome_fantasia: String
    private let razao_social: String
    private let cnpj: String
    private let registro_ans: String
    private let classificacao_sigla: String
    private let ativa: Bool
    private let imageURL: URL?
    
    init(model: ListItemModelANS) {
        self.nome_fantasia = model.nome_fantasia
        self.razao_social = model.razao_social
        self.cnpj = model.cnpj
        self.registro_ans = model.registro_ans
        self.classificacao_sigla = model.classificacao_sigla
        self.ativa = model.ativa
        self.imageURL = nil
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    @unknown default:
                        fatalError()
                }
            }
            
            VStack(alignment: .leading) {
                Text(nome_fantasia)
                    .font(.headline)
                Text(razao_social)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
