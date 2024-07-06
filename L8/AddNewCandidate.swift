//
//  AddNewCandidate.swift
//  L8
//
//  Created by Michael De Beyer on 28/8/23.
//

import SwiftUI

struct AddNewCandidate: View {
    @Environment(\.dismiss) var dismiss
    var StatusOptions = [
        "Politician",
        "Military General",
        "Business CEO",
        "Student",
        "Adult Citizen",
        "Other"
    ]
    @Binding var FName: String
    @Binding var SName: String
    @Binding var Age: Double
    @Binding var Goals: String
    @Binding var ScandalCount: Int
    @Binding var Status: String
    
    @Binding var CandidateArray: Array<Candidate>
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $FName)
                TextField("Surname", text: $SName)
                HStack {
                    Text("Age: " + String(Int(Age)))
                    Spacer()
                    Slider(value: $Age, in: 18.0...80.0, step: 1)
                }
            } header: {
                Text("Personal Info")
            }
            Section {
                TextEditor(text: $Goals)
            } header: {
                Text("Presidency Goals")
            }
            Section {
                Stepper(("Number of scandals: " + String(ScandalCount)), value: $ScandalCount, in: 0...9223372036854775807)
                Picker("Status:", selection: $Status) {
                    ForEach(StatusOptions, id: \.self) {
                        option in
                        Text(option)
                    }
                }
                .pickerStyle(.menu)
            } header: {
                Text("Political Career")
            }
            Section {
                Button() {
                    if FName != "" && SName != "" {
                        CandidateArray.append(Candidate(FirstName: FName, Surname: SName, Age: Age, PresidencyGoal: Goals, NoOfScandals: ScandalCount, Votes: 0, Status: Status))
                        FName = ""
                        SName = ""
                        Age = 18.0
                        Goals = ""
                        ScandalCount = 0
                        Status = "Politician"
                        dismiss()
                    }
                    
                } label: {
                    Text("Add")
                }
                Button(role: .cancel) {
                    FName = ""
                    SName = ""
                    Age = 18.0
                    Goals = ""
                    ScandalCount = 0
                    Status = "Politician"
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

struct AddNewCandidate_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCandidate(FName: .constant(""), SName: .constant(""), Age: .constant(60.0), Goals: .constant(""), ScandalCount: .constant(0), Status: .constant(""), CandidateArray: .constant([Candidate(FirstName: "", Surname: "", Age: 18, PresidencyGoal: "", NoOfScandals: 0, Votes: 0, Status: "Other")]))
    }
}
