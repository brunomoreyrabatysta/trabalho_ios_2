//
//  ListViewModelANS.swift
//  trabalho_ios_2
//
//  Created by BRUNO MOREIRA BATISTA on 23/11/23.
//

import Foundation

@MainActor
class ListViewModelANS: ObservableObject {
    private let service: ANSOperadoraServiceable
    
    @Published var listItemModelsANS: [ListItemModelANS] = []
    @Published var searchText: String = ""
    @Published var selectedItemModelANS: ListItemModelANS?
    
    var filteredListItemModelsANS: [ListItemModelANS] {
        searchText.isEmpty ?
        listItemModelsANS :
        listItemModelsANS.filter {
            $0.nome_fantasia.uppercased().contains(searchText.uppercased()) ||
            $0.razao_social.uppercased().contains(searchText.uppercased())
        }
    }
  
    init(service: ANSOperadoraServiceable) {
        self.service = service
    }
    
    func fetchData() {
        Task {
            do {
                self.listItemModelsANS = try await service
                    .fetchOperadoraList(page: 1, size: 25, active: 0, sort: "nome_fantasia")
                    .map{
                        ListItemModelANS(
                            nome_fantasia: $0.nome_fantasia,
                            razao_social: $0.razao_social,
                            cnpj: $0.cnpj,
                            classificacao_sigla: $0.classificacao_sigla,
                            registro_ans: $0.registro_ans,
                            ativa: $0.ativa
                        )
                    }
            } catch {
                print(error)
            }
            
        }
    }
}
