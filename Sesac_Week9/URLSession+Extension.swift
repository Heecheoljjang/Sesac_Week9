//
//  URLSession+Extension.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/08/30.
//

import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> ()
    
    @discardableResult //반환값있어도 안씀
    func customDataTask(_ endpoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        
        let task = dataTask(with: endpoint, completionHandler: completionHandler)
        task.resume()
        
        return task
    }
    
    static func request<T: Codable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping(T?, APIError?) -> ()) {
        
        session.customDataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                //에러부터 판단
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
                
                //타입캐스팅을 사용하는 이유는 statuscode를 사용하기 위해
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
                
                //위의 모든 guard문이 다 통과되어야 코드 실행됨
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }
        
    }

}
