import UIKit
import SnapKit
import SofaAcademic

final class EventView: BaseView {
    
    private let event: Event

    public init(event: Event) {
        self.event = event
        super.init()
        configure(with: event)
    }
    
    private let homeTeamImageView = UIImageView()
    private let awayTeamImageView = UIImageView()
    private let leftLabel = UILabel()
    private let timeLabel = UILabel()
    private let minuteLabel = UILabel()
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let numHomeTeamGoalsLabel = UILabel()
    private let numAwayTeamGoalsLabel = UILabel()
    private let mainView = UIView()
    private let mainStackView = UIStackView()

    internal override func addViews() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.addSubview(homeTeamImageView)
        mainView.addSubview(leftLabel)
        mainView.addSubview(awayTeamImageView)
        mainView.addSubview(timeLabel)
        mainView.addSubview(minuteLabel)
        mainView.addSubview(homeTeamLabel)
        mainView.addSubview(awayTeamLabel)
        mainView.addSubview(numHomeTeamGoalsLabel)
        mainView.addSubview(numAwayTeamGoalsLabel)
        
        mainStackView.addArrangedSubview(mainView)

        styleViews()
    }

    internal override func styleViews() {
        homeTeamImageView.contentMode = .scaleAspectFit
        homeTeamImageView.clipsToBounds = true

        awayTeamImageView.contentMode = .scaleAspectFit
        awayTeamImageView.clipsToBounds = true

        leftLabel.textAlignment = .center
        leftLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        leftLabel.textColor = .black

        timeLabel.textAlignment = .center
        timeLabel.textColor = .black
        timeLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        timeLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)

        minuteLabel.textAlignment = .center
        minuteLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        minuteLabel.textColor = .black
        minuteLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)

        homeTeamLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        homeTeamLabel.textAlignment = .left

        awayTeamLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        awayTeamLabel.textAlignment = .left

        numHomeTeamGoalsLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        numHomeTeamGoalsLabel.textAlignment = .right

        numAwayTeamGoalsLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        numAwayTeamGoalsLabel.textAlignment = .right

        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.alignment = .fill

        setupConstraints()
    }

    internal override func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(leftLabel)
            make.width.equalTo(56)
            make.top.equalTo(leftLabel).offset(10)
        }

        minuteLabel.snp.makeConstraints { make in
            make.centerX.equalTo(leftLabel)
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.width.equalTo(56)
        }

        leftLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainView)
            make.width.equalTo(64)
        }

        homeTeamLabel.snp.makeConstraints { make in
            make.width.equalTo(192)
            make.leading.equalTo(leftLabel.snp.trailing).offset(40)
            make.top.equalTo(mainView).offset(10)
        }

        awayTeamLabel.snp.makeConstraints { make in
            make.width.equalTo(192)
            make.leading.equalTo(leftLabel.snp.trailing).offset(40)
            make.top.equalTo(homeTeamLabel.snp.bottom).offset(4)
        }

        homeTeamImageView.snp.makeConstraints { make in
            make.top.equalTo(mainView).offset(10)
            make.leading.equalTo(leftLabel.snp.trailing).offset(16)
            make.width.height.equalTo(16)
        }
        
        awayTeamImageView.snp.makeConstraints { make in
            make.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            make.leading.equalTo(leftLabel.snp.trailing).offset(16)
            make.width.height.equalTo(16)
        }
        
        numHomeTeamGoalsLabel.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.top.equalTo(mainView).offset(10)
            make.trailing.equalTo(mainView).offset(-10)
        }

        numAwayTeamGoalsLabel.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.bottom.equalTo(mainView).offset(-10)
            make.trailing.equalTo(mainView).offset(-10)
        }

        mainView.snp.makeConstraints { make in
            make.width.equalTo(360)
        }
    }

    func configure(with event: Event) {
        loadImage(from: event.homeTeam.logoUrl, into: homeTeamImageView)
        loadImage(from: event.awayTeam.logoUrl, into: awayTeamImageView)
        loadHomeTeamName(from: event.homeTeam)
        loadAwayTeamName(from: event.awayTeam)
        updateMinuteLabel(from: event.status, timestamp: event.startTimestamp)
        loadScores(from: event)
    }

    private func loadImage(from urlString: String?, into imageView: UIImageView) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = UIImage(systemName: "photo")
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }

    private func loadHomeTeamName(from team: Team) {
        homeTeamLabel.text = team.name
    }

    private func loadAwayTeamName(from team: Team) {
        awayTeamLabel.text = team.name
    }

    private func loadScores(from event: Event) {
        if event.status == .finished || event.status == .inProgress {
            numHomeTeamGoalsLabel.text = "\(event.homeScore ?? 0)"
            numAwayTeamGoalsLabel.text = "\(event.awayScore ?? 0)"
            if event.status == .inProgress {
                numHomeTeamGoalsLabel.textColor = .red
                numAwayTeamGoalsLabel.textColor = .red
            }
            guard let awayScore = event.awayScore, let homeScore = event.homeScore else { return }

            if awayScore > homeScore{
                homeTeamLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
            }
            if awayScore < homeScore{
                awayTeamLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
            }
            
        }
    }

    private func updateMinuteLabel(from status: EventStatus, timestamp: Int) {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: date)

        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)

        switch status {
        case .notStarted:
            minuteLabel.text = "-"
        case .inProgress:
            minuteLabel.text = "\(minute)'"
            minuteLabel.textColor = .red
        case .finished:
            minuteLabel.text = "FT"
        case .halftime:
            minuteLabel.text = "w/e"
        }
    }
}
