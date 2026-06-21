const pool = require('../../config/db');

async function listarProductos({ categoria, marca, busqueda, soloActivos = true } = {}) {
  const condiciones = [];
  const params = [];

  if (soloActivos) {
    condiciones.push('p.activo = 1');
  }
  if (categoria) {
    condiciones.push('p.categoria = ?');
    params.push(categoria);
  }
  if (marca) {
    condiciones.push('p.marca = ?');
    params.push(marca);
  }
  if (busqueda) {
    condiciones.push('(p.nombre LIKE ? OR p.descripcion LIKE ?)');
    params.push(`%${busqueda}%`, `%${busqueda}%`);
  }

  const where = condiciones.length ? `WHERE ${condiciones.join(' AND ')}` : '';

  const [rows] = await pool.execute(
    `SELECT p.id, p.nombre, p.marca, p.descripcion, p.categoria,
            p.precio, p.precio_anterior, p.descuento, p.emoji_referencia, p.activo,
            p.fecha_creacion,
            i.stock_actual, i.stock_minimo
     FROM productos p
     LEFT JOIN inventario i ON i.id_producto = p.id
     ${where}
     ORDER BY p.fecha_creacion DESC`,
    params
  );
  return rows;
}

async function buscarProductoPorId(id) {
  const [rows] = await pool.execute(
    `SELECT p.id, p.nombre, p.marca, p.descripcion, p.categoria,
            p.precio, p.precio_anterior, p.descuento, p.emoji_referencia, p.activo,
            p.fecha_creacion,
            i.stock_actual, i.stock_minimo
     FROM productos p
     LEFT JOIN inventario i ON i.id_producto = p.id
     WHERE p.id = ?`,
    [id]
  );
  return rows[0] || null;
}

async function crearProducto({ nombre, marca, descripcion, categoria, precio, precio_anterior, descuento, emoji_referencia, stock_actual, stock_minimo }) {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();

    const [result] = await conn.execute(
      `INSERT INTO productos (nombre, marca, descripcion, categoria, precio, precio_anterior, descuento, emoji_referencia)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [nombre, marca, descripcion ?? null, categoria, precio, precio_anterior ?? null, descuento ?? 0, emoji_referencia ?? null]
    );

    const idProducto = result.insertId;

    await conn.execute(
      `INSERT INTO inventario (id_producto, stock_actual, stock_minimo) VALUES (?, ?, ?)`,
      [idProducto, stock_actual ?? 0, stock_minimo ?? 5]
    );

    await conn.commit();
    return idProducto;
  } catch (err) {
    await conn.rollback();
    throw err;
  } finally {
    conn.release();
  }
}

async function actualizarProducto(id, campos) {
  const permitidos = ['nombre', 'marca', 'descripcion', 'categoria', 'precio', 'precio_anterior', 'descuento', 'emoji_referencia', 'activo'];
  const sets = [];
  const params = [];

  for (const campo of permitidos) {
    if (Object.prototype.hasOwnProperty.call(campos, campo)) {
      sets.push(`${campo} = ?`);
      params.push(campos[campo]);
    }
  }

  if (sets.length === 0) return 0;

  params.push(id);
  const [result] = await pool.execute(
    `UPDATE productos SET ${sets.join(', ')} WHERE id = ?`,
    params
  );
  return result.affectedRows;
}

async function actualizarStock(idProducto, { stock_actual, stock_minimo }) {
  const sets = [];
  const params = [];

  if (stock_actual !== undefined) { sets.push('stock_actual = ?'); params.push(stock_actual); }
  if (stock_minimo !== undefined) { sets.push('stock_minimo = ?'); params.push(stock_minimo); }

  if (sets.length === 0) return 0;

  params.push(idProducto);
  const [result] = await pool.execute(
    `UPDATE inventario SET ${sets.join(', ')} WHERE id_producto = ?`,
    params
  );
  return result.affectedRows;
}

async function desactivarProducto(id) {
  const [result] = await pool.execute(
    `UPDATE productos SET activo = 0 WHERE id = ?`,
    [id]
  );
  return result.affectedRows;
}

async function obtenerCategorias() {
  const [rows] = await pool.execute(
    `SELECT DISTINCT categoria FROM productos WHERE activo = 1 ORDER BY categoria`
  );
  return rows.map((r) => r.categoria);
}

async function obtenerMarcas() {
  const [rows] = await pool.execute(
    `SELECT DISTINCT marca FROM productos WHERE activo = 1 ORDER BY marca`
  );
  return rows.map((r) => r.marca);
}

module.exports = {
  listarProductos,
  buscarProductoPorId,
  crearProducto,
  actualizarProducto,
  actualizarStock,
  desactivarProducto,
  obtenerCategorias,
  obtenerMarcas,
};
