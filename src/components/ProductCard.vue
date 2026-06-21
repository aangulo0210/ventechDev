<script setup>
import { computed } from 'vue';

const props = defineProps({
  producto: { type: Object, required: true },
});

const emit = defineEmits(['agregar']);

const precioFormateado = computed(() =>
  new Intl.NumberFormat('es-CO', {
    style: 'currency', currency: 'COP', maximumFractionDigits: 0,
  }).format(props.producto.precio)
);

const precioAnteriorFormateado = computed(() =>
  props.producto.precio_anterior
    ? new Intl.NumberFormat('es-CO', {
        style: 'currency', currency: 'COP', maximumFractionDigits: 0,
      }).format(props.producto.precio_anterior)
    : null
);

const badgeTipo = computed(() => {
  if (props.producto.descuento > 0) return 'discount';
  if (!props.producto.precio_anterior) return 'new';
  return null;
});

const badgeTexto = computed(() => {
  if (badgeTipo.value === 'discount') return `-${Math.round(props.producto.descuento)}%`;
  if (badgeTipo.value === 'new') return 'Nuevo';
  return '';
});

const stockStatus = computed(() => {
  const s = props.producto.stock_actual ?? 0;
  const m = props.producto.stock_minimo ?? 5;
  if (s === 0) return 'sin-stock';
  if (s <= m) return 'stock-bajo';
  return 'en-stock';
});
</script>

<template>
  <article class="product-card">
    <div class="product-card__image-wrapper">
      <div class="product-card__emoji" aria-hidden="true">
        {{ producto.emoji_referencia || '📦' }}
      </div>
      <span
        v-if="badgeTipo"
        class="product-card__badge"
        :class="`product-card__badge--${badgeTipo}`"
      >{{ badgeTexto }}</span>
    </div>

    <div class="product-card__body">
      <span class="product-card__brand">{{ producto.marca }}</span>
      <h3 class="product-card__name">{{ producto.nombre }}</h3>

      <span class="vt-badge" :class="`vt-badge--${stockStatus}`">
        {{ stockStatus === 'en-stock' ? 'En stock' : stockStatus === 'stock-bajo' ? 'Stock bajo' : 'Sin stock' }}
      </span>

      <div class="product-card__pricing">
        <span class="product-card__price">{{ precioFormateado }}</span>
        <span v-if="precioAnteriorFormateado" class="product-card__price-old">
          {{ precioAnteriorFormateado }}
        </span>
      </div>

      <button
        class="btn-vt-primary product-card__cta"
        :disabled="stockStatus === 'sin-stock'"
        @click="emit('agregar', producto)"
      >
        {{ stockStatus === 'sin-stock' ? 'Sin stock' : 'Agregar al carrito' }}
      </button>
    </div>
  </article>
</template>

<style scoped>
.product-card {
  background: var(--vt-bg-card); border: 1px solid var(--vt-border-light);
  border-radius: var(--vt-radius-lg); box-shadow: var(--vt-shadow-card);
  overflow: hidden; display: flex; flex-direction: column;
  transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}
.product-card:hover {
  transform: translateY(-3px); box-shadow: var(--vt-shadow-card-hover);
}
.product-card__image-wrapper {
  position: relative; background: var(--vt-bg-subtle); height: 180px;
  display: flex; align-items: center; justify-content: center; overflow: hidden;
}
.product-card__emoji { font-size: 5rem; line-height: 1; user-select: none; }
.product-card__badge {
  position: absolute; top: 10px; left: 10px;
  font-size: 0.75rem; font-weight: 700; padding: 2px 10px;
  border-radius: var(--vt-radius-full);
}
.product-card__badge--discount {
  background: var(--vt-error-bg); color: var(--vt-error);
  border: 1px solid rgba(220,38,38,0.2);
}
.product-card__badge--new {
  background: var(--vt-info-bg); color: var(--vt-blue);
  border: 1px solid rgba(20,144,242,0.2);
}
.product-card__body {
  padding: 16px; display: flex; flex-direction: column; gap: 8px; flex: 1;
}
.product-card__brand {
  font-size: 0.75rem; font-weight: 600; color: var(--vt-blue);
  text-transform: uppercase; letter-spacing: 0.05em;
}
.product-card__name {
  font-size: 1rem; font-weight: 700; color: var(--vt-text-primary);
  line-height: 1.4; display: -webkit-box;
  -webkit-line-clamp: 2; -webkit-box-orient: vertical;
  overflow: hidden; margin: 0;
}
.product-card__pricing {
  display: flex; align-items: baseline; gap: 8px; flex-wrap: wrap; margin-top: 4px;
}
.product-card__price {
  font-family: var(--vt-font-mono); font-size: 1.25rem;
  font-weight: 700; color: var(--vt-text-primary);
}
.product-card__price-old {
  font-size: 0.75rem; color: var(--vt-text-disabled);
  text-decoration: line-through; font-family: var(--vt-font-mono);
}
.product-card__cta { width: 100%; margin-top: auto; }
</style>
