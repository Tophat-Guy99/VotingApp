//
//  VotingResults.swift
//  L8
//
//  Created by Michael De Beyer on 3/9/23.
//

import SwiftUI
import Charts

struct CandidateVote: Identifiable {
    var id = UUID()
    var Name: String
    var Votes: Int
}

struct VotingResults: View {
    @Binding var CandidateArray: Array<Candidate>
    @Binding var TotalVotes: Int
    @State var Data: Array<CandidateVote> = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Total number of votes: \(TotalVotes)")
                Chart {
                    ForEach(Data) { CandStats in
                        BarMark(
                            x: .value("Name of candidate", CandStats.Name),
                            y: .value("Total votes", CandStats.Votes)
                        )
                        .annotation(position: .overlay, alignment: .top) {
                            Text("\(CandStats.Votes)")
                                .minimumScaleFactor(0.005)
                        }
                    }
                }
                .chartXAxisLabel("Name of candidate")
                .chartYAxisLabel("Number of votes")
                .chartYScale(domain: [0, TotalVotes])
            }
            .navigationTitle("Results")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Data = []
            TotalVotes = 0
            for Cand in CandidateArray {
                Data.append(CandidateVote(Name: Cand.FirstName + " " + Cand.Surname, Votes: Cand.Votes))
                TotalVotes += Cand.Votes
            }
        }
        .padding()
    }
}

struct VotingResults_Previews: PreviewProvider {
    static var previews: some View {
        VotingResults(CandidateArray: .constant([Candidate(FirstName: "", Surname: "", Age: 18, PresidencyGoal: "", NoOfScandals: 0, Votes: 0, Status: "Other")]), TotalVotes: .constant(0))
    }
}
