// Sentinel Opus — Theme + Mobile Nav (single file)

(function theme() {
  const KEY = 'soc-theme';
  function setTheme(mode) {
    document.documentElement.setAttribute('data-theme', mode);
    try { localStorage.setItem(KEY, mode); } catch (e) {}
  }
  try {
    const saved = localStorage.getItem(KEY);
    if (saved) setTheme(saved);
    else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) setTheme('dark');
    else setTheme('light');
  } catch (e) {}
  const btn = document.getElementById('themeToggle');
  if (btn) btn.addEventListener('click', () => {
    const cur = document.documentElement.getAttribute('data-theme') || 'light';
    setTheme(cur === 'dark' ? 'light' : 'dark');
  });
})();

(function mobileNav() {
  const btn = document.getElementById('navToggle');
  const nav = document.getElementById('primaryNav');
  if (!btn || !nav) return;

  let open = false;
  function setOpen(v) {
    open = v;
    btn.setAttribute('aria-expanded', v ? 'true' : 'false');
    nav.classList.toggle('is-open', v);
    document.documentElement.classList.toggle('nav-open', v);
  }

  btn.addEventListener('click', () => setOpen(!open));
  document.addEventListener('keydown', e => { if (e.key === 'Escape' && open) setOpen(false); });
  nav.addEventListener('click', e => { if (e.target.closest('a')) setOpen(false); });
})();
