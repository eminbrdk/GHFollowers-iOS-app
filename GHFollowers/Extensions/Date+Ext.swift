import Foundation


extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM yyyy"
        return dateFormater.string(from: self)
    }
}
