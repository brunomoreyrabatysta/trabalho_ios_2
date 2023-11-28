//
//  ServiceANS.swift
//  trabalho_ios_2
//
//  Created by BRUNO MOREIRA BATISTA on 23/11/23.
//

import Foundation

struct ANSOperadoraResponse: Decodable {
    let content: [ANSOperadoraSuplementar]
    
    enum CodingKeys: CodingKey {
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content = try container.decode([ANSOperadoraSuplementar].self, forKey: .content)
    }
}

struct ANSOperadoraSuplementar: Codable {
    let registro_ans: String
    let cnpj: String
    let razao_social: String
    let nome_fantasia: String
    let ativa: Bool
    let classificacao_sigla: String
    
    enum CodingKeys: String, CodingKey {
        case registro_ans
        case cnpj
        case razao_social
        case nome_fantasia
        case ativa
        case classificacao_sigla
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.registro_ans = try container.decode(String.self, forKey: .registro_ans)
        self.cnpj = try container.decode(String.self, forKey: .cnpj)
        self.razao_social = try container.decode(String.self, forKey: .razao_social)
        self.nome_fantasia = try container.decode(String.self, forKey: .nome_fantasia)
        self.ativa = try container.decode(Bool.self, forKey: .ativa)
        self.classificacao_sigla = try container.decode(String.self, forKey: .classificacao_sigla)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.registro_ans, forKey: .registro_ans)
        try container.encode(self.cnpj, forKey: .cnpj)
        try container.encode(self.razao_social, forKey: .razao_social)
        try container.encode(self.nome_fantasia, forKey: .nome_fantasia)
        try container.encode(self.ativa, forKey: .ativa)
        try container.encode(self.classificacao_sigla, forKey: .classificacao_sigla)
    }
}

enum ANSOperadoraError: Error {
    case invalidURL
    case couldNotReturnOperadoraList(errorCode: Int)
    case couldNotDecodeObject
    case couldNotGetError
}

protocol ANSOperadoraServiceable {
    func fetchOperadoraList(page: Int, size: Int, active: Int, sort: String) async throws -> [ANSOperadoraSuplementar]
}

class ANSOperadoraService: ANSOperadoraServiceable {
    func fetchOperadoraList(page: Int = 1, size: Int = 25, active: Int = 0, sort: String = "nome_fantasia") async throws -> [ANSOperadoraSuplementar] {
        let urlString = "https://www.ans.gov.br/operadoras-entity/v1/operadoras?ativa=\(active)&page=\(page)&size\(size)&sort=\(sort)"
        
        guard let url = URL(string: urlString) else {
            throw ANSOperadoraError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(ANSOperadoraResponse.self, from: data)
            return response.content
        } catch {
            if let urlError = error as? URLError {
                throw ANSOperadoraError.couldNotReturnOperadoraList(errorCode: urlError.errorCode)
            } else if let _ = error as? DecodingError {
                throw ANSOperadoraError.couldNotDecodeObject
            } else {
                throw ANSOperadoraError.couldNotGetError
            }
        }
    }
}

