//
//  ViewController.swift
//  counter_uikit
//
//  Created by Salvador Lopez on 01/11/26.
//

import UIKit

// MARK: - Controlador (la "C" del patrón MVC)
//
// CounterViewController es el "cerebro" de la pantalla:
// - Guarda el estado (el valor del contador).
// - Responde a las acciones del usuario (pulsar el botón).
// - Le dice a la vista cuándo debe actualizarse.
//
// La parte gráfica NO está aquí: está en CounterView (carpeta Vista).
// Hereda de UIViewController, la clase base de las pantallas en UIKit.
class CounterViewController: UIViewController {

    // MARK: - Propiedades

    // Instancia de nuestra vista personalizada.
    // "let" porque la vista siempre será la misma (no la reemplazamos).
    private let counterView = CounterView()

    // Estado de la pantalla: el número actual del contador.
    // "var" porque su valor cambia cada vez que se pulsa el botón.
    private var count = 0

    // MARK: - Ciclo de vida

    // loadView() es el lugar donde el controlador crea su vista principal.
    // Lo sobrescribimos para usar CounterView en lugar de una UIView vacía.
    // Importante: aquí NO se llama a super.loadView().
    override func loadView() {
        // La parte gráfica vive en CounterView (carpeta Vista)
        view = counterView
    }

    // viewDidLoad() se ejecuta UNA vez, justo después de cargar la vista.
    // Es el sitio típico para conectar acciones y hacer configuración inicial.
    override func viewDidLoad() {
        super.viewDidLoad() // Siempre llamamos al método de la clase padre
        
        // Leemos un valor del Info.plist (definido en los archivos .xcconfig QA/PRD).
        // Esto permite usar una URL distinta según el entorno de compilación.
        // Nota: el "!" fuerza el desempaquetado; si la clave no existe, la app se cierra.
        var url_servicio = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL")
        print(url_servicio!)

        // Conectamos el botón con el método incrementTapped (patrón Target-Action):
        // - target: quién recibe el evento (self = este controlador)
        // - action: qué método se ejecuta
        // - for: qué evento lo dispara (.touchUpInside = tocar y soltar dentro del botón)
        counterView.button.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)
    }

    // MARK: - Acciones

    // Se ejecuta cada vez que el usuario pulsa el botón.
    // @objc es necesario porque #selector usa el sistema de mensajes de Objective-C.
    @objc private func incrementTapped() {
        // 1. Actualizamos el estado (modelo de datos)
        count += 1

        // 2. Le pedimos a la vista que muestre el nuevo valor
        counterView.update(count: count)
    }
}

