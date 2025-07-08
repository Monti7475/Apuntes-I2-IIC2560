# Ejercicios
En la I2 se incluirán ejercicios similares a los trabajados en clases y en los coding katas realizados después de la I1. También podrán aparecer ejercicios donde se solicite agregar nuevas operaciones a los ejemplos desarrollados durante el curso.

Por ejemplo, podrían pedir
- ~~Agregar la operación begin (o seqn) al meta-intérprete circular visto en clases.~~
- Modificar el operador refun presentado en clases que permitía el paso de parámetros por referenciapara que reciba N argumentos.
- ~~Crear una macro que transforme un switch case en una secuencia de if-then-else anidados. Proponga una sintaxis para el switch case según vea conveniente.~~
- ~~Modificar la macro new-object revisada en clases para que soporte getters, como se mostró en el coding kata 5.~~
- Modificar la macro CLASS para que incluya una operación que liste todos los nombres de los métodos, y además crear una macro que permita acceder a dicha operación de forma elegante, por ejemplo: (method-names class1).
- Escribir un ejemplo que demuestre que, al soportar mutación en un lenguaje, la suma deja de ser conmutativa (es decir, que no produce el mismo resultado evaluar primero la parte izquierda y luego la derecha, que hacerlo en orden inverso).

# Macros
- Herramienta que opera en el codigo fuente antes de evaluar (a diferencia de las funs)
- Ya que un macro opera/reescribe el codigo previo a su ejecucion, al trabajar con valores definidos (como a o b), al modificarlos se modificaran los originales
    - Si se hace en una funcion, es solo a nivel local. no se modifican los originales
# Objetos
- se definen a través de macros
  ```
  ([field nombre-campo valor-inicial] ...) ; definición de estado interno
  ([method nombre-método (parámetros ...) cuerpo ...] ...) ; métodos
  ```
# Self

- Se crea una variabke recursiva "self" en el define-syntax de un nuevo obj.
  - Este se refiere al mismo objeto, permitiendo que se use a sí mismo de argumento
  - Con esto los metodos pueden interactuar "entre si"











# Conceptos
 ### Funciones de orden superior
 Funciones que devuelven otras funciones o las reciben como argumentos.
 ### Mutabilidad
 uso de set! para mutar los datos


T.B.C