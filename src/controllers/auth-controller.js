const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { validationResult } = require('express-validator');
const { buscarUsuarioPorCorreo, obtenerModulosDeUsuario } = require('../models/auth-model');

async function login(req, res) {
  const errores = validationResult(req);
  if (!errores.isEmpty()) {
    return res.status(400).json({
      success: false,
      error: errores.array()[0].msg,
      codigo: 400,
    });
  }

  const { correo, password } = req.body;

  try {
    const usuario = await buscarUsuarioPorCorreo(correo);

    if (!usuario) {
      return res.status(401).json({ success: false, error: 'Credenciales incorrectas', codigo: 401 });
    }

    if (!usuario.activo) {
      return res.status(403).json({ success: false, error: 'Tu cuenta está suspendida', codigo: 403 });
    }

    const passwordValida = await bcrypt.compare(password, usuario.password_hash);
    if (!passwordValida) {
      return res.status(401).json({ success: false, error: 'Credenciales incorrectas', codigo: 401 });
    }

    const modulos = await obtenerModulosDeUsuario(usuario.id);

    const payload = {
      id_usuario: usuario.id,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      rol: usuario.rol,
      modulos,
    };

    const token = jwt.sign(payload, process.env.JWT_SECRET, {
      expiresIn: process.env.JWT_EXPIRES_IN || '15m',
    });

    return res.status(200).json({
      success: true,
      data: {
        token,
        usuario: {
          id: usuario.id,
          nombre: usuario.nombre,
          apellido: usuario.apellido,
          correo: usuario.correo,
          rol: usuario.rol,
          modulos,
        },
      },
      mensaje: 'Sesión iniciada correctamente',
    });
  } catch (err) {
    console.error('[auth-controller] login:', err);
    return res.status(500).json({ success: false, error: 'Error interno del servidor', codigo: 500 });
  }
}

function logout(req, res) {
  // El cierre de sesión se maneja en el frontend eliminando el token de localStorage.
  // Este endpoint existe para que el cliente tenga un punto explícito de cierre.
  return res.status(200).json({ success: true, mensaje: 'Sesión cerrada correctamente' });
}

function perfil(req, res) {
  return res.status(200).json({ success: true, data: req.user });
}

module.exports = { login, logout, perfil };
