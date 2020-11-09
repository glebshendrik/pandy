//
//  Date+Extensions.swift
//  Eshka
//
//  Created by Gleb Shendrik on 01/09/2019.
//
//

import Foundation

extension Date {
    
    static func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date {
        let calendar = Calendar.current
        // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
        return calendar.date(from: components)!
    }
    
    
    var monthString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let currentLocale = NSLocale.current
        if currentLocale.identifier == "ru_RU" || currentLocale.identifier == "en_RU"   {
            dateFormatter.locale = Locale(identifier: "ru_RU")
        } else {
            dateFormatter.locale = Locale(identifier: "en_EN")
        }
        return dateFormatter.string(from: self)
    }
    
    var yearString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let currentLocale = NSLocale.current
        if currentLocale.identifier == "ru_RU" || currentLocale.identifier == "en_RU" {
            dateFormatter.locale = Locale(identifier: "ru_RU")
        } else {
            dateFormatter.locale = Locale(identifier: "en_EN")
        }
        return dateFormatter.string(from: self)
    }
    
    var simpleDateStringRepresentation : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }

    var simpleDateWithTimeStringRepresentation : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: self)
    }

    var simpleTimeStringRepresentation : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }

    var onlyDayAndMonthRepresentation : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: self)
    }

    var shortStringRepresentation : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let currentLocale = NSLocale.current
        if currentLocale.identifier == "ru_RU" {
            dateFormatter.locale = Locale(identifier: "ru_RU")
        } else {
            dateFormatter.locale = Locale(identifier: "en_EN")
        }
        return dateFormatter.string(from: self)
    }
    
    var shortStringRepresentationWithDay : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM"
        let currentLocale = NSLocale.current
        if currentLocale.identifier == "ru_RU" {
            dateFormatter.locale = Locale(identifier: "ru_RU")
        } else {
            dateFormatter.locale = Locale(identifier: "en_EN")
        }
        return dateFormatter.string(from: self)
    }

    var timeOrDateForToday : String {
        if Calendar.current.isDateInToday(self) {
            return simpleTimeStringRepresentation
        } else {
            return simpleDateStringRepresentation
        }
    }

    func isSameMinute(otherDate : Date ) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(self, to: otherDate, toGranularity: .minute) == ComparisonResult.orderedSame
    }

    func isSameDay(otherDate : Date ) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(self, to: otherDate, toGranularity: .day) == ComparisonResult.orderedSame
    }

    func formattedDateAndTime() -> String {
        var result = ""
        let currentLocale = NSLocale.current
        var locateToSet = Locale(identifier: "en_EN")
        if currentLocale.identifier == "ru_RU" || currentLocale.identifier == "en_RU" {
            locateToSet = Locale(identifier: "ru_RU")
        } else {
            locateToSet = Locale(identifier: "en_EN")
        }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd MMM"
        dayFormatter.locale = locateToSet
        
        let diff = Date().timeIntervalSince1970 - self.timeIntervalSince1970
        if diff < 3600 {
            let mins = Int((diff/60).rounded(.awayFromZero))
            var minutesString = L10n.DateFormat.minuteNominative
            let remainder = mins % 10
            switch remainder {
            case 1:
                minutesString = L10n.DateFormat.minuteNominative
            case 2...4:
                minutesString = L10n.DateFormat.minutePluralAblative
            default:
                minutesString = L10n.DateFormat.minuteDativePlural
            }
            result = L10n.DateFormat.nMinutesAgo(mins, minutesString)
        } else if Calendar.current.isDateInToday(self) {
            result = L10n.DateFormat.todayAt(timeFormatter.string(from: self))
        } else if Calendar.current.isDateInYesterday(self) {
            result = L10n.DateFormat.yesterdayAt(timeFormatter.string(from: self))
        } else {
            result = L10n.DateFormat.otherCases(dayFormatter.string(from: self), timeFormatter.string(from: self))
        }
        return result
    }
    
    func add(_ unit: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: unit, value: value, to: self) ?? Date()
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func formattedCommentDateAndTime() -> String {
        let formatter = DateFormatter()
        switch true {
        case Calendar.current.isDateInToday(self) || Calendar.current.isDateInYesterday(self):
            formatter.doesRelativeDateFormatting = true
            formatter.dateStyle = .short
        default:
            formatter.dateFormat = "d MMMM, в H:mm"
        }
        
        
        let currentLocale = NSLocale.current
        if currentLocale.identifier == "ru_RU" || currentLocale.identifier == "en_RU" {
            formatter.locale = Locale(identifier: "ru_RU")
        } else {
            formatter.locale = Locale(identifier: "en_EN")
        }
        
        
        
        
        return formatter.string(from: self)
    }

    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    
    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }
    
    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }
    
    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }
    
    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }

    
}
