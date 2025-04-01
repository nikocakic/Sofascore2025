//
//  EventTableView.swift
//  Sofascore2025
//
//  Created by Niko on 01.04.2025..
//


import UIKit
import SnapKit
import SofaAcademic

class EventTableView: UIView {
    
    private let tableView = UITableView()
    
    var grouped: [String: [Event]] = [:]
    var leagueDetails: [String: League] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview() 
        }
    }
    
    func updateData(grouped: [String: [Event]], leagueDetails: [String: League]) {
        self.grouped = grouped
        self.leagueDetails = leagueDetails
        tableView.reloadData()
    }
}

extension EventTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return grouped.keys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let leagueName = Array(grouped.keys)[section]
        return grouped[leagueName]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leagueName = Array(grouped.keys)[indexPath.section]
        guard let eventsInLeague = grouped[leagueName] else { return UITableViewCell() }
        let eventData = eventsInLeague[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier) as? EventCell else {
            return UITableViewCell()
        }
        
        let eventViewModel = configureTeamEventAtributes(event: eventData)
        cell.set(event: eventViewModel)
        return cell
    }
}

extension EventTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let leagueName = Array(grouped.keys)[section]
        guard let league = leagueDetails[leagueName] else {
            return nil
        }

        let leagueView = createLeagueView(for: league)
        leagueView.backgroundColor = .white
        return leagueView
    }
    
    func configureTeamEventAtributes(event: Event) -> EventViewModel {
        var teamViewModel1 = TeamViewModel(name: event.homeTeam.name, score: event.homeScore)
        var teamViewModel2 = TeamViewModel(name: event.awayTeam.name, score: event.awayScore)
        
        teamViewModel1.image = imageUrlToUIImage(imageURL: event.homeTeam.logoUrl)!
        teamViewModel2.image = imageUrlToUIImage(imageURL: event.awayTeam.logoUrl)!
        
        teamViewModel1 = DataMapper.teamLoadColor(team: teamViewModel1, status: event.status, otherTeamGoal: event.awayScore)
        teamViewModel2 = DataMapper.teamLoadColor(team: teamViewModel2, status: event.status, otherTeamGoal: event.homeScore)
        
        let eventViewModel = EventViewModel(
            startTimeString: event.startTimestamp,
            statusString: event.status,
            homeTeam: teamViewModel1,
            awayTeam: teamViewModel2
        )
        
        return configureEventAtributes(event: eventViewModel)
    }

    private func createLeagueView(for league: League) -> LeagueView {
        let leagueImage = imageUrlToUIImage(imageURL: league.logoUrl)
        let leagueVM = LeagueViewModel(
            leagueName: league.name,
            countryName: league.country!.name,
            image: leagueImage ?? UIImage(systemName: "photo")!
        )
        let leagueView = LeagueView()
        leagueView.configure(with: leagueVM)
        return leagueView
    }
    
    private func configureEventAtributes(event: EventViewModel) -> EventViewModel {
        let returnEventViewModel = EventViewModel(
            startTimeString: event.startTimeString,
            statusString: event.statusString,
            homeTeam: event.homeTeam,
            awayTeam: event.awayTeam
        )
        return DataMapper.updateMinuteLabel(event: returnEventViewModel)
    }

    private func imageUrlToUIImage(imageURL: String?) -> UIImage? {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return nil }
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}
