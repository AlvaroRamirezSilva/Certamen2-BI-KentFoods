Certamen 2 - Inteligencia de Negocios
Caso Seleccionado
Kent Foods - Empresa de venta y envío de alimentos.

Integrantes
Álvaro Ramírez Silva

Moisés Larenas Arévalo

Ignacio Miranda

Descripción del Problema y Objetivo del Proyecto
Kent Foods ha experimentado un crecimiento rápido en los últimos años. Debido a esta expansión, el propietario necesita incorporar Inteligencia de Negocios para analizar los datos transaccionales generados (órdenes, clientes, envíos, productos) y apoyar el proceso de toma de decisiones estratégicas para mantener el buen rumbo de la organización. El objetivo de este proyecto es diseñar e implementar una solución BI completa, comenzando con un modelo dimensional y un proceso ETL (Fase 1).

KPI Definidos
Para evaluar el desempeño de Kent Foods, se definieron los siguientes Indicadores Clave de Desempeño:

Ingresos Totales por Ventas: Permite evaluar el rendimiento financiero y el crecimiento de la empresa analizando las ventas por producto, territorio y cliente.

Volumen de Órdenes Procesadas: Mide la carga operativa y la demanda, fundamental para la planificación logística y de inventario.

Eficiencia en Tiempos de Envío (Días de Despacho): Mide la diferencia en días entre la fecha de la orden y la fecha de envío, lo que permite evaluar el rendimiento de los transportistas y la satisfacción del cliente final.

Modelo Dimensional (Metodología Kimball)
Se aplicaron los 4 pasos de Ralph Kimball para el diseño del modelo dimensional en esquema de estrella:

Selección del Proceso de Negocio: Gestión de Ventas y Envíos de productos.

Definición de la Granularidad: El nivel de detalle máximo corresponde a una línea de artículo dentro de una orden de compra (registro a nivel de detalle de orden).

Identificación de las Dimensiones:

Dim_Cliente (Datos demográficos y de contacto del comprador).

Dim_Empleado (Personal interno que gestiona la orden).

Dim_Producto (Detalle del alimento vendido y su categoría).

Dim_Proveedor (Origen de los productos).

Dim_Transportista (Empresa a cargo del envío).

Dim_Territorio (Ubicación geográfica de operaciones).

Dim_Tiempo (Dimensión artificial para analizar fechas de orden y envío).

Identificación de los Hechos (Medidas):

Cantidad de productos.

Precio Unitario.

Descuento.

Monto Total (calculado).

Días de envío (calculado).

Proceso ETL (Fase 1)
El proceso de Extracción, Transformación y Carga (ETL) fue implementado utilizando SQL Server Integration Services (SSIS).

Extracción: Se extrajeron los datos desde la base de datos relacional original (KentFoods).

Transformación: Se aplicaron conversiones de tipos de datos, limpieza de valores nulos, estandarización de cadenas de texto y generación de claves subrogadas (Surrogate Keys) para mantener el historial en las dimensiones.

Carga: Los datos transformados se insertaron en las tablas de la base de datos dimensional (KentFoods_DW) alojada en SQL Server.

Tecnologías Utilizadas
Motor de Base de Datos: Microsoft SQL Server (SSMS).

Integración de Datos (ETL): Visual Studio 2019 - SQL Server Integration Services (SSIS).

Control de Versiones: Git y GitHub.

Estructura del Repositorio
Plaintext
CERTAMEN2-BI-KentFoods/
├── database/
│   ├── scripts/          # Scripts SQL de creación del modelo dimensional
│   └── backup/           # Backup (.bak) de la base de datos KentFoods_DW
├── etl/
│   └── Proyecto_SSIS/    # Solución de Visual Studio con los paquetes .dtsx
├── docs/                 # Documentación adicional y diagramas
└── README.md             # Documentación principal del repositorio
Instrucciones de Ejecución
Clonar este repositorio en el equipo local.

Restaurar el backup KentFoods_DW.bak ubicado en la carpeta database/backup/ utilizando SQL Server Management Studio.

En caso de no utilizar el backup, ejecutar el script de creación de tablas ubicado en database/scripts/ sobre una base de datos nueva.

Abrir la solución .sln ubicada en la carpeta etl/Proyecto_SSIS/ con Visual Studio (con la extensión de SSIS instalada).

Actualizar los administradores de conexión en el paquete Package.dtsx para que apunten a la instancia local de SQL Server.

Ejecutar el paquete (Botón Iniciar) para visualizar el flujo de datos desde el origen transaccional hacia el destino dimensional.

Distribución de Responsabilidades y Aportes
Álvaro Ramírez Silva: [Describir aporte, ej: Diseño del modelo dimensional y creación de scripts SQL].

Moisés Larenas Arévalo: [Describir aporte, ej: Configuración del repositorio Git, resolución de conflictos y desarrollo del flujo ETL principal].

Ignacio Miranda: [Describir aporte, ej: Definición de KPI, documentación técnica y transformaciones avanzadas en SSIS].
