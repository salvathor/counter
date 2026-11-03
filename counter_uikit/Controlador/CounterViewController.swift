//
//  ViewController.swift
//  counter_uikit
//
//  Created by Salvador Lopez on 01/11/26.
//

import UIKit

class CounterViewController: UIViewController {
    private let label = UILabel()
    private let button = UIButton(type: .system)
    private var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url_servicio = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL")
        print(url_servicio!)
        
        view.backgroundColor = .systemBackground

        // Configuración de subviews y constraints
        label.text = "Contador: \(count)"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label

        button.setTitle("Incrementar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)

        // Desactivar autoresizing masks para usar Auto Layout
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        // Agregar subviews
        view.addSubview(label)
        view.addSubview(button)

        // Constraints: label centrado y botón debajo con tamaños fijos
        NSLayoutConstraint.activate([
            // Label centrado
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 40),

            // Botón debajo del label
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 160),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func incrementTapped() {
        count += 1
        // Cada vista afectada se actualiza a mano
        label.text = "Contador: \(count)"
        label.textColor = count.isMultiple(of: 2) ? .systemBlue : .systemRed
    }
}

