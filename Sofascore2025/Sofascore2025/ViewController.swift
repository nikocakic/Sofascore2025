import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {
    
    private var selectedSportView: SportView?
    private let dataSource = Homework2DataSource()
    private var events: [EventViewModel] = []
    private lazy var leagueView: LeagueView = {
        let league = Homework2DataSource().laLigaLeague()
        let leagueImage = imageUrlToUIImage(imageURL: league.logoUrl)
        let leagueVM = LeagueViewModel(leagueName: league.name, countryName: league.country!.name, image: leagueImage ?? UIImage(systemName: "photo")!)
        let leagueView = LeagueView()
        leagueView.configure(with: leagueVM)
        return leagueView
    }()
    private let stackView = UIStackView()
    private var sportStackView = UIStackView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        populateEvents()
        populateSports()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews() {
        view.addSubview(sportStackView)
        view.addSubview(stackView)
        view.addSubview(leagueView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        sportStackView.axis = .horizontal
        sportStackView.distribution = .fillEqually
    }

    func setupConstraints() {
        
        sportStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        
        leagueView.snp.makeConstraints {
            $0.top.equalTo(sportStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(leagueView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func populateEvents() {
        var eventViews: [EventView] = []
        for event in dataSource.laLigaEvents() {

            let eventViewModel = configureTeamEventAtributes(event: event)
            
            let eventView = EventView()
            
            eventView.configure(with: eventViewModel)
            eventViews.append(eventView)
        }

        for eventView in eventViews {
            stackView.addArrangedSubview(eventView)
        }
    }
    
    private func populateSports(){
        let sportNames: [String] = ["Football", "Basketball", "Am. Football"]
        let imageNames: [String] = ["footballIcon", "basketballIcon", "amFootballIcon"]
        
        for i in 0...2 {
            let sportView = SportView()
            let sportViewModel = SportLogoViewModel(image: UIImage(named: imageNames[i])!, sportName: sportNames[i])
            sportView.configure(with: sportViewModel)
            
            sportView.backgroundColor = .headerBlue
            
            sportView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sportTapped(_:)))
            sportView.addGestureRecognizer(tapGesture)

            sportStackView.addArrangedSubview(sportView)
        }
    }
    
    private func configureTeamEventAtributes(event: Event) -> EventViewModel {
        var teamViewModel1 = TeamViewModel(name: event.homeTeam.name, score: event.homeScore)
        var teamViewModel2 = TeamViewModel(name: event.awayTeam.name, score: event.awayScore)
        
        teamViewModel1.image = imageUrlToUIImage(imageURL: event.homeTeam.logoUrl)!
        teamViewModel2.image = imageUrlToUIImage(imageURL: event.awayTeam.logoUrl)!
        
        teamViewModel1 = DataMapper.teamLoadColor(team: teamViewModel1, status: event.status, otherTeamGoal: event.awayScore)
        teamViewModel2 = DataMapper.teamLoadColor(team: teamViewModel2, status: event.status, otherTeamGoal: event.homeScore)
        
        var eventViewModel = EventViewModel(startTimeString: event.startTimestamp, statusString: event.status, homeTeam: teamViewModel1, awayTeam: teamViewModel2)
        eventViewModel = configureEventAtributes(event: eventViewModel)
        
        return eventViewModel
    }
    
    private func imageUrlToUIImage(imageURL: String?) -> UIImage? {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return nil }
        
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    private func configureEventAtributes(event: EventViewModel) -> EventViewModel {
        var returnEventViewModel = EventViewModel(startTimeString: event.startTimeString, statusString: event.statusString, homeTeam: event.homeTeam, awayTeam: event.awayTeam)
        
        returnEventViewModel = DataMapper.updateMinuteLabel(event: returnEventViewModel)
        
        return returnEventViewModel
    }
    @objc private func sportTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view as? SportView else { return }

        selectedSportView?.backgroundColor = .headerBlue
        
        tappedView.backgroundColor = .red
        selectedSportView = tappedView
    }

}

