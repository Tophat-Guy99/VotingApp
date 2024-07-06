//
//  VotingView.swift
//  L8
//
//  Created by Michael De Beyer on 28/8/23.
//

import SwiftUI

struct VotingView: View {
    @Binding var CandidateArray: Array<Candidate>
    @Binding var TotalVotes: Int
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach($CandidateArray, id: \.id) { $array in
                        HStack {
                            Text(array.FirstName + " " + array.Surname + ": ")
                            Spacer()
                            Stepper(String(array.Votes), value: $array.Votes, in: 0...9223372036854775807)
                        }
                        
                    }
                } header: {
                    Text("Add or subtract votes from candidates below")
                }
            }
            .navigationTitle("Voting")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            TotalVotes = 0
            for Cand in CandidateArray {
                TotalVotes += Cand.Votes
            }
        }
    }
}

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView(CandidateArray: .constant([Candidate(FirstName: "a", Surname: "a", Age: 18, PresidencyGoal: "", NoOfScandals: 0, Votes: 0, Status: "Other")]), TotalVotes: .constant(0))
    }
}
