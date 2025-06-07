//
//  SettingsViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation
import Combine
import UserNotifications

final class SettingsViewModel: ObservableObject {
    @Published var notificationsToggle = false
    @Published var showActivity = false
    @Published var appError: Error?
    var data: [Any] = []
    @Published var showSettingsAlert = false
    var settingAlertModel: SettingAlert = .empty
    
    private var blockNotificationsRequest = true
    private var cancellable = Set<AnyCancellable>()
    
    /// Dependencies
    private let appInteractionService: AppInteractionService
     
    init(
        _ appInteractionService: AppInteractionService = AppInteractionServiceImp()
    ) {
        self.appInteractionService = appInteractionService
        
        $notificationsToggle
            .dropFirst()
            .sink { [weak self] value in
                guard let self else { return }
                switch (value, blockNotificationsRequest) {
                case (true, false):
                    requestNotifications()
                case (false, false):
                    disableNotifications()
                default:
                    break
                }
                
            }
            .store(in: &cancellable)
    }
    
    func setup() {
        checkNotificationStatus()
    }
    
    func cellButtonPressed(with model: SettingsContentModel, completion: (URL) -> Void) {
        switch model {
        case .notifications:
            break
        case .privacyPolicy:
            guard let url = appInteractionService.privacyLink else { return }
            completion(url)
        case .termsOfUse:
            guard let url = appInteractionService.termsLink else { return }
            completion(url)
        case .support:
            guard let url = appInteractionService.supportLink else { return }
            completion(url)
        case .shareApp:
            guard let url = appInteractionService.appLink else { return }
            data.removeAll()
            data.append(url)
            showActivity = true
        }
    }
    
    func openPhoneSettings() {
        appInteractionService.openSettings()
    }
    
    func cancelAlert() {
        self.notificationsToggle = false
    }
    
    private func checkNotificationStatus() {
        blockNotificationsRequest = true
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationsToggle = settings.authorizationStatus == .authorized
                self.blockNotificationsRequest = false
            }
        }
    }
    
    private func requestNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined:
                    self.requestInitialAuthorization()
                case .denied:
                    self.showSettingsAlert = true
                case .authorized, .provisional, .ephemeral:
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    private func requestInitialAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                self.notificationsToggle = granted
            }
        }
    }
    
    private func disableNotifications() {
        // TODO: to implement in the future 🤗
    }
}
