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
    private let rigthLabel = UILabel()
    private let timeLabel = UILabel()
    private let minuteLabel = UILabel()
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let numHomeTeamGoalsLabel = UILabel()
    private let numAwayTeamGoalsLabel = UILabel()

    override func addViews() {
        addSubview(leftLabel)
        leftLabel.addSubview(minuteLabel)
        leftLabel.addSubview(timeLabel)
        addSubview(rigthLabel)
        rigthLabel.addSubview(homeTeamImageView)
        rigthLabel.addSubview(awayTeamImageView)
        rigthLabel.addSubview(homeTeamLabel)
        rigthLabel.addSubview(awayTeamLabel)
        rigthLabel.addSubview(numHomeTeamGoalsLabel)
        rigthLabel.addSubview(numAwayTeamGoalsLabel)
    }

    override func styleViews() {
        leftLabel.textAlignment = .center
        leftLabel.font = .headline
        leftLabel.textColor = .black
        
        rigthLabel.textAlignment = .center
        rigthLabel.font = .headline
        rigthLabel.textColor = .black

        timeLabel.textAlignment = .center
        timeLabel.font = .robotoRegularSize12
        timeLabel.textColor = .semiTransparentDark

        minuteLabel.textAlignment = .center
        minuteLabel.font = .robotoRegularSize12
        minuteLabel.textColor = .semiTransparentDark

        homeTeamLabel.font = .robotoRegularSize14
        homeTeamLabel.textAlignment = .left

        awayTeamLabel.font = .robotoRegularSize14
        awayTeamLabel.textAlignment = .left

        numHomeTeamGoalsLabel.font = .robotoRegularSize14
        numHomeTeamGoalsLabel.textAlignment = .right

        numAwayTeamGoalsLabel.font = .robotoRegularSize14
        numAwayTeamGoalsLabel.textAlignment = .right

        setupConstraints()
    }

    override func setupConstraints() {
        leftLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(rigthLabel.snp.leading)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(64)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalTo(leftLabel)
            $0.width.equalToSuperview().inset(4)
            $0.top.equalTo(leftLabel).offset(10)
        }

        minuteLabel.snp.makeConstraints {
            $0.centerX.equalTo(leftLabel)
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.width.equalToSuperview().inset(4)
        }

        homeTeamLabel.snp.makeConstraints {
            $0.trailing.equalTo(numHomeTeamGoalsLabel.snp.leading).offset(16)
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalToSuperview().inset(10)
        }

        awayTeamLabel.snp.makeConstraints {
            $0.trailing.equalTo(numAwayTeamGoalsLabel.snp.leading).offset(16)
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalTo(homeTeamLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(10)
        }

        homeTeamImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(16)
        }
        
        awayTeamImageView.snp.makeConstraints {
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(16)
        }
        
        numHomeTeamGoalsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }

        numAwayTeamGoalsLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        rigthLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(leftLabel.snp.trailing)
        }
        
    }

    func configure(with event: Event) {
        loadImage(from: event.homeTeam.logoUrl, into: homeTeamImageView)
        loadImage(from: event.awayTeam.logoUrl, into: awayTeamImageView)
        homeTeamLabel.text = event.homeTeam.name
        awayTeamLabel.text = event.awayTeam.name
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

    private func loadScores(from event: Event) {
        if event.status == .finished || event.status == .inProgress {
            numHomeTeamGoalsLabel.text = "\(event.homeScore ?? 0)"
            numAwayTeamGoalsLabel.text = "\(event.awayScore ?? 0)"
            if event.status == .inProgress {
                numHomeTeamGoalsLabel.textColor = .red
                numAwayTeamGoalsLabel.textColor = .red
            }
            guard let awayScore = event.awayScore, let homeScore = event.homeScore else { return }

            if awayScore > homeScore {
                homeTeamLabel.textColor = .semiTransparentDark
            }
            if awayScore < homeScore {
                awayTeamLabel.textColor = .semiTransparentDark
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
            minuteLabel.text = "HT"
        }
    }
}
