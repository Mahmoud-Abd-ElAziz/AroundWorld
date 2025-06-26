//
//  HomeView.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    @State private var selectedExperience: PlaceDataModel?
    
    @State private var title = "Welcome!"
    @State private var subtitle = "Now you can explore any experience in 360 degrees and get all the details about it all in one place."

    private let cardWidth: CGFloat = UIScreen.main.bounds.width - 32
    private var topPadding: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 8
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HomeSearchBar(vm: vm)
                    HomeHeader(title: $title, subtitle: $subtitle)

                    if vm.isSearching {
                        SearchResultsSection(vm: vm, cardWidth: cardWidth)
                    } else {
                        DefaultViewSections(vm: vm, cardWidth: cardWidth)
                    }
                }
                .padding(.top, 0)
                .navigationBarHidden(true)
            }
            .overlay(
                Group {
                    if vm.loading {
                        ProgressView()
                    }
                }
            )
            .onAppear {
                loadData()
            }
            .alert(isPresented: .constant(vm.error != nil), content: {
                Alert(title: Text("Error"), message: Text(vm.error ?? ""), dismissButton: .default(Text("OK")) )
            })
        }
    }
    
    
    
    
    //MARK: - Networking
    private func loadData() {
        Task {
            vm.loadCachedData()
            await vm.loadExperiences()
            await vm.loadRecent()
        }
    }
    
}

private struct HomeSearchBar: View {
    @ObservedObject var vm: HomeViewModel
    var body: some View {
        SearchBarView(
            text: $vm.searchText,
            onSearch: { Task { await vm.search() } },
            onClear: { vm.clearSearch() }
        )
    }
}

private struct HomeHeader: View {
    @Binding var title: String
    @Binding var subtitle: String
    var body: some View {
        HeaderView(title: $title, subtitle: $subtitle)
    }
}

private struct SearchResultsSection: View {
    @ObservedObject var vm: HomeViewModel
    var cardWidth: CGFloat
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle("Search Results")
            cardList(vm.searchResults)
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.title2).bold()
            .padding(.top)
            .padding(.horizontal, 16)
    }

    private func cardList(_ experiences: [PlaceDataModel]) -> some View {
        LazyVStack {
            ForEach(experiences) { exp in
                NavigationLink(destination: PlaceDetailView(place: exp)) {
                    PlaceCardView(place: exp) {
                        Task {
                            await vm.likeExperience(exp)
                        }
                    }
                }
                .frame(width: cardWidth)
                .padding(.vertical, 8)
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct DefaultViewSections: View {
    @ObservedObject var vm: HomeViewModel
    var cardWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle("Recommended Experiences")
                horizontalCardList(vm.recommended)
            }

            VStack(alignment: .leading, spacing: 8) {
                sectionTitle("Most Recent")
                cardList(vm.recent)
            }
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.title2).bold()
            .padding(.top)
            .padding(.horizontal, 16)
    }

    private func cardList(_ experiences: [PlaceDataModel]) -> some View {
        LazyVStack {
            ForEach(experiences) { exp in
                NavigationLink(destination: PlaceDetailView(place: exp)) {
                    PlaceCardView(place: exp) {
                        Task {
                            await vm.likeExperience(exp)
                        }
                    }
                }
                .frame(width: cardWidth)
                .padding(.vertical, 8)
            }
        }
        .padding(.horizontal, 16)
    }

    private func horizontalCardList(_ experiences: [PlaceDataModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(experiences) { exp in
                    NavigationLink(destination: PlaceDetailView(place: exp)) {
                        PlaceCardView(place: exp) {
                            Task { await vm.likeExperience(exp) }
                        }
                        .frame(width: cardWidth)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}


#Preview {
    HomeView()
}
