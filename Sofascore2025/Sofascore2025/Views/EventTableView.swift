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
    
    private func createLeagueView(for league: League) -> LeagueView {
        let leagueVM = LeagueViewModel(league: league)
        let leagueView = LeagueView()
        leagueView.configure(with: leagueVM)
        leagueView.backgroundColor = .white
        return leagueView
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
        
        let eventViewModel = EventViewModel(event: eventData)
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
        return leagueView
    }
}
