🏋️ Calculadora de IMC — Flutter
Aplicación móvil desarrollada en Flutter para calcular el Índice de Masa Corporal (IMC) de una persona a partir de su peso y altura. Proyecto correspondiente a la Evaluación 2 de la asignatura Programación de Dispositivos Móviles — Institución Universitaria Pascual Bravo, Marzo 2026.

📱 Capturas de pantalla

La app corre en emulador Android (Pixel 6) desde Visual Studio Code.

<img width="533" height="930" alt="image" src="https://github.com/user-attachments/assets/310f01ce-2063-49ed-bcba-90ccdf7578c3" />
<img width="500" height="887" alt="image" src="https://github.com/user-attachments/assets/95ff062c-99df-475b-a825-7a9d8dee3fc2" />
<img width="498" height="892" alt="image" src="https://github.com/user-attachments/assets/42b89475-53a1-4255-9b93-38944c4485fa" />
<img width="499" height="872" alt="image" src="https://github.com/user-attachments/assets/7bf29588-40d1-44e5-acba-71c5431fc76e" />


🧮 ¿Cómo funciona?
La fórmula utilizada para calcular el IMC es:
IMC = peso (kg) / altura (m)²
Al presionar el botón "Calcular IMC", la aplicación toma los valores ingresados, aplica la fórmula y muestra el resultado con su categoría correspondiente.

📊 Categorías de IMC
Rango de IMCCategoríaÍconoColorIMC < 18.5Bajo peso🧊AzulIMC entre 18.5 y 24.9Peso normal✅VerdeIMC entre 25.0 y 29.9Sobrepeso⚠️RojoIMC ≥ 30.0Obesidad🚨Rojo oscuro

✅ Validaciones de los campos
Campo — Peso (kg)

❌ No puede estar vacío
❌ No acepta letras ni caracteres especiales (solo números y punto decimal)
❌ No acepta valores negativos ni cero
❌ No acepta más de 2 decimales
❌ No acepta valores fuera del rango 1 kg – 500 kg
✅ Muestra mensaje de ayuda: "Ingresa tu peso entre 1 y 500 kg"

Campo — Altura (m)

❌ No puede estar vacío
❌ No acepta letras ni caracteres especiales (solo números y punto decimal)
❌ No acepta valores negativos ni cero
❌ No acepta más de 2 decimales
❌ No acepta valores fuera del rango 0.5 m – 3.0 m
✅ Muestra mensaje de ayuda: "Ingresa tu altura entre 0.5 y 3.0 m"

Bloqueo de teclado
Se utiliza FilteringTextInputFormatter para bloquear en tiempo real cualquier entrada que no sea un número válido con hasta 2 decimales. El usuario no puede escribir letras en ningún campo.

🎨 Características visuales
🎨 Color por categoría
El resultado (valor del IMC y categoría) cambia de color automáticamente según la categoría calculada, usando los colores definidos en la tabla anterior.
😊 Ícono por categoría
Al mostrar el resultado, aparece un emoji representativo grande encima del texto que indica visualmente el estado de salud del usuario.
📊 Barra de progreso del IMC
Se muestra una barra de progreso horizontal que indica la posición del IMC calculado dentro de una escala del 10 al 40. La barra adopta el color de la categoría correspondiente y tiene marcas en los valores clave: 10 — 18.5 — 25 — 30 — 40.
🔄 Botón de reseteo
Un botón con ícono de refresco (🔄) al lado del botón principal permite limpiar todos los campos y el resultado con un solo clic.
