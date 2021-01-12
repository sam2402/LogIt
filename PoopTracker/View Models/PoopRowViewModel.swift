//
//  PoopRowViewModel.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 12/07/2020.
//

import Foundation
import Combine
import SwiftUI

class PoopRowViewModel: ObservableObject, Identifiable {
    @Published var poops: [Poop]
    @Published var timePeriod: String
    @Published var time: Date

    var id = UUID()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(poops: [Poop], timePeriod: String) {
        self.poops = poops//.reversed()
        self.timePeriod = timePeriod
        
        if poops.indices.contains(0) {
            self.time = poops[0].time
        } else {
            self.time = Date()
        }
        
    }
    
    init(poops: [Poop], timePeriod: String, time: Date) {
        self.poops = poops.reversed()
        self.timePeriod = timePeriod
        self.time = time
    }
    
    func deletePoop(poop: Poop) {
        self.poops.removeAll(where: {$0.id == poop.id})
    }
    
    func numberColor() -> Color {
        var numberColor = Color.primary
        switch self.timePeriod {
        
        case "Day":
            switch self.poops.count {
                case 0:
                        numberColor = .orange
                case 1..<4:
                    numberColor = .green
                case 4:
                    numberColor = .orange
                case _ where self.poops.count > 4:
                    numberColor = .red
                default:
                        numberColor = .primary
                }
                return numberColor
            
        case "Week":
            switch self.poops.count {
                case 0..<2:
                        numberColor = .red
                case 2:
                    numberColor = .orange
                case 3..<36:
                    numberColor = .green
                case 36..<41:
                    numberColor = .orange
                case _ where self.poops.count > 40:
                    numberColor = .red
                default:
                        numberColor = .primary
                }
                return numberColor
            
        case "Month":
            switch self.poops.count {
                case 0..<6:
                        numberColor = .red
                case 6..<10:
                    numberColor = .orange
                case 10..<153:
                    numberColor = .green
                case 153..<164:
                    numberColor = .orange
                case _ where self.poops.count > 164:
                    numberColor = .red
                default:
                        numberColor = .primary
                }
                return numberColor
            
        default:
            return numberColor
        }
        
    }
    
    func timePeriodFormattedText() -> String {
        let formatter = DateFormatter()
        
        switch timePeriod {
        case "Day":
            formatter.dateStyle = .full
        case "Week":
            let calendar = Calendar.current
            let weekBoundary = calendar.weekBoundary(for: time)
            let startOfWeek = weekBoundary?.startOfWeek ?? time
            let endOfWeek = weekBoundary?.endOfWeek ?? time
            formatter.dateFormat = "d MMMM"
            let startOfWeekText = formatter.string(from: startOfWeek)
            formatter.dateFormat = "d MMMM Y"
            let endOfWeekText = formatter.string(from: endOfWeek)
            return startOfWeekText + " - " + endOfWeekText
        case "Month":
            formatter.dateFormat = "MMMM Y"
        default:
            formatter.dateStyle = .medium
        }
        return formatter.string(from: time)
        
    }
    
    func detailTimePeriodFormattedText(withDate date: Date) -> String {
        let formatter = DateFormatter()
        
        var timeText = ""
        if timePeriod == "Day" {
            formatter.dateFormat = "HH:mm"
            timeText = formatter.string(from: date)
        } else if timePeriod == "Week" || timePeriod == "Month" {
            formatter.dateFormat = "HH:mm "
            timeText = formatter.string(from: date)
            formatter.dateStyle = .full
            timeText = timeText + formatter.string(from: date)
        }
        
        return timeText
        
    }
    
}
