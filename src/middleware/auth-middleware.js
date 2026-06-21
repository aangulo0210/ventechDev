const jwt = require('jsonwebtoken');

function verificarToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.startsWith('Bearer ')
    ? authHeader.slice(7)
    : null;

  if (!token) {
    return res.status(401).json({ success: false, error: 'Token requerido', codigo: 401 });
  }

  try {
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch (err) {
    const mensaje = err.name === 'TokenExpiredError'
      ? 'La sesión ha expirado'
      : 'Token inválido';
    return res.status(401).json({ success: false, error: mensaje, codigo: 401 });
  }
}

module.exports = { verificarToken };
