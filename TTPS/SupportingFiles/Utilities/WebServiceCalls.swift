//
//  WebServiceCalls.swift
//  Asset Management
//
//  Created by Bishwajitk kumar on 28/09/23.
//

import Foundation


class WebServiceCalls {
    static let shared = WebServiceCalls()
 
    private init() {
        print("Singleton initialized!")
    }
    
    func anyMethodApiCall(endPoint: String, method: String, body: [String:Any], token: String = "", completion: @escaping (_ msg: String, _ status: Int, _ data: Data?) -> Void) {
        
        //status 1 --> successfully received data with code 200..299
        //status 2 --> Have some error. successfully received data with code more than 300
        //status 3 --> no data received.
        
        let concatUrlStr = baseUrl+endPoint
        guard let urlStr = concatUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) else {
            completion("Internar error.", 3, nil)
            return
        }
        do {
            
            var request = URLRequest(url: url)
            if !token.isEmpty {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = method
            if !body.isEmpty {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsonData
            }
            print("Url:----> " , url)
            print("request ---> ", request)
            print("body ---> ", String(describing: request.httpBody))
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    completion("Can't get Data.", 3, nil)
                    print(String(describing: error))
                    return
                }
                
                // Convert data to JSON String
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON String:\n\(jsonString)")
                } else {
                    print("Failed to convert data to JSON String")
                }
                
                print((response as! HTTPURLResponse).statusCode)
                if (200...299).contains((response as! HTTPURLResponse).statusCode) {
                    
                   
                    completion("success.", 1, data)
                } else {
                    print("\n\n\npoint 1")
                    completion("Can't get Data.", 2, data)
                }
            }

            task.resume()
            
        } catch {
            completion("Internal error",3, nil)
            print(error)
        }
    }
    
    
    func anyMethodApiCall1(endPoint: String, method: String, body: [String], token: String = "", completion: @escaping (_ msg: String, _ status: Int, _ data: Data?) -> Void) {
        
        //status 1 --> successfully received data with code 200..299
        //status 2 --> Have some error. successfully received data with code more than 300
        //status 3 --> no data received.
        
        let concatUrlStr = baseUrl+endPoint
        guard let urlStr = concatUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) else {
            completion("Internar error.", 3, nil)
            return
        }
        do {
            
            var request = URLRequest(url: url)
            if !token.isEmpty {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = method
            if !body.isEmpty {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsonData
            }
            print("Url:----> " , url)
            print("request ---> ", request)
            print("body ---> ", String(describing: request.httpBody))
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    completion("Can't get Data.", 3, nil)
                    print(String(describing: error))
                    return
                }
                
                // Convert data to JSON String
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON String:\n\(jsonString)")
                } else {
                    print("Failed to convert data to JSON String")
                }
                
                print((response as! HTTPURLResponse).statusCode)
                if (200...299).contains((response as! HTTPURLResponse).statusCode) {
                    
                   
                    completion("success.", 1, data)
                } else {
                    print("\n\n\npoint 1")
                    completion("Can't get Data.", 2, data)
                }
            }

            task.resume()
            
        } catch {
            completion("Internal error",3, nil)
            print(error)
        }
    }
    
    func anyMethodApiCallSecond(endPoint: String, method: String, body: [[String: Any]], token: String = "", completion: @escaping (_ msg: String, _ status: Int, _ data: Data?) -> Void) {
        
        //status 1 --> successfully received data with code 200..299
        //status 2 --> Have some error. successfully received data with code more than 300
        //status 3 --> no data received.
        
        let concatUrlStr = baseUrl+endPoint
        guard let urlStr = concatUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) else {
            completion("Internar error.", 3, nil)
            return
        }
        do {
            
            var request = URLRequest(url: url)
            if !token.isEmpty {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = method
            if !body.isEmpty {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsonData
            }
            print("Url:----> " , url)
            print("request ---> ", request)
            print("body ---> ", String(describing: request.httpBody))
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    completion("Can't get Data.", 3, nil)
                    print(String(describing: error))
                    return
                }
                
                // Convert data to JSON String
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON String:\n\(jsonString)")
                } else {
                    print("Failed to convert data to JSON String")
                }
                
                print((response as! HTTPURLResponse).statusCode)
                if (200...299).contains((response as! HTTPURLResponse).statusCode) {
                    completion("success.", 1, data)
                } else {
                    print("\n\n\npoint 1")
                    completion("Can't get Data.", 2, data)
                }
            }

            task.resume()
            
        } catch {
            completion("Internal error",3, nil)
            print(error)
        }
    }
    
    func multiPartFileUpload(endPoint: String, method: String, body: [[String: Any]], token: String = "", filename: String, completion: @escaping (_ msg: String, _ status: Int, _ data: Data?) -> Void) {
        
        let parameters = body
        
//        var filename = filename
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        var error: Error? = nil
        for param in parameters {
            if param["disabled"] != nil { continue }
            let paramName = param["key"]!
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition:form-data; name=\"\(paramName)\"")
            if param["contentType"] != nil {
                body.append("\r\nContent-Type: \(param["contentType"] as! String)")
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
                let paramValue = param["value"] as! String
                body.append("\r\n\r\n\(paramValue)\r\n")
            } else {
                let paramData = param["value"] as! Data
                //            let fileData = try NSData(contentsOfFile: paramSrc, options: []) as Data
//                let fileContent = String(data: paramData, encoding: .utf8)!
                body.append("; filename=\"\(filename)\"\r\n")
                body.append("Content-Type: \"content-type header\"\r\n\r\n")
                body.append(paramData)
                body.append("\r\n")
            }
        }
        body.append("--\(boundary)--\r\n")
        let postData = body//.data(using: .utf8)
        
        let concatUrlStr = baseUrl+endPoint
        guard let urlStr = concatUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) else {
            completion("Internar error.", 3, nil)
            return
        }
        var request = URLRequest(url: url)
        if !token.isEmpty {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = postData
        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            guard let data = data else {
//                completion("Can't get Data.", 3, nil)
//                print(String(describing: error))
//                return
//            }
//
//            // Convert data to JSON String
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Response JSON String:\n\(jsonString)")
//            } else {
//                print("Failed to convert data to JSON String")
//            }
//
//            print((response as! HTTPURLResponse).statusCode)
//            if (200...299).contains((response as! HTTPURLResponse).statusCode) {
//                completion("success.", 1, data)
//            } else {
//                print("\n\n\npoint 1")
//                completion("Can't get Data.", 2, data)
//            }
//
//        }
//
//        task.resume()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion("Can't get Data.", 3, nil)
                }
                print(String(describing: error))
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON String:\n\(jsonString)")
            } else {
                print("Failed to convert data to JSON String")
            }

            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                DispatchQueue.main.async {
                    if (200...299).contains(httpResponse.statusCode) {
                        completion("Success.", 1, data)
                    } else {
                        print("\n\n\npoint 1")
                        completion("Can't get Data.", 2, data)
                    }
                }
            }
        }

        task.resume()

        
    }
    
    func fileDownload(endPoint: String, token: String = "", completion: @escaping (_ msg: String, _ status: Int, _ fileUrl: URL?) -> Void) {
        
        //status 1 --> successfully received data with code 200..299
        //status 2 --> Have some error. successfully received data with code more than 300
        //status 3 --> no data received.
        
        let concatUrlStr = baseUrl+endPoint
        guard let urlStr = concatUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) else {
            completion("Wrong file Download path.", 3, nil)
            return
        }
        
        var request = URLRequest(url: url)
        if !token.isEmpty {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        let task = URLSession.shared.downloadTask(with: request) { fileLoc, response, error in
            // Check if a location to a temporary file exists
            guard let tempLocation = fileLoc else {
                completion("File download interrupted.", 3, nil)
                return
            }
            // Get a file manager instance
            let fileManager = FileManager.default
            // Define a destination URL where you want to save the downloaded file
//            let fileName = tempLocation.lastPathComponent
            let fileName = endPoint.components(separatedBy: "/").last ?? "V-Asset_downloaded_file.temp"
            //let fileExt = endPoint.components(separatedBy: ".").last
            let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsDirectoryURL.appendingPathComponent(fileName)//(fileName+".\(fileExt ?? "temp")")
            // Remove any existing file at the destination URL
            try? fileManager.removeItem(at: destinationURL)
            do {
                // Move the downloaded file from the temporary location to the destination URL
                try fileManager.copyItem(at: tempLocation, to: destinationURL)
                print("File downloaded to: \(destinationURL)")
                completion("success.", 1, destinationURL)
            } catch {
                print("Error saving file: \(error)")
                completion("Can't save file.", 3, nil)
            }
        }
        
        task.resume()
        
    }
    func checkForNewVersion(completion: @escaping (_ result: AppStoreResult?) -> Void) {
        guard let bundleID = Bundle.main.bundleIdentifier,
              let currentVersionNumber = Bundle.main.releaseVersionNumber,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleID)") else {
            completion(nil)
            return
        }
            
            var request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    completion(nil)
                    print(String(describing: error))
                    return
                }
                
                // Convert data to JSON String
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON String:\n\(jsonString)")
                } else {
                    print("Failed to convert data to JSON String")
                }
                
                print((response as! HTTPURLResponse).statusCode)
                if (200...299).contains((response as! HTTPURLResponse).statusCode) {
                    do {
                        let appStoreResponse = try JSONDecoder().decode(AppStoreResponse.self, from: data)
                        guard let latestVersionNumber = appStoreResponse.results?.first?.version else {
                            completion(nil)
                            return
                        }
                         
                        if currentVersionNumber != latestVersionNumber {
                            completion(appStoreResponse.results?.first)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        print(error)
                        completion(nil)
                    }
                    
                } else {
                    completion(nil)
                }
            }

            task.resume()
    }
}
