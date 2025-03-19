import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {
    
    private let dataSource = Homework2DataSource()
    private var events: [Event] = []
    private var leagueView: LeagueView?
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        events = dataSource.laLigaEvents()

        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
    }
    
    
    func addViews() {
        setupLeagueView()
        setupStackView()
        populateEvents()
    }
    
    func styleViews() {
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
    }

    func setupConstraints() {
        guard let leagueView = leagueView else { return }
        
        leagueView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(leagueView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        for eventView in stackView.arrangedSubviews {
            eventView.snp.makeConstraints { make in
                make.height.equalTo(56)
            }
        }
    }
    
    func setupGestureRecognizers() {
    }
    

    private func setupLeagueView() {
        let league = dataSource.laLigaLeague
        leagueView = LeagueView(league: league())

        guard let leagueView = leagueView else { return }
        view.addSubview(leagueView)
    }

    private func setupStackView() {
        view.addSubview(stackView)
    }

    private func populateEvents() {
        for event in events {
            let eventView = EventView(event: event)
            stackView.addArrangedSubview(eventView)
        }
    }
}
