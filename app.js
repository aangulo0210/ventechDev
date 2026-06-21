require('dotenv').config();
const express = require('express');

const app = express();

app.use(express.json());
app.use(express.static('public'));

// --- Rutas ---
app.use('/api/auth',      require('./src/routes/auth-routes'));
app.use('/api/productos', require('./src/routes/product-routes'));

// Fallback SPA — solo en producción (en desarrollo Vite sirve el frontend)
if (process.env.NODE_ENV === 'production') {
  const path = require('path');
  app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
  });
}

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`VenTech API corriendo en http://localhost:${PORT}`);
});
