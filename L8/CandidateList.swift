//
//  CandidateList.swift
//  L8
//
//  Created by Michael De Beyer on 28/8/23.
//

import SwiftUI

struct CandidateList: View {
    @Environment(\.dismiss) var dismiss
    @State var ListAlertShown = false
    @State var arrindex = 0
    
    @State var BlankFName = ""
    @State var BlankSName = ""
    @State var PlaceholderAge = 18.0
    @State var BlankGoals = ""
    @State var PlaceholderScandal = 0
    @State var PlaceholderStatus = "Other"
    
    @State var SheetShown = false
    
    @Binding var CandidateArray: Array<Candidate>
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach($CandidateArray, id: \.id) { $Cand in
                        HStack {
                                    NavigationLink {
                                        CandidateInfoView(CandidateArray: $CandidateArray, Candidate: $Cand)
                                    } label: {
                                        Text(Cand.FirstName + " " + Cand.Surname)
                                    }
                            Spacer()
                            Image(systemName: "person")
                        }
                    }.onDelete { indexSet in
                                CandidateArray.remove(atOffsets: indexSet)
                    }
                } header: {
                    Text("Tap and hold to view more actions")
                }
                
            }
            .sheet(isPresented: $SheetShown) {
                AddNewCandidate(FName: $BlankFName, SName: $BlankSName, Age: $PlaceholderAge, Goals: $BlankGoals, ScandalCount: $PlaceholderScandal, Status: $PlaceholderStatus, CandidateArray: $CandidateArray)
            }
            .navigationTitle("Candidate Info")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            SheetShown.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}

struct CandidateList_Previews: PreviewProvider {
    static var previews: some View {
        CandidateList(CandidateArray: .constant([Candidate(FirstName: "", Surname: "", Age: 18, PresidencyGoal: "", NoOfScandals: 0, Votes: 0, Status: "Other")]))
    }
}
