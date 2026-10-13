<div align="center">
  <h1>Certamen 2 - Inteligencia de Negocios</h1>
  <p><i>Solución de BI para la empresa Kent Foods</i></p>
  
  ![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
  ![SSIS](https://img.shields.io/badge/SSIS-5C2D91?style=for-the-badge&logo=visual-studio&logoColor=white)
  ![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
</div>

---

## 📝 Descripción del Problema y Objetivo
> Kent Foods ha experimentado un crecimiento rápido en los últimos años. Debido a esta expansión, el propietario necesita incorporar Inteligencia de Negocios para analizar los datos transaccionales generados (órdenes, clientes, envíos, productos).

**Objetivo:** Diseñar e implementar una solución BI completa para apoyar la toma de decisiones estratégicas, comenzando con un modelo dimensional y un proceso ETL (Fase 1).

## 👥 Integrantes y Responsabilidades

| Nombre | Rol / Aportes Principales |
| :--- | :--- |
| **Álvaro Ramírez Silva** | Diseño del modelo dimensional y creación de scripts SQL. |
| **Moisés Larenas Arévalo** | Configuración del repositorio Git y desarrollo del flujo ETL. |
| **Ignacio Miranda** | Definición de KPI y transformaciones avanzadas en SSIS. |

## 🎯 KPI Definidos
1. 💰 **Ingresos Totales por Ventas:** Permite evaluar el rendimiento financiero y el crecimiento analizando las ventas por producto, territorio y cliente.
2. 📦 **Volumen de Órdenes Procesadas:** Mide la carga operativa y la demanda, fundamental para la planificación logística y de inventario.
3. ⏱️ **Eficiencia en Tiempos de Envío (Días):** Mide la diferencia en días entre la orden y el envío para evaluar el rendimiento de los transportistas.

## 🏗️ Modelo Dimensional (Kimball)
Se aplicaron los 4 pasos de Ralph Kimball para el diseño en **esquema de estrella**:

* 📌 **Proceso de Negocio:** Gestión de Ventas y Envíos de productos.
* 🔍 **Granularidad:** Línea de artículo dentro de una orden de compra.
* 📦 **Dimensiones:**
  * `Dim_Cliente` (Demografía y contacto)
  * `Dim_Empleado` (Personal gestor)
  * `Dim_Producto` (Detalle del alimento y categoría)
  * `Dim_Proveedor` (Origen de productos)
  * `Dim_Transportista` (Empresa de envío)
  * `Dim_Territorio` (Ubicación geográfica)
  * `Dim_Tiempo` (Dimensión artificial de fechas)
* 📈 **Hechos (Medidas):** Cantidad de productos, Precio Unitario, Descuento, Monto Total (calculado), Días de envío (calculado).

## ⚙️ Proceso ETL (Fase 1)
Implementado mediante **SQL Server Integration Services (SSIS)**:
- **Extracción:** Desde la base de datos relacional `KentFoods`.
- **Transformación:** Conversiones de tipos, limpieza de nulos, estandarización de texto y generación de claves subrogadas (Surrogate Keys).
- **Carga:** Inserción en la base de datos dimensional `KentFoods_DW`.

## 📂 Estructura del Repositorio

```text
📦 CERTAMEN2-BI-KentFoods
 ┣ 📂 database
 ┃ ┣ 📂 scripts          # Scripts SQL de creación del modelo dimensional
 ┃ ┗ 📂 backup           # Backup (.bak) de KentFoods_DW
 ┣ 📂 etl
 ┃ ┗ 📂 Proyecto_SSIS    # Solución de Visual Studio (.dtsx)
 ┣ 📂 docs               # Documentación adicional y diagramas
 ┗ 📜 README.md          # Documentación principal
