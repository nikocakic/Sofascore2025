import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {
    
    private let dataSource = Homework2DataSource()
    private var events: [EventViewModel] = []
    private lazy var leagueView: LeagueView = {
        let league = Homework2DataSource().laLigaLeague()
        let leagueImage = imageUrlToUIImage(imageURL: league.logoUrl)
        let leagueVM = LeagueViewModel(leagueName: league.name, countryName: league.country!.name, image: leagueImage ?? UIImage(systemName: "photo")!)
        return LeagueView(league: leagueVM)
    }()
    private let stackView = UIStackView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        populateEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews() {
        setupStackView()
        view.addSubview(leagueView) 
    }
    
    func styleViews() {
        view.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
    }

    func setupConstraints() {
        leagueView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(leagueView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func setupStackView() {
        view.addSubview(stackView)
    }

    private func populateEvents() {
        var eventViews: [EventView] = []
        for event in dataSource.laLigaEvents() {
            let homeNumGoals: Int? = event.status != .notStarted ? event.homeScore : nil
            let awayNumGoals: Int? = event.status != .notStarted ? event.awayScore : nil
            
            let homeTeamViewModel = configureTeamAtributes(team: event.homeTeam, numGoals: homeNumGoals)
            let awayTeamViewModel = configureTeamAtributes(team: event.awayTeam, numGoals: awayNumGoals)
            
            let eventViewModel = configureEventAtributes(event: event, homeTeam: homeTeamViewModel, awayTeam: awayTeamViewModel)
            
            let eventView = EventView(event: eventViewModel)
            eventViews.append(eventView)
        }

        for eventView in eventViews {
            stackView.addArrangedSubview(eventView)
        }
    }
    
    private func configureTeamAtributes(team: Team, numGoals: Int?) -> TeamViewModel {
        let teamImage = imageUrlToUIImage(imageURL: team.logoUrl)
        return TeamViewModel(image: teamImage ?? UIImage(systemName: "photo")!, name: team.name, score: numGoals)
    }
    
    private func imageUrlToUIImage(imageURL: String?) -> UIImage? {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return nil }
        
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    private func configureEventAtributes(event: Event, homeTeam: TeamViewModel, awayTeam: TeamViewModel) -> EventViewModel {
        return EventViewModel(startTimeString: event.startTimestamp, statusString: event.status, homeTeam: homeTeam, awayTeam: awayTeam)
    }
}
