function requiereModulo(rutaModulo) {
  return (req, res, next) => {
    const modulos = req.user?.modulos ?? [];

    if (!modulos.includes(rutaModulo)) {
      return res.status(403).json({
        success: false,
        error: 'No tienes permiso para acceder a este módulo',
        codigo: 403,
      });
    }

    next();
  };
}

function requiereRol(...rolesPermitidos) {
  return (req, res, next) => {
    if (!rolesPermitidos.includes(req.user?.rol)) {
      return res.status(403).json({
        success: false,
        error: 'Tu rol no tiene acceso a esta acción',
        codigo: 403,
      });
    }

    next();
  };
}

module.exports = { requiereModulo, requiereRol };
