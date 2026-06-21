const pool = require('../../config/db');

async function buscarUsuarioPorCorreo(correo) {
  const [rows] = await pool.execute(
    `SELECT u.id, u.nombre, u.apellido, u.correo, u.password_hash, u.activo,
            r.nombre AS rol
     FROM usuarios u
     JOIN roles r ON r.id = u.id_rol_base
     WHERE u.correo = ?`,
    [correo]
  );
  return rows[0] || null;
}

async function obtenerModulosDeUsuario(idUsuario) {
  const [rows] = await pool.execute(
    `SELECT m.ruta
     FROM usuario_modulos um
     JOIN modulos m ON m.id = um.id_modulo
     WHERE um.id_usuario = ? AND um.activo = 1`,
    [idUsuario]
  );
  return rows.map((r) => r.ruta);
}

module.exports = { buscarUsuarioPorCorreo, obtenerModulosDeUsuario };
