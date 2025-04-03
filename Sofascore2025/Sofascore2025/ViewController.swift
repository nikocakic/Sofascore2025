import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {

    private var selectedSportView: SportView?
    private let dataSource = Homework3DataSource()
    private var events: [Event] = []
    
    private var eventTableView = EventTableView()
    
    var grouped: [String: [Event]] = [:]
    var leagueDetails: [String: League] = [:]
    
    private var sportStackView = UIStackView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        getData()
        populateSports()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        eventTableView.updateData(grouped: grouped, leagueDetails: leagueDetails)
    }
    

    func addViews() {
        eventTableView = EventTableView()
        view.addSubview(sportStackView)
        view.addSubview(eventTableView)
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
        
        eventTableView.snp.makeConstraints {
            $0.top.equalTo(sportStackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func getData() {
        events = dataSource.events()
        for event in events {
            guard let league = event.league else { return  }
            let leagueName = league.name

            grouped[leagueName, default: []].append(event)
            if leagueDetails[leagueName] == nil {
                leagueDetails[leagueName] = event.league
            }
        }
        
    }

    private func populateSports() {
        let sportNames = ["Football", "Basketball", "Am. Football"]
        let imageNames = ["footballIcon", "basketballIcon", "amFootballIcon"]
        
        for i in 0..<sportNames.count {
            let sportView = SportView()
            let sportViewModel = SportLogoViewModel(
                image: UIImage(named: imageNames[i]) ?? UIImage(),
                sportName: sportNames[i],
                isSelected: i==0 ? true : false
            )
            if (i==0) {selectedSportView = sportView}
            sportView.configure(with: sportViewModel)
            
            sportView.backgroundColor = .headerBlue
            sportView.isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sportTapped(_:)))
            sportView.addGestureRecognizer(tapGesture)

            sportStackView.addArrangedSubview(sportView)
        }
    }

    @objc private func sportTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view as? SportView else { return }
        selectedSportView?.setSelected(false)
        tappedView.setSelected(true)
        selectedSportView = tappedView
    }
}
