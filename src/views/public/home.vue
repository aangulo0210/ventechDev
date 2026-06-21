<script setup>
import { ref, onMounted } from 'vue';
import { RouterLink } from 'vue-router';
import Navbar from '@/components/Navbar.vue';
import Footer from '@/components/Footer.vue';
import ProductCard from '@/components/ProductCard.vue';

const productos = ref([]);
const cargandoProductos = ref(true);

onMounted(async () => {
  try {
    const res = await fetch('/api/productos/listar');
    const json = await res.json();
    if (json.success) {
      productos.value = json.data.slice(0, 4);
    }
  } catch {
    // silencioso — la sección queda vacía si la API no responde
  } finally {
    cargandoProductos.value = false;
  }
});

const marcas = ['Lenovo', 'Dell', 'Logitech', 'TP-Link', 'HP', 'Samsung'];

const propuestas = [
  {
    icono: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="3" width="20" height="14" rx="2"/><path d="M8 21h8M12 17v4"/></svg>`,
    titulo: 'Catálogo especializado',
    descripcion: 'Más de 500 productos tecnológicos seleccionados para empresas: portátiles, monitores, redes, periféricos y más.',
  },
  {
    icono: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>`,
    titulo: 'Gestión de pedidos',
    descripcion: 'Seguimiento en tiempo real desde el despacho hasta la entrega. Historial completo de compras de tu empresa.',
  },
  {
    icono: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>`,
    titulo: 'Facturación electrónica',
    descripcion: 'Facturas en PDF con NIT y datos de tu empresa, disponibles para descarga inmediata después de cada compra.',
  },
];

const stats = [
  { valor: '+500', etiqueta: 'productos tecnológicos' },
  { valor: '+200', etiqueta: 'empresas confían en nosotros' },
  { valor: '24h', etiqueta: 'tiempo de despacho' },
];
</script>

<template>
  <div class="page-home">
    <Navbar />

    <!-- ── HERO ── -->
    <section class="hero">
      <div class="hero__inner">
        <span class="hero__badge">Plataforma B2B · Colombia</span>

        <h1 class="vt-hero hero__title">
          Tecnología empresarial<br />
          <span class="vt-text-gradient">para tu empresa</span>
        </h1>

        <p class="vt-body-lg hero__subtitle">
          Adquiere equipos, periféricos y soluciones tecnológicas para tu empresa
          con facturación electrónica, gestión de pedidos y soporte dedicado.
        </p>

        <div class="hero__ctas">
          <RouterLink to="/catalogo" class="btn-vt-primary hero__cta-primary">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2"/><path d="M8 21h8M12 17v4"/></svg>
            Ver catálogo
          </RouterLink>
          <RouterLink to="/auth?modo=registro" class="btn-vt-secondary">
            Crear cuenta gratis
          </RouterLink>
        </div>

        <div class="hero__marcas">
          <span class="hero__marcas-label">Marcas disponibles</span>
          <div class="hero__marcas-list">
            <span v-for="marca in marcas" :key="marca" class="hero__marca-chip">{{ marca }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- ── PROPUESTA DE VALOR ── -->
    <section class="propuesta">
      <div class="section-inner">
        <div class="section-header">
          <h2 class="vt-h2">Todo lo que tu empresa necesita</h2>
          <p class="vt-body section-header__sub">
            Una sola plataforma para comprar, gestionar y facturar tecnología empresarial.
          </p>
        </div>
        <div class="propuesta__grid">
          <div v-for="item in propuestas" :key="item.titulo" class="propuesta__card">
            <div class="propuesta__icon" v-html="item.icono"></div>
            <h3 class="vt-h3 propuesta__title">{{ item.titulo }}</h3>
            <p class="vt-body propuesta__desc">{{ item.descripcion }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- ── PRODUCTOS DESTACADOS ── -->
    <section class="productos" id="ofertas">
      <div class="section-inner">
        <div class="section-header">
          <h2 class="vt-h2">Productos destacados</h2>
          <p class="vt-body section-header__sub">
            Selección de los equipos más solicitados por empresas colombianas.
          </p>
        </div>

        <!-- Esqueletos de carga -->
        <div v-if="cargandoProductos" class="productos__grid">
          <div v-for="n in 4" :key="n" class="producto-skeleton">
            <div class="skeleton skeleton--image"></div>
            <div class="skeleton-body">
              <div class="skeleton skeleton--line skeleton--short"></div>
              <div class="skeleton skeleton--line"></div>
              <div class="skeleton skeleton--line skeleton--medium"></div>
              <div class="skeleton skeleton--btn"></div>
            </div>
          </div>
        </div>

        <div v-else class="productos__grid">
          <ProductCard
            v-for="p in productos"
            :key="p.id"
            :producto="p"
          />
        </div>

        <div class="productos__footer">
          <RouterLink to="/catalogo" class="btn-vt-secondary">
            Ver catálogo completo
          </RouterLink>
        </div>
      </div>
    </section>

    <!-- ── STATS ── -->
    <section class="stats">
      <div class="section-inner">
        <div class="stats__grid">
          <div v-for="s in stats" :key="s.valor" class="stats__item">
            <span class="stats__valor vt-hero">{{ s.valor }}</span>
            <span class="stats__etiqueta vt-body-sm">{{ s.etiqueta }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- ── CTA FINAL ── -->
    <section class="cta-final">
      <div class="section-inner cta-final__inner">
        <h2 class="vt-h2 cta-final__title">¿Listo para digitalizar tus compras?</h2>
        <p class="vt-body-lg cta-final__sub">
          Crea tu cuenta empresarial gratis y empieza a comprar con NIT, factura electrónica y despacho en 24 horas.
        </p>
        <RouterLink to="/auth?modo=registro" class="btn-vt-primary cta-final__btn">
          Empezar ahora — es gratis
        </RouterLink>
      </div>
    </section>

    <Footer />
  </div>
</template>

<style scoped>
.page-home { min-height: 100vh; }

/* ── HERO ── */
.hero {
  padding: 120px 32px 80px;
  background: linear-gradient(180deg, var(--vt-bg-subtle) 0%, var(--vt-bg-base) 100%);
}
.hero__inner {
  max-width: 720px; margin: 0 auto; text-align: center;
  display: flex; flex-direction: column; align-items: center; gap: 24px;
}
.hero__badge {
  display: inline-block; padding: 4px 16px;
  border: 1px solid rgba(20,144,242,0.35);
  border-radius: var(--vt-radius-full); background: var(--vt-info-bg);
  font-size: 0.875rem; font-weight: 600; color: var(--vt-blue);
}
.hero__title { color: var(--vt-text-primary); margin: 0; }
.hero__subtitle { color: var(--vt-text-muted); max-width: 560px; margin: 0; }
.hero__ctas { display: flex; gap: 16px; flex-wrap: wrap; justify-content: center; }
.hero__cta-primary { font-size: 1.0625rem; padding: 12px 28px; }

.hero__marcas { display: flex; flex-direction: column; align-items: center; gap: 12px; margin-top: 8px; }
.hero__marcas-label { font-size: 0.75rem; font-weight: 600; color: var(--vt-text-muted); text-transform: uppercase; letter-spacing: 0.08em; }
.hero__marcas-list { display: flex; gap: 8px; flex-wrap: wrap; justify-content: center; }
.hero__marca-chip {
  padding: 4px 14px; border: 1px solid var(--vt-border-light);
  border-radius: var(--vt-radius-full); background: var(--vt-bg-base);
  font-size: 0.8125rem; font-weight: 600; color: var(--vt-text-secondary);
}

/* ── SECCIONES COMUNES ── */
.section-inner { max-width: 1280px; margin: 0 auto; padding: 0 32px; }
.section-header { text-align: center; margin-bottom: 48px; }
.section-header h2 { color: var(--vt-text-primary); margin: 0 0 12px 0; }
.section-header__sub { color: var(--vt-text-muted); margin: 0; }

/* ── PROPUESTA ── */
.propuesta { padding: 80px 0; background: var(--vt-bg-base); }
.propuesta__grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }
.propuesta__card {
  background: var(--vt-bg-subtle); border-radius: var(--vt-radius-xl);
  padding: 32px 28px; display: flex; flex-direction: column; gap: 16px;
}
.propuesta__icon :deep(svg) { width: 40px; height: 40px; color: var(--vt-blue); }
.propuesta__title { color: var(--vt-text-primary); margin: 0; }
.propuesta__desc { color: var(--vt-text-muted); margin: 0; }

/* ── PRODUCTOS ── */
.productos { padding: 80px 0; background: var(--vt-bg-subtle); }
.productos__grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
.productos__footer { text-align: center; margin-top: 40px; }

/* Esqueletos */
.producto-skeleton {
  background: var(--vt-bg-card); border: 1px solid var(--vt-border-light);
  border-radius: var(--vt-radius-lg); overflow: hidden;
}
.skeleton { background: #E5E7EB; border-radius: 6px; animation: shimmer 1.5s infinite; }
@keyframes shimmer {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.4; }
}
.skeleton--image { height: 180px; border-radius: 0; }
.skeleton-body { padding: 16px; display: flex; flex-direction: column; gap: 10px; }
.skeleton--line { height: 14px; }
.skeleton--short { width: 40%; }
.skeleton--medium { width: 70%; }
.skeleton--btn { height: 40px; border-radius: var(--vt-radius-md); margin-top: 8px; }

/* ── STATS ── */
.stats {
  padding: 64px 0;
  background: var(--vt-gradient);
}
.stats__grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }
.stats__item { display: flex; flex-direction: column; align-items: center; gap: 8px; }
.stats__valor { color: #FFFFFF; }
.stats__etiqueta { color: rgba(255,255,255,0.8); text-align: center; }

/* ── CTA FINAL ── */
.cta-final { padding: 80px 0; background: var(--vt-bg-subtle); }
.cta-final__inner { text-align: center; display: flex; flex-direction: column; align-items: center; gap: 20px; }
.cta-final__title { color: var(--vt-text-primary); margin: 0; }
.cta-final__sub { color: var(--vt-text-muted); max-width: 520px; margin: 0; }
.cta-final__btn { font-size: 1.0625rem; padding: 14px 32px; }

/* ── RESPONSIVE ── */
@media (max-width: 1023px) {
  .productos__grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 767px) {
  .hero { padding: 96px 20px 60px; }
  .section-inner { padding: 0 20px; }
  .propuesta { padding: 60px 0; }
  .propuesta__grid { grid-template-columns: 1fr; }
  .productos { padding: 60px 0; }
  .productos__grid { grid-template-columns: repeat(2, 1fr); gap: 16px; }
  .stats__grid { grid-template-columns: 1fr; gap: 32px; }
  .cta-final { padding: 60px 0; }
}
@media (max-width: 480px) {
  .hero__title { font-size: 1.953rem; }
  .productos__grid { grid-template-columns: 1fr; }
}
</style>
