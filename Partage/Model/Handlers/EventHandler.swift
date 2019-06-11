//
//  EventHandler.swift
//  Partage
//
//  Created by Roland Lariotte on 08/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import EventKit

//MARK: - Object that manage events in the user calendar
class EventHandler {
  static let shared = EventHandler()
  
  let eventStore = EKEventStore()
}

//MARK: - Save event in the user calendar
extension EventHandler {
  func addEventToCalendar(viewController: UIViewController ,title: String, location: String, startDate: Date, notes: String) {
    eventStore.requestAccess(to: EKEntityType.event, completion: {
      (granted, error) in
      DispatchQueue.main.async {
        if granted && error == nil {
          let event = EKEvent(eventStore: self.eventStore)
          event.title = title
          event.startDate = startDate
          event.endDate = startDate.addingTimeInterval(900)
          event.location = location
          event.notes = notes
          event.calendar = self.eventStore.defaultCalendarForNewEvents
          
          let alarm = EKAlarm.init(absoluteDate: Date.init(timeInterval: -1800, since: event.startDate))
          event.addAlarm(alarm)
          
          do {
            try self.eventStore.save(event, span: .thisEvent, commit: true)
            viewController.showAlert(title: .addToCalendar, message: .addedToCalendar)
          }
          catch let error as NSError {
            print(error.localizedDescription)
          }
        }
        else if !granted {
          viewController.showAlert(title: .addToCalendar, message: .needAccessToCalendar, buttonName: .settings, completion: {
              (true) in
            DispatchQueue.main.async {
              if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
              }
            }
          })
        }
      }
    })
  }
}
