//
//  DatePickerView.swift
//  TestProjectWithNews
//
//  Created by artem on 29.07.2023.
//

import SwiftUI

struct DatePickerView: View {
    
    @Binding var dateInDatePicker: Date
    
    var body: some View {
           let currentDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
           let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
           let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
           
           DatePicker("", selection: $dateInDatePicker, in: oneMonthAgo...oneDayAgo, displayedComponents: .date)
               .datePickerStyle(.compact)
               .padding()
               .labelsHidden()
       }
}
