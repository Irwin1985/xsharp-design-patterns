# xsharp-design-patterns


# Adapter
El patrón Adapter es un patrón de diseño estructural que permite la colaboración de objetos con interfaces incompatibles. Actúa como un puente entre dos objetos, adaptando la interfaz de uno para que sea compatible con la del otro.

## Casos de Uso

El patrón Adapter es útil en las siguientes situaciones:

- **Integración de sistemas heredados:** Cuando necesitas utilizar una clase antigua con una interfaz diferente a la que espera tu código moderno.
- **Adaptación de bibliotecas de terceros:** Cuando quieres utilizar una biblioteca que tiene una interfaz incompatible con tu aplicación.
- **Creación de interfaces genéricas:** Cuando quieres proporcionar una interfaz uniforme para diferentes tipos de objetos.

## Ejemplo de Caso de Uso
Imagina que tienes una biblioteca de cálculo matemática que utiliza funciones trigonométricas en radianes, pero tu aplicación requiere trabajar con grados. Puedes crear un adaptador que convierta los grados a radianes y llame a las funciones de la biblioteca.

## Beneficios
- Aumenta la reutilización de código.
- Mejora la flexibilidad y extensibilidad.
- Facilita la integración de sistemas.
- Aísla el código cliente de los cambios en la interfaz del objeto adaptado.

## Desventajas
- Puede añadir complejidad al sistema.
- Puede reducir el rendimiento debido a la capa de adaptación adicional.

# Bridge
El patrón Bridge es un patrón de diseño estructural que desacopla una abstracción de su implementación, permitiendo que ambos varíen independientemente. En esencia, divide la lógica de negocio o una clase compleja en dos jerarquías de clases separadas:

- **Abstracción:** Define la interfaz de alto nivel y mantiene una referencia a una implementación.
- **Implementación:** Define la interfaz para implementar la funcionalidad.

## Casos de Uso
El patrón Bridge es especialmente útil en las siguientes situaciones:

- **Aplicaciones multiplataforma:** Cuando necesitas adaptar la implementación a diferentes plataformas sin afectar la interfaz de alto nivel.
- **Sistemas con múltiples implementaciones:** Cuando quieres poder cambiar la implementación de un componente en tiempo de ejecución.
- **Lógica compleja:** Cuando una clase está creciendo demasiado y necesita ser dividida en partes más manejables.

## Beneficios
- Aumenta la reutilización de código.
- Mejora la extensibilidad y mantenibilidad.
- Desacopla la abstracción de la implementación.
- Permite cambios independientes en ambas jerarquías.

## Desventajas
Puede añadir complejidad al diseño.
Requiere una comprensión más profunda de los patrones de diseño.

# Factory Method
El patrón Factory Method es un patrón de diseño creacional que resuelve el problema de crear objetos sin especificar sus clases concretas. En lugar de instanciar objetos directamente, se delega la creación a subclases que implementan un método de fábrica.

## Casos de Uso
El patrón Factory Method es útil en las siguientes situaciones:

- **Abstracción de la creación de objetos:** Cuando quieres ocultar la lógica de creación de objetos al cliente.
- **Extensibilidad:** Cuando quieres permitir la creación de nuevos tipos de productos sin modificar el código del cliente.
- **Jerarquías de clases:** Cuando tienes una jerarquía de clases y quieres delegar la creación de objetos a las subclases.

## Beneficios
- Aumenta la flexibilidad y extensibilidad.
- Desacopla el cliente de la implementación concreta.
- Facilita la introducción de nuevos tipos de productos.

## Desventajas
- Puede añadir una capa de abstracción adicional.

# Prototype
El patrón Prototype es un patrón de diseño creacional que permite clonar objetos, incluso complejos, sin acoplarse a sus clases específicas. En lugar de crear objetos desde cero, se crea un prototipo inicial y se clonan nuevos objetos a partir de él.

## Casos de Uso
El patrón Prototype es útil en las siguientes situaciones:

- **Creación de objetos complejos:** Cuando la creación de objetos es costosa o compleja.
- **Clonación de objetos con estado inicial:** Cuando necesitas crear múltiples objetos con el mismo estado inicial.
- **Sistemas configurables:** Cuando quieres permitir a los usuarios personalizar objetos antes de clonarlos.
## Beneficios
- Mejora el rendimiento al evitar la creación de objetos desde cero.
- Aumenta la flexibilidad al permitir la clonación de objetos complejos.
- Reduce el acoplamiento entre el cliente y las clases concretas.

## Desventajas
- Puede ser difícil implementar la clonación profunda para objetos complejos.
- Puede aumentar la complejidad del código.

# Singleton (Sencillo)
El patrón Singleton garantiza que solo exista una instancia de una clase y proporciona un punto de acceso global a ella.

Explicación del Código
**Singleton class:**

El constructor es privado para prevenir la creación de instancias desde fuera de la clase.
Una variable estática privada **_instance** almacena la única instancia.
El método estático `GetInstance()` devuelve la instancia existente o crea una nueva si no existe.

**Program class:**
Demuestra el uso del patrón creando dos referencias a la instancia Singleton y verificando si son iguales.

## Importante Consideración: Seguridad en Hilos
El código presentado no es seguro para hilos. Si múltiples hilos intentan acceder al Singleton simultáneamente, puede resultar en la creación de múltiples instancias. Para garantizar la seguridad en hilos, se deben utilizar técnicas de sincronización o construcciones de lenguaje que proporcionen seguridad inherente.

## Casos de Uso
El patrón Singleton es útil en las siguientes situaciones:

- **Acceso global a un objeto:** Cuando necesitas un único punto de acceso a un recurso compartido.
- **Control de instancias:** Cuando quieres limitar el número de instancias de una clase a una.
- **Manejo de configuraciones:** Cuando necesitas almacenar configuraciones globales.

## Beneficios
- Garantiza una única instancia de una clase.
- Proporciona un punto de acceso global controlado.

## Desventajas
- Puede dificultar las pruebas unitarias.
- Puede violar los principios de diseño orientado a objetos.
