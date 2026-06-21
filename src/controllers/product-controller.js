const { validationResult } = require('express-validator');
const {
  listarProductos,
  buscarProductoPorId,
  crearProducto,
  actualizarProducto,
  actualizarStock,
  desactivarProducto,
  obtenerCategorias,
  obtenerMarcas,
} = require('../models/product-model');

async function listar(req, res) {
  try {
    const { categoria, marca, busqueda } = req.query;
    const productos = await listarProductos({ categoria, marca, busqueda });
    return res.status(200).json({ success: true, data: productos });
  } catch (err) {
    console.error('[product-controller] listar:', err);
    return res.status(500).json({ success: false, error: 'Error interno del servidor', codigo: 500 });
  }
}

async function detalle(req, res) {
  try {
    const producto = await buscarProductoPorId(req.params.id);
    if (!producto) {
      return res.status(404).json({ success: false, error: 'Producto no encontrado', codigo: 404 });
    }
    return res.status(200).json({ success: true, data: producto });
  } catch (err) {
    console.error('[product-controller] detalle:', err);
    return res.status(500).json({ success: false, error: 'Error interno del servidor', codigo: 500 });
  }
}

async function crear(req, res) {
  const errores = validationResult(req);
  if (!errores.isEmpty()) {
    return res.status(400).json({ success: false, error: errores.array()[0].msg, codigo: 400 });
  }

  try {
    const id = await crearProducto(req.body);
    const producto = await buscarProductoPorId(id);
    return res.status(201).json({
      success: true,
      data: producto,
      mensaje: 'Producto creado correctamente',
    });
  } catch (err) {
    console.error('[product-controller] crear:', err);
    return res.status(500).json({ success: false, error: 'Error interno del servidor', codigo: 500 });
  }
}

async function actualizar(req, res) {
  const errores = validationResult(req);
  if (!errores.isEmpty()) {
    return res.status(400).json({ success: false, error: errores.array()[0].msg, codigo: 400 });
  }

  try {
    const existe = await buscarProductoPorId(req.params.id);
    if (!existe) {
      return res.status(404).json({ success: false, error: 'Producto no encontrado', codigo: 404 });
    }

    const { stock_actual, stock_minimo, ...camposProducto } = req.body;

    await actualizarProducto(req.params.id, camposProducto);

    if (stock_actual !== undefined || stock_minimo !== undefined) {
      await actualizarStock(req.params.id, { stock_actual, stock_minimo });
    }

    const actualizado = await buscarProductoPorId(req.params.id);
    return res.status(200).json({
      success: true,
      data: actualizado,
      mensaje: 'Producto actualizado correctamente',
    });
  } catch (err) {
    console.error('[product-controller] actualizar:', err);
    return res.status(500).json({ success: false, error: 'Error interno del servidor', codigo: 500 });
  }
}

async function eliminar(req, res) {
  try {
    const existe = await buscarProductoPorId(req.params.id);
    if (!existe) {
      return res.status(404).json({ success: false, error: 'Producto no encontrado', codigo: 404 });
    }

    await desactivarProducto(req.params.id);
    return res.status(200).json({ success: true, mensaje: 'Producto desactivado correctamente' });
  } catch (err) {
    console.error('[product-controller] eliminar:', err);
    return res.status(500).json({ success: false, error: 'Error interno del servidor', codigo: 500 });
  }
}

async function filtros(req, res) {
  try {
    const [categorias, marcas] = await Promise.all([obtenerCategorias(), obtenerMarcas()]);
    return res.status(200).json({ success: true, data: { categorias, marcas } });
  } catch (err) {
    console.error('[product-controller] filtros:', err);
    return res.status(500).json({ success: false, error: 'Error interno del servidor', codigo: 500 });
  }
}

module.exports = { listar, detalle, crear, actualizar, eliminar, filtros };
