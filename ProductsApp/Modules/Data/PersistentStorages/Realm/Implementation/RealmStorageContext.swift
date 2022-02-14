//
//  RealmStorageContext.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import RealmSwift

class RealmStorageContext {
    //MARK: - Properties
    private var configuration: ConfigurationType
    private var realm: Realm? {
        let result: Realm?
        switch configuration {
        case .default:
            result = RealmProvider.default
        case .inMemory(let identifier):
            result = RealmProvider(configuration: .init(inMemoryIdentifier: identifier)).realm
        }
        return result
    }
    
    init(configuration: ConfigurationType = .default) {
        self.configuration = configuration
    }
}

extension RealmStorageContext: StorageContext {
    //MARK: - Methods
    func fetch<T: Storable>(_ model: T.Type, options: FetchOptions?) -> [T] {
        guard let realm = realm, let model = model as? Object.Type else {
            return []
        }
        
        var objects = realm.objects(model)
        
        if let predicate = options?.predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorting = options?.sorting {
            objects = objects.sorted(byKeyPath: sorting.key, ascending: sorting.ascending)
        }
        
        return objects.compactMap { $0 as? T }
    }
    
    func save<T: Storable>(_ objects: [T]) throws {
        guard let realm = realm, let objects = objects as? [Object] else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
                
        try realm.write {
            realm.add(objects, update: .modified)
        }
    }
}
