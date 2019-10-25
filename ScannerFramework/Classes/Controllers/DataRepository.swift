//
//  DataRepository.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

public class DataRepository: BaseRepository {
    private struct Constants {
        static let currentUserKey = "currentUser"
        static let currentUserFirstName = "currentUserFirstName"
        static let currentUserLastName = "currentUserLastName"
        static let currentUserMiddleName = "currentUserMiddleName"
        static let branchStoragesKey = "cachedBranchStorages"
        static let appSettingsKey = "AppSettings"
        static let currentUserAccesses = "currentUserAccesses"
    }
    
    private var currentUserKey: String? {
        guard let currentUserId = UserDefaults.standard.value(forKey: Constants.currentUserKey) as? Int else {
            return nil
        }
        return "UserId\(currentUserId)"
    }
    
    private var currentUserFirstName: String {
        return (UserDefaults.standard.value(forKey: Constants.currentUserFirstName) as? String) ?? ""
    }
    
    private var currentUserLastName: String {
        return (UserDefaults.standard.value(forKey: Constants.currentUserLastName) as? String) ?? ""
    }
    
    private var currentUserMiddleName: String {
        return (UserDefaults.standard.value(forKey: Constants.currentUserMiddleName) as? String) ?? ""
    }
    
    private var currentUserAccesses: [AccessType]? {
        get {
            guard let data = UserDefaults.standard.value(forKey: Constants.currentUserAccesses) as? Data,
                let userAccesses = try? JSONDecoder().decode([AccessType].self, from: data) else { return nil }
            return userAccesses
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: Constants.currentUserAccesses)
        }
    }
    
    public var selectedBranchName: String? {
        return selectedBranch?.name
    }
    
    public var selectedBranchId: ModelID? {
        return selectedBranch?.id
    }
    
    public var selectedBranch: BranchModel? {
        get {
            guard let key = currentUserKey,
                let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
            let branch = try? JSONDecoder().decode(BranchModel.self, from: data)
            return branch
        }
        
        set {
            clearCache()
            guard let branchModel = newValue,
                let key = currentUserKey,
                let data = try? JSONEncoder().encode(branchModel) else { return }
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    public var cachedBranchStorages: StoragesModel? {
        get {
            guard let data = UserDefaults.standard.value(forKey: Constants.branchStoragesKey) as? Data else { return nil }
            let storagesModel = try? JSONDecoder().decode(StoragesModel.self, from: data)
            return storagesModel
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: Constants.branchStoragesKey)
        }
    }
    
    var appSettings: [SettingModel]? {
        get {
            guard let data = UserDefaults.standard.value(forKey: Constants.appSettingsKey) as? Data,
                let settings = try? JSONDecoder().decode([SettingModel].self, from: data) else { return nil }
            return settings
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: Constants.appSettingsKey)
        }
    }
    
    public var currentUserFullName: String {
        return "\(currentUserLastName) \(currentUserFirstName) \(currentUserMiddleName)"
    }
    
    public var currentUserID: ModelID? {
        return UserDefaults.standard.value(forKey: Constants.currentUserKey) as? ModelID
    }
    
    public init() {}
    
    public func setUserProfile(_ userProfile: ProfileModel) {
        UserDefaults.standard.set(userProfile.id, forKey: Constants.currentUserKey)
        UserDefaults.standard.set(userProfile.firstName, forKey: Constants.currentUserFirstName)
        UserDefaults.standard.set(userProfile.lastName, forKey: Constants.currentUserLastName)
        UserDefaults.standard.set(userProfile.middleName, forKey: Constants.currentUserMiddleName)
        currentUserAccesses = userProfile.accesses.map { $0.type }
        clearCache()
    }
    
    public func isAppSettingsEnabled(_ setting: SettingType) -> Bool {
        guard let settings = appSettings, let settingValue = settings.first(where: { $0.type == setting }) else { return true }
        return settingValue.isEnabled
    }
    
    public func isUserAccessAllowed(_ access: AccessType) -> Bool {
        guard let accesses = currentUserAccesses else { return true }
        return accesses.first { $0 == access } != nil
    }
    
    public func getBranchStorages(for branchID: Int64, prefereCached: Bool) {
        guard !prefereCached, let storages = cachedBranchStorages else {
            getBranchStorages(for: branchID)
            return
        }
        handler?.state = .success(Container.storages(storages))
    }
    
    // MARK: - Private
    
    private func clearCache() {
        cachedBranchStorages = nil
    }
}
