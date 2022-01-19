//
//  NetworkManager.swift
//  RxSwiftWithWebServiceConfiguration
//
//  Created by Shoeib on 1/17/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire


protocol NetworkManagerProtocol {
    func executeRequest<R:BaseResponseModel>(url:String,requestDictionary:[String:Any]?,method:HTTPMethod,additionnalHeaders:[String:String]?,responseModel:R.Type) -> Observable<R>
}

class NetworkManager : NetworkManagerProtocol {
    
    private var manager: SessionManager!
    
    init(requestTimeout : Double = 30) {
        manager = self.getAlamofireManager(timeout: requestTimeout)
    }
    
    private func getAlamofireManager(timeout : Double) -> SessionManager  {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = timeout
        configuration.timeoutIntervalForRequest = timeout
        let alamofireManager = Alamofire.SessionManager(configuration: configuration)
        return alamofireManager
    }
    
    func executeRequest<R:BaseResponseModel>(url:String,requestDictionary:[String:Any]?,method:HTTPMethod,additionnalHeaders:[String:String]? = nil,responseModel:R.Type) -> Observable<R> {
        return Observable.create { observer in
            
            let fullAPIURL = "\(NetworkConstant.BASE_URL)\(url)"
            let serviceStartTime = CFAbsoluteTimeGetCurrent()
            
            if NetworkConstant.enable_log , let requestDictionary = requestDictionary {
                print("API Request : \n \(requestDictionary.json())")
            }
            
            var headers: HTTPHeaders = [
                "Accept": "application/json",
                "Content-Type" :"application/json"
            ]
            
            if let additionnalHeaders = additionnalHeaders {
                headers.merge(dict: additionnalHeaders)
            }
            
            let requestRef = self.manager.request(fullAPIURL, method: method , parameters: requestDictionary, headers: headers)
                .validate()
                .responseJSON { [weak self] response in
                
                let _ = self?.manager // retain
                
                if NetworkConstant.enable_log {
                    let elapsedTime = CFAbsoluteTimeGetCurrent() - serviceStartTime;
                    print("\n\nThe Service With URL: \(fullAPIURL)\nTook \(elapsedTime) seconds to execute\n\n")
                }
                
                switch response.result {
                case .success :
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        if let data = response.data {
                            
                            if NetworkConstant.enable_log {
                                
                                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                                if let json = json {
                                print("Response : \(String(describing: json.json()))")
                                }
                            }
                            
                            let baseResponse = try decoder.decode(responseModel, from: data)
                            
                            if let baseResponseModel = baseResponse.response,let code = baseResponseModel.code,code == NetworkConstant.success_response_code {
                                let model = try JSONDecoder().decode(R.self, from: response.data!)
                                observer.onNext(model)
                                observer.onCompleted()
                            }else{
                                observer.onError(baseResponse)
                                observer.onCompleted()
                            }
                        }else{
                            observer.onError((self?.getBaseError(errorMessage: "unexpected error occurrred, Please try again later"))!)
                            observer.onCompleted()
                        }
                        
                    } catch {
                        observer.onError((self?.getBaseError(errorMessage: "Success Model Parsing Error"))!)
                        observer.onCompleted()
                    }
                    
                case .failure(let error):
                    if NetworkConstant.enable_log {
                        print("\n Failure: \(error.localizedDescription)")
                    }
                    // TODO CHECK ERROR HANDLING
                    observer.onError((self?.getBaseError(errorMessage: error.localizedDescription))!)
                    observer.onCompleted()
                    
                }
            }
            
            return Disposables.create {
                requestRef.cancel()
            }
        }
    }
    
    
    func getBaseError(errorMessage:String) -> BaseResponseModel{
        let responseModel = BaseResponseModel(response:Response(code: nil, message: errorMessage))
        return responseModel
    }
}



