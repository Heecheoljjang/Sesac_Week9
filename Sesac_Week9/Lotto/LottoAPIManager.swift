//
//  LottoAPIManager.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/08/30.
//

import Foundation

//shared - 단순한. 커스텀불가능. 응답은 클로저로. 백그라운드 전송은 제공안됨
//컨피규레이션은 디폴트, 에페메랄, 백그라운드 세 가지가 있음. 백그라운드는 말그대로 백그라운드, 에메메랄릉ㄴ 정보 휘발시킴(보안)
//default configuration - shared와 설정 유사하지만 커스텀 가능(셀룰러 연결 여부, 타임 아웃 간격). 응답은 클러저도 가능하고 딜리게이트로도 가능
//타임아웃은 앱에서 서버한테 요청했는데 서버가 꺼지면 클라이언트는 알 수 없기때문에 무한대기일수도있음. 이상황을 막기위해 일정시간이 지나도 오지않으면 말해주는등

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class LottoAPIManager {
    
    //실패할 수도있어서 옵셔널로
    static func requestLotto(drwNo: Int, completion: @escaping (Lotto?, APIError?) -> ()) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        
        
        //데이터태스크에 작성하는정보가 알라모파이어의 리퀘스트부분
        //컴플리션핸들러르이 세 가지 모두 옵셔널
        //resume없으면 아무것도 안뜸(요청을 실제로 해달라는 뜻)
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //아예 매니저 안에서 네트워킹 끝나면 메인스레드에서 진행
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
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
        
    }
    
}
