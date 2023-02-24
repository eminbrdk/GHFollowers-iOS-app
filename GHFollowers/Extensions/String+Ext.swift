import Foundation


extension String {
    
    func convertToDate() -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormater.locale = Locale(identifier: "en-US-POSIX")
        dateFormater.timeZone = .current
        
        return dateFormater.date(from: self)
    }
    
    func convertToDisplayDormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
