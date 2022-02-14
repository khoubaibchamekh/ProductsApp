//
//  RealmProvider.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import RealmSwift

struct RealmProvider {
    
    //MARK: - Properties
    private let configuration: Realm.Configuration
    var realm: Realm? {
        do {
            return try Realm(configuration: configuration)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    //MARK: - Configuration
    private static let defaultConfiguration = Realm.Configuration(schemaVersion: 1)
    
    //MARK: - Init
    internal init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    
    //MARK: - Realm Instances
    public static var `default`: Realm? = {
        return RealmProvider(configuration: RealmProvider.defaultConfiguration).realm
    }()
}
