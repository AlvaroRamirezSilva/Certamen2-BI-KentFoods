<div align="center">
  <h1>📊 Proyecto de Inteligencia de Negocios: Fase 1</h1>
  <p><i>Solución de Análisis Multidimensional para Kent Foods</i></p>
  <p><b>Universidad Técnica Federico Santa María</b></p>
  
  ![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
  ![SSIS](https://img.shields.io/badge/SSIS-5C2D91?style=for-the-badge&logo=visual-studio&logoColor=white)
  ![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
</div>

---

## 📝 Descripción del Problema y Objetivo General

> **Contexto:** Kent Foods es una empresa dedicada a la venta y envío de alimentos que ha experimentado un crecimiento acelerado durante los últimos años. Actualmente, su volumen de datos transaccionales ha superado la capacidad de análisis manual, generando cuellos de botella en la evaluación de ventas y la gestión logística.

**Objetivo del Proyecto:** 
Diseñar e implementar la primera fase de una solución integral de Inteligencia de Negocios (BI) que centralice, limpie y estructure los datos operativos de Kent Foods. A través de la construcción de un Data Warehouse (DW) y un proceso automatizado de Extracción, Transformación y Carga (ETL), se busca habilitar una plataforma analítica que permita a la gerencia monitorear indicadores clave, identificar patrones de compra y optimizar los tiempos de despacho.

---

## 👥 Equipo de Trabajo y Responsabilidades

| Nombre | Rol Técnico | Aportes Principales en Fase 1 |
| :--- | :--- | :--- |
| **Álvaro Ramírez Silva** | Data Architect | Diseño conceptual del modelo en estrella. Creación de los scripts DDL en SQL Server para dimensiones y tabla de hechos. |
| **Moisés Larenas Arévalo** | Data Engineer | Configuración y gestión del repositorio Git. Desarrollo, orquestación y validación del flujo de datos (ETL) en Visual Studio (SSIS). |
| **Ignacio Miranda** | Business Analyst | Análisis del modelo transaccional. Levantamiento y justificación de KPIs. Aplicación de reglas de limpieza y transformación de datos. |

---

## 🎯 Definición de Indicadores de Desempeño (KPIs)

Para asegurar que el modelo dimensional responda a las necesidades estratégicas de la empresa, se definieron los siguientes KPIs basándose en los datos relacionales disponibles:

1. 💰 **Ingresos Netos por Ventas:**
   * **Justificación:** Permite evaluar la rentabilidad real de la empresa y el impacto de las políticas de precios.
   * **Métrica:** Sumatoria del `Precio Unitario` multiplicado por la `Cantidad`, menos el `Descuento` aplicado.
   * **Dimensiones de Análisis:** Por Tiempo (Mensual/Trimestral), por Categoría de Producto y por Territorio.

2. 📦 **Volumen de Órdenes Despachadas:**
   * **Justificación:** Mide la carga operativa del negocio, siendo fundamental para planificar el inventario y evaluar la demanda por zonas geográficas.
   * **Métrica:** Conteo distintivo (Distinct Count) de `OrdenID`.
   * **Dimensiones de Análisis:** Por Cliente, por Empleado a cargo y por Transportista.

3. ⏱️ **Eficiencia Logística (Días de Envío):**
   * **Justificación:** Impacta directamente en la satisfacción del cliente. Permite identificar cuellos de botella logísticos y evaluar el rendimiento de los transportistas.
   * **Métrica:** Promedio de días transcurridos entre la `FechaOrden` y la `FechaEnvio`.
   * **Dimensiones de Análisis:** Por Transportista y por Ciudad/País de destino.

---

## 🏗️ Modelo Dimensional (Metodología Kimball)

Para el diseño del Data Warehouse `KentFoods_DW`, se aplicaron rigurosamente los 4 pasos definidos por Ralph Kimball, optando por un **Esquema de Estrella** para optimizar el rendimiento de las consultas:

* 📌 **Paso 1: Elección del Proceso de Negocio:**
  Se seleccionó el proceso de **Ventas y Envíos**, ya que es el núcleo operativo que genera los ingresos de Kent Foods y contiene la mayor cantidad de variables analíticas.

* 🔍 **Paso 2: Declaración de la Granularidad:**
  Para permitir el máximo nivel de exploración (*drill-down*), la granularidad se definió a nivel de **línea de artículo por cada orden de compra**. Cada registro en la tabla de hechos representa un producto individual dentro de una transacción específica.

* 📦 **Paso 3: Identificación de las Dimensiones:**
  Se crearon las siguientes dimensiones, todas equipadas con Claves Subrogadas (Surrogate Keys) autoincrementables:
  * `Dim_Cliente`: Agrupa atributos demográficos y de contacto del comprador.
  * `Dim_Producto`: Contiene la descripción del alimento y su categoría (desnormalizada para evitar copo de nieve).
  * `Dim_Empleado`: Personal interno responsable de gestionar la orden, cruzado con su territorio.
  * `Dim_Transportista`: Empresas encargadas del despacho logístico.
  * `Dim_Tiempo`: Dimensión artificial (Calendario) fundamental para desglosar las ventas por año, semestre, trimestre, mes y día.

* 📈 **Paso 4: Identificación de los Hechos (Fact Table):**
  La tabla `Fact_Ventas` actúa como el centro del esquema de estrella, almacenando las claves foráneas hacia todas las dimensiones y las siguientes métricas:
  * *Hechos Aditivos:* `Cantidad`, `PrecioUnitario`, `Descuento`.
  * *Hechos Derivados:* `MontoTotal` (calculado en el ETL), `DiasDeEnvio` (calculado en el ETL).

---

## ⚙️ Arquitectura del Proceso ETL (SSIS)

El poblamiento del Data Warehouse se automatizó utilizando **SQL Server Integration Services (SSIS)**, estructurado en tres fases críticas:

1. **Extracción (Extract):**
   * Conexión OLE DB hacia la base de datos transaccional `KentFoods` (Origen).
   * Consultas SQL específicas para extraer únicamente los campos necesarios, evitando la sobrecarga del servidor.

2. **Transformación (Transform):**
   * **Limpieza de Datos:** Tratamiento de valores nulos (NULLs) en fechas de envío o campos de texto mediante la tarea *Columna Derivada* (*Derived Column*).
   * **Estandarización:** Normalización de formatos de texto (mayúsculas/minúsculas) y tipos de datos numéricos.
   * **Cálculos:** Generación de la columna `DiasDeEnvio` mediante la función `DATEDIFF` entre las fechas de orden y despacho.
   * **Búsquedas (Lookup):** Cruce de las claves naturales (Natural Keys) del sistema transaccional con las Claves Subrogadas (Surrogate Keys) del modelo dimensional para preparar la inserción en la tabla de hechos.

3. **Carga (Load):**
   * Inserción secuencial utilizando componentes *OLE DB Destination* hacia `KentFoods_DW`.
   * Se estructuró el flujo para cargar primero las Dimensiones (maestros) y, finalmente, la Tabla de Hechos para respetar la integridad referencial.

---

## 📂 Estructura del Repositorio

```text
📦 CERTAMEN2-BI-KentFoods
 ┣ 📂 database
 ┃ ┣ 📂 scripts          # Archivos .sql con DDL del Data Warehouse (Dimensiones y Hechos)
 ┃ ┗ 📂 backup           # Archivo KentFoods_DW.bak con la base de datos ya poblada
 ┣ 📂 etl
 ┃ ┗ 📂 Proyecto_SSIS    # Archivos .sln, .dtproj y paquetes .dtsx del flujo en Visual Studio
 ┣ 📂 docs               # Diagramas de modelo relacional vs dimensional y documentos anexos
 ┗ 📜 README.md          # Documentación técnica principal
