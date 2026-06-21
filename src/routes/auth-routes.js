const { Router } = require('express');
const { body } = require('express-validator');
const { login, logout, perfil } = require('../controllers/auth-controller');
const { verificarToken } = require('../middleware/auth-middleware');

const router = Router();

router.post(
  '/login',
  [
    body('correo').isEmail().withMessage('Correo inválido').normalizeEmail(),
    body('password').isLength({ min: 8 }).withMessage('La contraseña debe tener al menos 8 caracteres'),
  ],
  login
);

router.post('/logout', verificarToken, logout);

router.get('/perfil', verificarToken, perfil);

module.exports = router;
