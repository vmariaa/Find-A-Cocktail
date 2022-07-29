//
//  CocktailCell.swift
//  FindACocktail
//
//  Created by Vanda S. on 26/07/2022.
//

import UIKit

class CocktailCell: UITableViewCell {

    static let identifier = "CocktailCell"
    var dataTask: URLSessionDataTask!
    
    var cellBackground: UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    var cocktailImageView: UIImageView = {
        let cocktailImage = UIImageView()
        cocktailImage.translatesAutoresizingMaskIntoConstraints = false
        return cocktailImage
    }()
    
    var cocktailLabel: UILabel = {
        let cocktailName = UILabel()
        cocktailName.translatesAutoresizingMaskIntoConstraints = false
        cocktailName.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        cocktailName.numberOfLines = 3
        cocktailName.numberOfLines = 3
        cocktailName.minimumScaleFactor = 0.3
        cocktailName.adjustsFontSizeToFitWidth = true
        return cocktailName
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let dataTask = dataTask {
            dataTask.cancel()
        }
        dataTask = nil
        cocktailImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setBackground()
        setCocktailImageView()
        setCocktailLabel()
        setActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCocktailImageView() {
        contentView.addSubview(cocktailImageView)
        
        cocktailImageView.layer.cornerRadius = 10
        cocktailImageView.clipsToBounds = true
        cocktailImageView.contentMode = .scaleAspectFill
        
        cocktailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        cocktailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        cocktailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        cocktailImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setCocktailLabel() {
        contentView.addSubview(cocktailLabel)
        
        cocktailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cocktailLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        cocktailLabel.leftAnchor.constraint(equalTo: cocktailImageView.rightAnchor, constant: 20).isActive = true
        cocktailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50).isActive = true
    }
    
    func setActivityIndicator() {
        contentView.addSubview(activityIndicator)

        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -35).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 10).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    func setBackground() {
        contentView.addSubview(cellBackground)
        
        cellBackground.backgroundColor = UIColor(named: "CellColor")!.withAlphaComponent(0.6)
        cellBackground.layer.cornerRadius = 13
        cellBackground.layer.shadowColor = UIColor(named: "ShadowColor")!.cgColor
        cellBackground.layer.shadowOffset = CGSize(width: 4, height: 4)
        cellBackground.layer.shadowRadius = 4
        cellBackground.layer.shadowOpacity = 0.2
        
        cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        cellBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        cellBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
    }

    
    func getPreviewImage(url: URL, session: URLSession) {
        let activityIndicator = UIActivityIndicatorView()
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: cocktailImageView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: cocktailImageView.centerXAnchor).isActive = true
        
        activityIndicator.startAnimating()
     
        let urlRequest = URLRequest(url: url)

        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
                if let error =  error {
                    print (error.localizedDescription)
                    return
                }
                guard let data = data  else { return }
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.cocktailImageView.image = image
                    activityIndicator.stopAnimating()
                }
            }
            task.resume()
            dataTask = task
        }
}
