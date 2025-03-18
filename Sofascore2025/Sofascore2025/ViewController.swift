import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let dataSource = Homework2DataSource()
    private var events: [Event] = []
    private var leagueViewController: LeagueViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        events = dataSource.laLigaEvents()
        setupLeagueViewController()
        setupTableView()
    }

    private func setupLeagueViewController() {
            let league = dataSource.laLigaLeague
        leagueViewController = LeagueViewController(league: league())

            guard let leagueVC = leagueViewController else { return }
            addChild(leagueVC)
            view.addSubview(leagueVC.view)

            leagueVC.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leagueVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                leagueVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                leagueVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                leagueVC.view.heightAnchor.constraint(equalToConstant: 56)
            ])
            leagueVC.didMove(toParent: self)
        }

    private func setupTableView() {
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 56

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        guard let leagueVC = leagueViewController else { return }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: leagueVC.view.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }

        let event = events[indexPath.row]
        cell.configure(with: event) 

        return cell
    }
}
