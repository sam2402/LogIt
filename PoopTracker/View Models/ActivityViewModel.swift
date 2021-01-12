//
//  ActivityViewModel.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 12/07/2020.
//

import Foundation
import Combine

class ActivityViewModel: ObservableObject {
    
    @Published var poopRepository = PoopRepository()
    @Published var poops = [Poop]() {
        didSet {
            updatePoopRowViewModels()
        }
    }
    @Published var timePeriod = "Day"
    @Published var poopRowViewModels = [PoopRowViewModel]()
    @Published var emptyRowsAreShowing = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private var firstPoopDate: Date  {
        if poops.count == 0 {
            return Date()
        }
        let sortedPoops = poops.sorted(by: { $0.time.compare($1.time) == .orderedAscending })
        return sortedPoops[0].time
    }
    
    init() {
        
        poopRepository.$poops.compactMap { poops in
            poops.map { poop in
                poop
            }
        }
        .assign(to: \.poops, on: self)
        .store(in: &cancellables)
        
    }
    
    func updatePoopRowViewModels() {
        let timeGroupedPoops = poops.dateGrouped(by: timePeriod)
        self.poopRowViewModels = timeGroupedPoops.map { poopGrouping in
            PoopRowViewModel(poops: poopGrouping, timePeriod: timePeriod)
        }
        if emptyRowsAreShowing {
            addEmptyRowVMs()
        } else {
            deleteEmptyRowVMs()
        }
    }
    
    func setTimePeriod(to timePeriod: String) {
        self.timePeriod = timePeriod
        updatePoopRowViewModels()
    }
    
    func addPoop(poop: Poop) {
        poopRepository.addPoop(poop)
        updatePoopRowViewModels()
    }
    
    func deletePoop(poop: Poop) {
        poopRepository.deletePoop(poop)
        updatePoopRowViewModels()
    }
    
    func getTimePeriodCalendarComponent() -> Calendar.Component {
        
        var timePeriod = Calendar.Component.day
        
        if self.timePeriod == "Day" {
            timePeriod = Calendar.Component.day
        } else if self.timePeriod == "Week" {
            timePeriod = Calendar.Component.weekOfYear
        } else if self.timePeriod == "Month" {
            timePeriod = Calendar.Component.month
        }
        
        return timePeriod
    }
    
    func getDatesListedByTimePeriod() -> [Date] {
        let startDate = self.firstPoopDate
        let intervalType = getTimePeriodCalendarComponent()
        var dates = [Date]()
        var currentDate = Date()
        while currentDate > startDate {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: intervalType, value: -1, to: currentDate)!
        }
        return dates
    }
    
    //Day: [day, weekOfYear, month, year]
    //Week: [weekOfYear, year]
    //Month: [month, year]
    func getTimesId(from date: Date) -> [Int] {
        var dateId = [date.get(.day), date.get(.weekOfYear), date.get(.month), date.get(.year)]

        if timePeriod == "Day" {
            dateId = dateId.suffix(4)
        } else if timePeriod == "Week" {
            dateId = [dateId[1], dateId[3]]
        } else if timePeriod == "Month" {
            dateId = dateId.suffix(2)
        }
        return dateId
    }
    
    func getEmptyTimePeriods() -> [Date] {
       
        let timeGroupedPoops = poops.dateGrouped(by: self.timePeriod)
        
        var poopsTimeIdList = [[Int]()]
        if timeGroupedPoops.indices.contains(0) {
            if timeGroupedPoops[0].indices.contains(0) {
                poopsTimeIdList = timeGroupedPoops.map { getTimesId(from: $0[0].time) }
            }
        }
        
        let allTimesList = getDatesListedByTimePeriod()
        var emptyTimesList = [Date]()
        
        for dummyDateIndex in allTimesList.indices {
            if !poopsTimeIdList.contains(getTimesId(from: allTimesList[dummyDateIndex])) {
                emptyTimesList.append(allTimesList[dummyDateIndex])
            }
        }
        
        return emptyTimesList //all times list is changed from being an array containing all dates to just containing empty dates
        
    }
    
    func addEmptyRowVMs() {
        let emptyTimePeriodsRowVMs = getEmptyTimePeriods().map { PoopRowViewModel(poops: [], timePeriod: timePeriod, time: $0) }
        self.poopRowViewModels.append(contentsOf: emptyTimePeriodsRowVMs)
        self.poopRowViewModels.sort(by: { $0.time.compare($1.time) == .orderedDescending })
    }
    
    func deleteEmptyRowVMs() {
        self.poopRowViewModels.removeAll(where: { $0.poops.isEmpty })
    }
    
    func toggleEmptyRows() {
        self.emptyRowsAreShowing.toggle()
        updatePoopRowViewModels()
    }
    
}
