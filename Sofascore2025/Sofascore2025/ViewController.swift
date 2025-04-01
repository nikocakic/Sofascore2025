import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {
    
    private var selectedSportView: SportView?
    private let dataSource = Homework3DataSource()
    private var events: [Event] = []
    
    private var tableView = UITableView()
    
    var grouped: [String: [Event]] = [:]
    var leagueData: [String: League] = [:]
    private var leagueDetails: [String: League] = [:]

    private var sportStackView = UIStackView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        getData()
        populateSports()
        populateTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews() {
        view.addSubview(sportStackView)
        view.addSubview(tableView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        sportStackView.axis = .horizontal
        sportStackView.distribution = .fillEqually
    }

    func setupConstraints() {
        sportStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(sportStackView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func getData() {
        events = dataSource.events()
        for event in events {
            let leagueName = event.league!.name
            grouped[leagueName, default: []].append(event)
            if leagueDetails[leagueName] == nil {
                leagueDetails[leagueName] = event.league
            }
        }
        tableView.reloadData()
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

    private func populateSports() {
        let sportNames = ["Football", "Basketball", "Am. Football"]
        let imageNames = ["footballIcon", "basketballIcon", "amFootballIcon"]
        
        for i in 0..<sportNames.count {
            let sportView = SportView()
            let sportViewModel = SportLogoViewModel(
                image: UIImage(named: imageNames[i])!,
                sportName: sportNames[i],
                isSelected: i==0 ? true : false
            )
            if (i==0) {selectedSportView=sportView}
            sportView.configure(with: sportViewModel)
            
            sportView.backgroundColor = .headerBlue
            sportView.isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sportTapped(_:)))
            sportView.addGestureRecognizer(tapGesture)

            sportStackView.addArrangedSubview(sportView)
        }
    }

    private func populateTable() {
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func configureTeamEventAtributes(event: Event) -> EventViewModel {
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

    private func imageUrlToUIImage(imageURL: String?) -> UIImage? {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return nil }
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            return image
        }
        return nil
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
    
    @objc private func sportTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view as? SportView else { return }
        selectedSportView?.setSelected(false)
        tappedView.setSelected(true)
        selectedSportView = tappedView
    }
}

extension ViewController: UITableViewDataSource {
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
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let leagueName = Array(grouped.keys)[section]
        guard let league = leagueDetails[leagueName] else {
            return nil
        }

        let leagueView = createLeagueView(for: league)
        leagueView.backgroundColor = .white
        return leagueView
    }
}
