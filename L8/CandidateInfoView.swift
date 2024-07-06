//
//  CandidateInfoView.swift
//  L8
//
//  Created by Michael De Beyer on 1/9/23.
//

import SwiftUI

struct CandidateInfoView: View {
    @Environment(\.dismiss) var dismiss
    @State var AlertShown = false
    @State var arrindex = 0
    
    var StatusOptions = [
        "Politician",
        "Military General",
        "Business CEO",
        "Student",
        "Adult Citizen",
        "Other"
    ]
    @Binding var CandidateArray: Array<Candidate>
    @Binding var Candidate: Candidate
    
    @State var FName = ""
    @State var SName = ""
    @State var Age = 0.0
    @State var Goals = ""
    @State var ScandalCount = 0
    @State var Status = "Other"
    
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $FName)
                    .onChange(of: FName) {NewValue in
                        Candidate.FirstName = NewValue
                    }
                TextField("Surname", text: $SName)
                    .onChange(of: SName) {NewValue in
                        Candidate.Surname = NewValue
                    }
                HStack {
                    Text("Age: " + String(Int(Age)))
                    Spacer()
                    Slider(value: $Age, in: 13.0...80.0, step: 1)
                        .onChange(of: Age) {NewValue in
                            Candidate.Age = NewValue
                        }
                }
            } header: {
                Text("Personal Info")
            }
            Section {
                TextEditor(text: $Goals)
                    .onChange(of: Goals) { NewValue in
                        Candidate.PresidencyGoal = NewValue
                    }
            } header: {
                Text("Presidency Goals")
            }
            Section {
                Stepper(("Outrageous wrongdoings: " + String(ScandalCount)), value: $ScandalCount, in: 0...1000)
                    .onChange(of: ScandalCount) {NewValue in
                        Candidate.NoOfScandals = NewValue
                    }
                Picker("Status:", selection: $Status) {
                    ForEach(StatusOptions, id: \.self) {
                        option in
                        Text(option)
                    }
                }
                .onChange(of: Status) {NewValue in
                    Candidate.Status = NewValue
                }
                .pickerStyle(.menu)
            } header: {
                Text("Political Career")
            }
            Section {
                Button(role: .destructive) {
                    AlertShown.toggle()
                } label: {
                    Text("Remove")
                        .alert(isPresented: $AlertShown) {
                            Alert(title: Text("Are you sure you want to remove " + FName + " " + SName + "?"), message: Text("This action is irreversible."), primaryButton: .destructive(Text("Remove Candidate")) {
                                for i in CandidateArray {
                                    if i.id == Candidate.id {
                                        arrindex = CandidateArray.firstIndex(of: i) ?? 0
                                        CandidateArray.remove(at: arrindex)
                                        dismiss()
                                        break
                                        
                                    }
                                }
                            },
                                  secondaryButton: .cancel())
                        }
                }
            }
        }
        .onAppear {
            FName = Candidate.FirstName
            SName = Candidate.Surname
            Age = Candidate.Age
            Goals = Candidate.PresidencyGoal
            ScandalCount = Candidate.NoOfScandals
            Status = Candidate.Status
        }
    }
}

struct CandidateInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateInfoView(CandidateArray: .constant([Candidate(FirstName: "", Surname: "", Age: 18.0, PresidencyGoal: "", NoOfScandals: 0, Votes: 0, Status: "Other")]), Candidate: .constant(Candidate(FirstName: "", Surname: "", Age: 18.0, PresidencyGoal: "", NoOfScandals: 0, Votes: 0, Status: "Other")))
    }
}
