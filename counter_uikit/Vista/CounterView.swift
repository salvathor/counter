//
//  CounterView.swift
//  counter_uikit
//
//  Created by Salvador Lopez on 01/11/26.
//

// UIKit es el framework de Apple para construir interfaces en iOS.
// Nos da clases como UIView, UILabel, UIButton, etc.
import UIKit

// MARK: - Vista (la "V" del patrón MVC)
//
// CounterView se encarga SOLO de la parte gráfica: qué elementos hay en
// pantalla, cómo se ven y dónde se colocan.
// No sabe nada de la lógica del contador (eso lo hace el controlador).
//
// Hereda de UIView, que es la clase base de todo lo que se dibuja en pantalla.
class CounterView: UIView {

    // MARK: - Elementos de la interfaz

    // Texto que muestra el valor del contador.
    // No es "private" porque el controlador necesita acceder a ellos.
    let label = UILabel()

    // Botón que el usuario pulsa para incrementar el contador.
    // El tipo .system le da el estilo estándar de iOS (texto azul, efecto al pulsar).
    let button = UIButton(type: .system)

    // MARK: - Inicializadores

    // Este init se usa cuando creamos la vista desde código: CounterView()
    override init(frame: CGRect) {
        super.init(frame: frame) // Siempre llamamos primero al init de la clase padre
        setupView()              // Después configuramos nuestros elementos
    }

    // Este init es obligatorio en UIView. Se usa cuando la vista se crea
    // desde un Storyboard o un archivo .xib.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Métodos públicos

    // El controlador llama a este método cada vez que cambia el contador.
    // Así la vista se actualiza sin que el controlador toque directamente el diseño.
    func update(count: Int) {
        // Interpolación de cadenas: \(count) inserta el valor dentro del texto
        label.text = "Contador: \(count)"

        // Operador ternario: condición ? valorSiVerdadero : valorSiFalso
        // Si el número es par, el texto es azul; si es impar, rojo.
        label.textColor = count.isMultiple(of: 2) ? .systemBlue : .systemRed
    }

    // MARK: - Configuración interna

    // Método privado: solo se puede llamar desde dentro de esta clase.
    // Aquí creamos y colocamos todos los elementos visuales.
    private func setupView() {
        // .systemBackground es blanco en modo claro y negro en modo oscuro
        backgroundColor = .systemBackground

        // --- 1. Configurar el aspecto del label ---
        label.text = "Contador: 0"                                 // Texto inicial
        label.textAlignment = .center                              // Texto centrado
        label.font = .systemFont(ofSize: 24, weight: .semibold)   // Tamaño y grosor de letra
        label.textColor = .label                                   // Color de texto adaptable (claro/oscuro)

        // --- 2. Configurar el aspecto del botón ---
        // Un botón puede tener distintos títulos según su estado (.normal, .highlighted...)
        button.setTitle("Incrementar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)

        // --- 3. Preparar los elementos para Auto Layout ---
        // Por defecto UIKit coloca las vistas con posiciones fijas (frames).
        // Al ponerlo en false le decimos que usaremos constraints (reglas de posición).
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        // --- 4. Añadir los elementos a la vista ---
        // Si no hacemos addSubview, los elementos existen pero NO se ven en pantalla.
        addSubview(label)
        addSubview(button)

        // --- 5. Definir las constraints (reglas de posición y tamaño) ---
        // NSLayoutConstraint.activate activa todas las reglas de una sola vez.
        // Los "anchors" son los bordes y centros de cada vista.
        NSLayoutConstraint.activate([
            // Label: centrado horizontalmente y un poco por encima del centro vertical
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40), // -40 = 40 puntos hacia arriba
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),       // Ancho mínimo de 200
            label.heightAnchor.constraint(equalToConstant: 40),                    // Alto fijo de 40

            // Botón: 16 puntos debajo del label y centrado horizontalmente
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 160),  // Ancho fijo de 160
            button.heightAnchor.constraint(equalToConstant: 44)   // 44 es la altura mínima táctil recomendada por Apple
        ])
    }
}
