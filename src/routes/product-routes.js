const { Router } = require('express');
const { body, param } = require('express-validator');
const { listar, detalle, crear, actualizar, eliminar, filtros } = require('../controllers/product-controller');
const { verificarToken } = require('../middleware/auth-middleware');
const { requiereModulo } = require('../middleware/role-middleware');

const router = Router();

const adminProductos = [verificarToken, requiereModulo('/admin/products')];

const validacionesCrear = [
  body('nombre').notEmpty().withMessage('El nombre es obligatorio').trim(),
  body('marca').notEmpty().withMessage('La marca es obligatoria').trim(),
  body('categoria').notEmpty().withMessage('La categoría es obligatoria').trim(),
  body('precio').isFloat({ min: 0 }).withMessage('El precio debe ser un número positivo'),
  body('precio_anterior').optional({ nullable: true }).isFloat({ min: 0 }).withMessage('El precio anterior debe ser un número positivo'),
  body('descuento').optional().isFloat({ min: 0, max: 100 }).withMessage('El descuento debe estar entre 0 y 100'),
  body('stock_actual').optional().isInt({ min: 0 }).withMessage('El stock debe ser un entero positivo'),
  body('stock_minimo').optional().isInt({ min: 0 }).withMessage('El stock mínimo debe ser un entero positivo'),
];

const validacionesActualizar = [
  param('id').isInt({ min: 1 }).withMessage('ID de producto inválido'),
  body('nombre').optional().notEmpty().withMessage('El nombre no puede estar vacío').trim(),
  body('precio').optional().isFloat({ min: 0 }).withMessage('El precio debe ser un número positivo'),
  body('precio_anterior').optional({ nullable: true }).isFloat({ min: 0 }).withMessage('El precio anterior debe ser un número positivo'),
  body('descuento').optional().isFloat({ min: 0, max: 100 }).withMessage('El descuento debe estar entre 0 y 100'),
  body('activo').optional().isBoolean().withMessage('El campo activo debe ser true o false'),
  body('stock_actual').optional().isInt({ min: 0 }).withMessage('El stock debe ser un entero positivo'),
  body('stock_minimo').optional().isInt({ min: 0 }).withMessage('El stock mínimo debe ser un entero positivo'),
];

// Rutas públicas
router.get('/listar', listar);
router.get('/filtros', filtros);
router.get('/:id', param('id').isInt({ min: 1 }).withMessage('ID inválido'), detalle);

// Rutas admin protegidas
router.post('/crear', ...adminProductos, validacionesCrear, crear);
router.put('/:id/actualizar', ...adminProductos, validacionesActualizar, actualizar);
router.delete('/:id/eliminar', ...adminProductos, param('id').isInt({ min: 1 }).withMessage('ID inválido'), eliminar);

module.exports = router;
