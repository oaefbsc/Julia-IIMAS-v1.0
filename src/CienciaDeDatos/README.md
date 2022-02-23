## Ciencia de Datos

En esta sección se presenta una visión general de lo que comúnmente se hace en un proyecto escolar de Ciencia de Datos, tomando en cuenta la lectura, análisis y transformación de los datos, de modo que después nos sea posible hacer predicción mediante aprendizaje automático y aprendizaje profundo.
La sección se divide en estas tres partes y se abordan por separado, pensando en que cada notebook es independiente de otro y no se necesita correr uno para que otro funcione.
  - **Manejo de Datos**
  El manejo de datos es indispensable para cualquier lenguaje de programación que se piense para hacer Ciencia de Datos, y `Julia` no se queda atrás con ello y es por ello que en este notebook se tocan los temas más importantes sobre el manejo de datos en este lenguaje de programación:
    - Lectura de archivos `.csv`
    - Lectura de archivos `.csv` y los problemas que te puedes encontrar en el camino. 
    - Creación de **DataFrames** desde un archivo `.csv` o desde cero.
    - Operaciones básicas sobre un DataFrame.
    
  - **Aprendizaje Automático**
  El aprendizaje automático ha tomado popularidad en los últimos años debido a su amplio espectro de áreas en las que puede ser aplicado y la gente busca lenguajes de programación en donde se pueda relaizar este tipo de prácticas, `Julia` es uno de éstos y aquí se muestran algunas de las cosas que podemos hacer de esta área.
    - La paquetería de `MLJ.jl`, que conjunta muchas herramientas de aprendizaje automático que tiene el ecosistema de Julia. 
    - Técnicas de aprendizaje **no supervisado**, tales como **PCA** y **Agrupamiento**.
    - Técnicas de aprendizaje **supervisado**, tales como **KNN** y **Árboles de decisión**.
    
  - **Aprendizaje Profundo**
  El aprendizaje profundo es el área más *sexy* que tiene la ciencia de datos y `Julia` tiene su propia interface para poder crear redes neuronales profundas sin tanta complicación. En este rubro tocamos los siguientes temas al respecto: 
    - La paquetería `Flux.jl`
    - Importación de datos **MNIST**
    - Construcción de la arquitectura de la red para predicción de datos. **Entrenamiento** y **pruebas** del modelo.
