## Introducción
 En esta sección compartimos los notebooks correspondientes a la presentación y sintáxis básica de `Julia`.
 La descripción y contenido de los notebooks es la siguiente:
 - `S1-IntroJulia.ipynb`
 Sintaxis básica de Julia, lo que uno necesita para poder hacer cuentitas básicas con `Julia` e ir conociendo cómo funciona, recorriendo las siguientes secciones
   - Definición de variables
   - Operadores matemáticos
   - Tipos de datos numéricos
   - Aritmética de precisión arbitraria
   - Cadenas
   - Condicionales
   - Corto circuito
   - Ciclos
   - Estructuras de datos
   - Arreglos y operaciones con éstos.

 - `S2-IntroJulia.ipynb`
 Sintaxis básica de `Julia`, que ahora que conocemos lo muy básico, podemos empezar a darle un poco más de forma a un programa hecho con este lenguaje de programación, recorriendo las siguientes secciones: 
   - Funciones. 
   - Funciones y qué argumentos admiten.
   - Funciones mutables vs. No-mutables
   - Funciones de orden superior
   - Operadores como funciones
   - Despacho múltiple básico.
   - Tipos de datos definidos por el usuario
   - Definición de operaciones para datos definidos por el usuario.

 - `S3-ObjetosEstructuras.ipynb`
 Ya que sabemos lo básico de `Julia` y un poco más, podemos empezar a hondear en el despacho múltiple y la creación de estructuras, lo que remplaza a la programación orientada a objetos y sobre por qué esta metodología es más *Juliana*.
   - Diferencia entre objetos y estructuras
   - Definiendo tipos de datos en `Julia`
   - Definición de tipos de datos parametrizados

 - `S4-JuliaEsRapido.ipynb`
 Microbenchmarks para mostrar la velocidad de `Julia` comparado con otros lenguajes de programación
   - Definiendo la función suma
   - Introducción sobre la *macro* de benchmarking
   - Midiendo algunos tiempos con la función `sum` de `julia` y a mano con un ciclo.
   - Usando el lenguaje `C` desde `Julia`.
   - Midiendo tiempos de `C`
   - Usando `python` desde `Julia` y midiendo tiempo
   - Usando `numpy` en `python` desde `Julia`

 - `S5-CodigoEficiente.ipynb`
 Recetas para hacer código `Julia` (aún) más eficiente
   - Evitar tipos de datos abstractos
   - Evitar variables de ámbito global
   - Prealojamiento de memoria
   - Operaciones vectorizadas
   - Reutilizar la memoria
   - Vistas de datos
   - Revisión del código que se genera.

 - `S5-OtrasFuncionalidades.ipynb`
 Se ejemplifica map, broadcasting y llamadas a código python desde Julia

 - `S7-EjemploNumérico.ipynb`
 Se utiliza lo aprendido para implementar un algoritmo numérico
   - Algoritmo de Newton-Raphson
   - Newton-Raphson para funciones complejas.

 - `S8-OperacionesVectorizadas.ipynb`
 Se ilustra la vectorización de operaciones como principio de aceleraciónd ejecución y paralelismo
   - Un poco de teoría sobre la paralelización
   - Vectorización en `Julia`

También compartimos las diapositivas de introducción al curso.
 1. curso-taller-Julia-IIMAS2021-Intro. Presentación del curso-taller
 2. curso-taller-Julia-IIMAS2021-EasyFast. Se plantea el problema del segundo lenguaje.


Los contenidos de los notebooks y presentaciones toman como base las diversas conferencias y tutoriales de los Julianos más activos: Stefan Karpinsky, Jane Herriman, Matt Bauman, Huda Nassar y por supuesto el maestro David Sanders.
