//
//  FreeApiRLM.swift
//  free-apis
//
//  Created by Petr Sedlák on 03.07.2022.
//

import Foundation
import RealmSwift


// this would work if FreeApi was a class
//protocol FreeApiRLMExtension where Self: FreeApi {
//
//}
//
//extension FreeApiRLMExtension {
//    func toRLM() -> FreeApiRLM {
//        return FreeApiRLM(api: self)
//    }
//}

// this extension is here to make FreeApi available for widget without adding realm dependency to the widget target
extension FreeApi {
    func toRLM() -> FreeApiRLM {
        return FreeApiRLM(api: self)
    }
}


// Im making this object compatible with realm so i can save favorited apis. Saved in Realm == favorite api
class FreeApiRLM: Object, ObjectKeyIdentifiable, Decodable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var API: String
    @Persisted var Description: String
    @Persisted var Auth: String
    @Persisted var HTTPS: Bool
    @Persisted var Cors: String
    @Persisted var Link: String
    @Persisted var Category: String
    
    @Persisted var noteText: String = ""
    
    var isCors: Bool {
        return self.Cors == "yes"
    }

    convenience init(API: String, Description: String, Auth: String, HTTPS: Bool, Cors: String, Link: String, Category: String) {
    self.init()
    self.API = API
    self.Description = Description
    self.Auth = Auth
    self.HTTPS = HTTPS
    self.Cors = Cors
    self.Link = Link
    self.Category = Category
    }
    
    convenience init(api: FreeApi) {
        self.init()
        self.API = api.API
        self.Description = api.Description
        self.Auth = api.Auth
        self.HTTPS = api.HTTPS
        self.Cors = api.Cors
        self.Link = api.Link
        self.Category = api.Category
    }
    
    func toNonRLM() -> FreeApi {
        return FreeApi(API: self.API, Description: self.Description, Auth: self.Auth, HTTPS: self.HTTPS, Cors: self.Cors, Link: self.Link, Category: self.Category)
    }
    
   // static let ExampleApi = FreeApi(API: "Test", Description: "Description", Auth: "what", HTTPS: true, Cors: "idk what this is", Link: "somelink.com", Category: "Dogs")
    
//    static let ExampleApi: FreeApi = {
//        let api = FreeApiRLM()
//        api.API = "Test"
//        api.Description = "Description blah blah"
//        api.Auth = "what"
//        api.HTTPS = true
//        api.Cors = "idk what that is"
//        api.Link = "somelink.com"
//        api.Category = "Animals"
//        return api
//    }()
}
