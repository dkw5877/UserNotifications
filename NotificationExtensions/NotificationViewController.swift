//
//  NotificationViewController.swift
//  NotificationExtensions
//
//  Created by user on 9/28/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var smallImageView: UIImageView!
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 81/255.0, green: 123/255.0, blue: 172/255.0, alpha: 1)
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinBackground(backgroundView, to: stackView)
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func didReceive(_ notification: UNNotification) {
        
        let content = notification.request.content
        print(content)
        
        if let attachment = content.attachments.first {
            if attachment.url.startAccessingSecurityScopedResource() {
                attachment.url.stopAccessingSecurityScopedResource()
            }
        }
    }

}
