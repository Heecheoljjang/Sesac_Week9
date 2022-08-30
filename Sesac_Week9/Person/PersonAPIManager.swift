//
//  PersonAPIManager.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    
    static func requestPerson(query: String, completion: @escaping (Person?, APIError?) -> ()) {
        
        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=b86c2502a0f81982d95890ef9ecc7ea1&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        //관리적인 측면으로 아래처럼 하는 것도 괜찮
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        //뒤에는 쿼리스트링이라고 하고, 쿼리에 대한 아이템들이라고 함
        
        let language = "ko-Kr"
        let key = "b86c2502a0f81982d95890ef9ecc7ea1"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
        ]
        
        //뭐가 들어갈지
//        URLSession.request(endpoint: component.url!) { success, fail in
//            <#code#>
//        }
//
//
//
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
            DispatchQueue.main.async {

                guard error == nil else {
                    print("Request Failed")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    print("No Data")
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }

                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
    
}
