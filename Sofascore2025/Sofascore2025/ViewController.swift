import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    private let dataSource = Homework2DataSource()
    private var events: [Event] = []
    private var leagueView: LeagueView?
    private let stackView = UIStackView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        events = dataSource.laLigaEvents()
        setupLeagueView()
        setupStackView()
        populateEvents()
    }

    private func setupLeagueView() {
        let league = dataSource.laLigaLeague
        leagueView = LeagueView(league: league())

        guard let leagueView = leagueView else { return }
        view.addSubview(leagueView)

        leagueView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            guard let leagueView = leagueView else { return }
            make.top.equalTo(leagueView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func populateEvents() {
        for event in events {
            let eventView = EventView(event: event)
            stackView.addArrangedSubview(eventView)

            eventView.snp.makeConstraints { make in
                make.height.equalTo(56)
            }
        }
    }
}
