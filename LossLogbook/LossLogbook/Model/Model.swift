//
//  Model.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import Foundation

class Model {
    static let shared = Model()
    
//    private var selectedDate:
    
    private var personnelData: [PersonnelJSON] = []
    private var equipmentOryxData: [EquipmentOryxJSON] = []
    private var equimpentData: [EquipmentJSON] = []
    
    func setData<T: Codable>(storage: HomeCollectionData, data: T) {
        switch storage {
        case .Personnel:
            if let data = data as? [PersonnelJSON] {
                personnelData = data
            }
        case .EquipmentOryx:
            if let data = data as? [EquipmentOryxJSON] {
                equipmentOryxData = data
            }
        case .Equimpent:
            if let data = data as? [EquipmentJSON] {
                equimpentData = data
            }
        case .Donate:
            break
        }
    }
    
    func getPersonnelData() -> [PersonnelJSON] {
        return personnelData
    }
    
    func getequipmentOryxData() -> [EquipmentOryxJSON] {
        return equipmentOryxData
    }
    
    func getEquimpentData() -> [EquipmentJSON] {
        return equimpentData
    }
    
    func loadData(completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkManager().fetchEquiment { [weak self] result in
            switch result {
            case .success(let success):
                self?.equimpentData = success
                dispatchGroup.leave()
            case .failure(let failure):
                print(failure.description)
            }
        }

        dispatchGroup.enter()
        NetworkManager().fetchEquimentOryx { [weak self] result in
            switch result {
            case .success(let success):
                self?.equipmentOryxData = success
                dispatchGroup.leave()
            case .failure(let failure):
                print(failure.description)
            }
        }

        dispatchGroup.enter()
        NetworkManager().fetchPersonnel { [weak self] result in
            switch result {
            case .success(let success):
                self?.personnelData = success
                dispatchGroup.leave()
            case .failure(let failure):
                print(failure.description)
            }

        }

        dispatchGroup.notify(queue: .main) {
            completion(true)
        }
    }
}
