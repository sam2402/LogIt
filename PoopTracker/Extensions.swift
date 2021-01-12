//
//  Extensions.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 13/07/2020.
//

import Foundation
import SwiftUI

extension Poop {
    
    func timeString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self.time)
    }
    
    func dayString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self.time)
    }
    
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func isSame(period: String, as date: Date) -> Bool {
        func isSameDay(date1: Date, date2: Date) -> Bool {
            if (date1.get(.day) == date2.get(.day)) && (date1.get(.month) == date2.get(.month)) && (date1.get(.year) == date2.get(.year))  {
                return true
            } else {
                return false
            }
        }

        func isSameWeek(date1: Date, date2: Date) -> Bool {
            if (date1.get(.weekOfYear) == date2.get(.weekOfYear)) && (date1.get(.year) == date2.get(.year)) {
                return true
            } else {
                return false
            }
        }

        func isSameMonth(date1: Date, date2: Date) -> Bool {
            if (date1.get(.month) == date2.get(.month)) && (date1.get(.year) == date2.get(.year))  {
                return true
            } else {
                return false
            }
        }
        
        switch period {
        case "Day":
            return isSameDay(date1: self, date2: date)
        case "Week":
            return isSameWeek(date1: self, date2: date)
        case "Month":
            return isSameMonth(date1: self, date2: date)
        default:
            print("Error in isSamePeriod call. Ensure the time period is \"Day\" \"Week\" or \"month\"")
            return false
        }
    }
    
}

extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
    
    typealias WeekBoundary = (startOfWeek: Date?, endOfWeek: Date?)
        
        func currentWeekBoundary() -> WeekBoundary? {
            return weekBoundary(for: Date())
        }
        
        func weekBoundary(for date: Date) -> WeekBoundary? {
            let components = dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
            
            guard let startOfWeek = self.date(from: components) else {
                return nil
            }
            
            let endOfWeekOffset = weekdaySymbols.count - 1
            let endOfWeekComponents = DateComponents(day: endOfWeekOffset, hour: 23, minute: 59, second: 59)
            guard let endOfWeek = self.date(byAdding: endOfWeekComponents, to: startOfWeek) else {
                return nil
            }
            
            return (startOfWeek, endOfWeek)
        }
}

extension Array where Element == Poop {
    func notesPreview() -> String {
        for i in self.indices {
            if let poopArrayNote = self[i].notes {
                return poopArrayNote
            }
        }
        return ""
    }
    
    func numberColour() -> Color {
        var numberColor = Color.primary
        switch self.count {
        case 0:
                numberColor = .orange
        case 1..<4:
            numberColor = .green
        case 4:
            numberColor = .orange
        case _ where self.count > 4:
            numberColor = .red
        default:
                numberColor = .primary
        }
        return numberColor
    }
    
    func dateGrouped(by dateComponentString: String) -> [[Poop]] {
        let sortedPoopArray = self.sorted(by: { $0.time.compare($1.time) == .orderedDescending })
        var collectedByPeriodPoopArray: [[Poop]] = []
        
        var currentPeriod: [Poop] = []
        for i in sortedPoopArray.indices {
            
            if currentPeriod.isEmpty {
                currentPeriod.append(sortedPoopArray[i])
            } else if sortedPoopArray[i].time.isSame(period: dateComponentString, as: sortedPoopArray[i-1].time) {
                currentPeriod.append(sortedPoopArray[i])
            } else {
                collectedByPeriodPoopArray.append(currentPeriod)
                currentPeriod = []
                currentPeriod.append(sortedPoopArray[i])
            }
        }
        collectedByPeriodPoopArray.append(currentPeriod)
        return collectedByPeriodPoopArray
    }

}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
