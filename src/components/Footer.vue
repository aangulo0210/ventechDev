<template>
  <footer class="vt-footer">
    <div class="vt-footer__inner">
      <div class="vt-footer__grid">

        <div class="vt-footer__brand">
          <div class="vt-footer__logo-text">VenTech</div>
          <p class="vt-footer__tagline">Tecnología empresarial para Colombia. Calidad garantizada.</p>
          <p class="vt-footer__location">Cali, Valle del Cauca · Colombia</p>
        </div>

        <div class="vt-footer__col">
          <h4 class="vt-footer__col-title">Empresa</h4>
          <ul class="vt-footer__list">
            <li><a class="vt-footer__link" href="#">Quiénes somos</a></li>
            <li><a class="vt-footer__link" href="#">Cómo comprar</a></li>
            <li><a class="vt-footer__link" href="#">Trabaja con nosotros</a></li>
          </ul>
        </div>

        <div class="vt-footer__col">
          <h4 class="vt-footer__col-title">Soporte</h4>
          <ul class="vt-footer__list">
            <li><a class="vt-footer__link" href="#">Centro de ayuda</a></li>
            <li><a class="vt-footer__link" href="#">Seguimiento de pedidos</a></li>
            <li><a class="vt-footer__link" href="#">Garantías y devoluciones</a></li>
          </ul>
        </div>

        <div class="vt-footer__col">
          <h4 class="vt-footer__col-title">Legal</h4>
          <ul class="vt-footer__list">
            <li><a class="vt-footer__link" href="#">Términos de uso</a></li>
            <li><a class="vt-footer__link" href="#">Privacidad</a></li>
            <li><a class="vt-footer__link" href="#">Política de cookies</a></li>
          </ul>
          <div class="vt-footer__payments">
            <div class="vt-footer__payment-icon">MP</div>
            <div class="vt-footer__payment-icon">PSE</div>
            <div class="vt-footer__payment-icon">VISA</div>
            <div class="vt-footer__payment-icon">MC</div>
          </div>
        </div>

      </div>
      <div class="vt-footer__bottom">
        <p class="vt-footer__copyright">© 2026 VenTech · Todos los derechos reservados · Proyecto SENA Ficha 3186630</p>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.vt-footer { background: #1F2937; padding: 48px 0 0 0; }
.vt-footer__inner { max-width: 1280px; margin: 0 auto; padding: 0 32px; }

.vt-footer__grid {
  display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 40px;
}
.vt-footer__logo-text {
  font-size: 1.25rem; font-weight: 800; letter-spacing: -0.02em;
  background: var(--vt-gradient);
  -webkit-background-clip: text; background-clip: text;
  -webkit-text-fill-color: transparent; color: transparent;
  margin-bottom: 16px;
}
.vt-footer__tagline, .vt-footer__location {
  font-size: 0.875rem; color: #9CA3AF; line-height: 1.5; margin: 0 0 8px 0;
}
.vt-footer__col-title {
  font-size: 0.875rem; font-weight: 700; color: #F9FAFB; margin: 0 0 16px 0;
}
.vt-footer__list {
  list-style: none; padding: 0; margin: 0;
  display: flex; flex-direction: column; gap: 10px;
}
.vt-footer__link {
  font-size: 0.875rem; color: #9CA3AF; text-decoration: none; cursor: pointer;
}
.vt-footer__link:hover { color: #FFFFFF; }
.vt-footer__payments { display: flex; gap: 8px; flex-wrap: wrap; margin-top: 20px; }
.vt-footer__payment-icon {
  padding: 4px 10px; background: rgba(255,255,255,0.08);
  border-radius: var(--vt-radius-sm);
  font-size: 0.75rem; font-weight: 700; color: #9CA3AF;
}
.vt-footer__bottom {
  border-top: 1px solid rgba(255,255,255,0.08); margin-top: 40px; padding: 20px 0;
}
.vt-footer__copyright { font-size: 0.75rem; color: #6B7280; margin: 0; }

@media (max-width: 767px) {
  .vt-footer__grid { grid-template-columns: 1fr; gap: 32px; }
  .vt-footer__inner { padding: 0 20px; }
}
</style>
