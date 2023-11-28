//
//  ListViewANS.swift
//  trabalho_ios_2
//
//  Created by BRUNO MOREIRA BATISTA on 23/11/23.
//

import SwiftUI

struct ListViewANS: View {
    @ObservedObject var viewModel: ListViewModelANS
    
    init(viewModel: ListViewModelANS) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredListItemModelsANS) {item in
                NavigationLink(value: item) {
                    ListItemViewANS(model: item)
                }
                
            }
            .onAppear {
                viewModel.fetchData()
            }
            .navigationTitle("Plano Saúde")
            .navigationDestination(for: ListItemModelANS.self) {item in
                ListDetailViewANS(item: item)
            }
            .searchable(text: $viewModel.searchText)
            
        }
    }
}

struct ListViewANS_Previews: PreviewProvider {
    static var previews: some View {
        ListViewANS(viewModel: ListViewModelANS(service: ANSOperadoraServicePreview()))
    }
}

fileprivate final class ANSOperadoraServicePreview: ANSOperadoraServiceable {
    func fetchOperadoraList(page: Int, size: Int, active: Int, sort: String) async throws -> [ANSOperadoraSuplementar] {
        let contentsString = """
        [
            {
                "registro_ans": "321338",
                "cnpj":"84638345000165",
                "razao_social":"AMERON - ASSISTÊNCIA MÉDICA RONDÔNI S/A.",
                "nome_fantasia":"AMERON",
                "classificacao_sigla":"MEGRP",
                "ativa":true
            },
            {
                "registro_ans":"422461",
                "cnpj":"38046343000160",
                "razao_social":"CLUBE SILVER ADMINISTRADORA DE PLANOS DE SAUDE LTDA",
                "nome_fantasia":"AMESAÚDE",
                "classificacao_sigla":"ADMBN",
                "ativa":true
            },
            {
                "registro_ans":"304531",
                "cnpj":"17143876000190",
                "razao_social":"AME-ASSISTÊNCIA MÉDICA A EMPRESAS LTDA",
                "nome_fantasia":"AME-SISTEMA DE SAÚDE 24 HORAS",
                "classificacao_sigla":"MEGRP",
                "ativa":true
            },
            {
                "registro_ans":"416282",
                "cnpj":"07893499000152",
                "razao_social":"E.X.M BRASIL SAÚDE LTDA",
                "nome_fantasia":"AMEX SAÚDE",
                "classificacao_sigla":"MEGRP",
                "ativa":true
            },
            {
                registro_ans":"418587",
                "cnpj":"15131148000132",
                "razao_social":"AMHA SAUDE S/A",
                "nome_fantasia":"AMHA SAUDE S/A",
                "classificacao_sigla":"MEGRP",
                "ativa":true
            }
        ]
        """

        guard let jsonData = contentsString.data(using: .utf8) else {
            return []
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([ANSOperadoraSuplementar].self, from: jsonData)
        } catch {
            print("Erro ao decodificar JSON: \(error)")
            return []
        }
    }
}
