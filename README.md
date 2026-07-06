# RiwiSupply S.A.S. 
## Base de Datos Relacional — 

> Base de datos normalizada a 3FN para la gestión de compras, inventario y proveedores de RiwiSupply S.A.S., construida en MySQL 8.0.

---

## Tecnologías
- MySQL 8.0
- MySQL Workbench

---

## Estructura de la base de datos

| Tabla | Descripción | Depende de |
|---|---|---|
| `ciudades` | Ciudades donde operan proveedores y bodegas | — |
| `categorias` | Categorías de productos | — |
| `proveedores` | Proveedores registrados con NIT y contacto | `ciudades` |
| `bodegas` | Bodegas de almacenamiento con responsable | `ciudades` |
| `productos` | Catálogo de productos con precio y stock | `categorias` |
| `compras` | Órdenes de compra por proveedor | `proveedores` |
| `detalle_compra` | Productos incluidos en cada compra (N:M) | `compras`, `productos` |
| `movimiento_inv` | Entradas y salidas de productos en bodegas | `productos`, `bodegas` |

---

## Relaciones principales

```
ciudades     (1) ──── (N) proveedores
ciudades     (1) ──── (N) bodegas
proveedores  (1) ──── (N) compras
compras      (N) ──── (M) productos  →  resuelta con detalle_compra
productos    (1) ──── (N) movimiento_inv
bodegas      (1) ──── (N) movimiento_inv
```

---

## Instrucciones para ejecutar

1. Abrir **MySQL Workbench**
2. Abrir el archivo `riwisupply_comentado.sql`
3. Seleccionar todo el contenido (`Ctrl + A`)
4. Ejecutar con el botón **rayo con barra** o `Ctrl + Shift + Enter`
5. Verificar que todas las filas salgan en **verde** en el panel Output

---

## Datos insertados

| Tabla | Registros |
|---|---|
| ciudades | 5 |
| categorias | 6 |
| proveedores | 6 |
| bodegas | 4 |
| productos | 7 |
| compras | 10 |
| detalle_compra | 5 |
| movimiento_inv | 10 |

---

## Consultas incluidas

| # | Consulta | Tipo |
|---|---|---|
| 1 | Stock de productos con categoría | JOIN + ORDER BY |
| 2 | Movimientos por bodega discriminados por tipo | JOIN + GROUP BY + HAVING |
| 3 | Total comprado por proveedor con ciudad | LEFT JOIN + GROUP BY |
| 4 | Producto con mayor volumen comprado | JOIN + GROUP BY + LIMIT |
| 5 | Valor total del inventario por bodega | JOIN + GROUP BY + HAVING |
| 6 | Proveedores con total mayor al promedio | JOIN + HAVING + Subconsulta |
| 7 | Categorías con precio promedio mayor a $10.000 | JOIN + GROUP BY + HAVING |

---

## Vistas

| Vista | Descripción |
|---|---|
| `vw_stock_por_producto` | Stock actual de cada producto con su categoría |
| `vw_compras_por_proveedor` | Resumen de compras agrupadas por proveedor |

Para consultarlas:
```sql
SELECT * FROM vw_stock_por_producto;
SELECT * FROM vw_compras_por_proveedor;
```

---

## Transacciones

El script incluye un bloque de transacción con `START TRANSACTION`, `SAVEPOINT`, y `COMMIT` para insertar un nuevo proveedor y producto de forma atómica.

---

## Autor

**Andrés** 
