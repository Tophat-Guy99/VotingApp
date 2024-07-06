//
//  ContentView.swift
//  L8
//
//  Created by Michael De Beyer on 28/8/23.
//

import SwiftUI

struct Candidate: Equatable {
    var id = UUID()
    var FirstName: String
    var Surname: String
    var Age: Double
    var PresidencyGoal: String
    var NoOfScandals: Int
    var Votes: Int
    var Status: String
}
struct ContentView: View {
    @State var TotalVotes = 0
    @State var CandidateArray = [
        Candidate(FirstName: "Bob", Surname: "McPerson", Age: 17.0, PresidencyGoal: "Trains, but with even more seats. Everybody will be guaranteed a seat on the trains!", NoOfScandals: 0, Votes: 0, Status: "Student"),
        Candidate(FirstName: "Joe", Surname: "Armstrong", Age: 57.0, PresidencyGoal: "Triple the military defence budget. Now!", NoOfScandals: 6, Votes: 0, Status: "Military General"),
    ]
    
    var body: some View {
        TabView {
            CandidateList(CandidateArray: $CandidateArray)
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Candidates")
                    }
                }
            VotingView(CandidateArray: $CandidateArray, TotalVotes: $TotalVotes)
                .tabItem {
                    VStack {
                        Image(systemName: "number.circle")
                        Text("Voting")
                    }
                }
            VotingResults(CandidateArray: $CandidateArray, TotalVotes: $TotalVotes)
                .tabItem {
                    VStack {
                        Image(systemName: "chart.pie")
                        Text("Results")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
