import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {
    
    private let dataSource = Homework2DataSource()
    private var events: [Event] = []
    private let leagueView: LeagueView
    private let stackView = UIStackView()
    
    required init?(coder: NSCoder) {
        let league = Homework2DataSource().laLigaLeague
        self.leagueView = LeagueView(league: league())
        self.events = dataSource.laLigaEvents()
        super.init(coder: coder)
        populateEvents()
    }
    
    override func viewDidLoad() {

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
        for event in events {
            let eventView = EventView(event: event)
            stackView.addArrangedSubview(eventView)
        }
    }
}
