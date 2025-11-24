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

// Language toggle (English / Swedish) using Google Translate cookie
(function languageToggle() {
  const STORAGE_KEY = 'soc-lang';
  const btn = document.getElementById('langToggle');
  if (!btn) return;

  const label = btn.querySelector('.lang-label');
  const root = document.documentElement;

  function setCookie(name, value, days, domain) {
    let expires = '';
    if (days) {
      const date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = '; expires=' + date.toUTCString();
    }
    const domainPart = domain ? `; domain=${domain}` : '';
    document.cookie = `${name}=${value || ''}${expires}; path=/${domainPart}`;
  }

  function setLang(code) {
    const next = code === 'sv' ? 'sv' : 'en';
    btn.classList.toggle('is-sv', next === 'sv');
    label.textContent = next.toUpperCase();
    root.setAttribute('lang', next);
    try { localStorage.setItem(STORAGE_KEY, next); } catch (e) {}
    const cookieVal = next === 'sv' ? '/en/sv' : '/sv/en';
    setCookie('googtrans', cookieVal, 365);
    setCookie('googtrans', cookieVal, 365, 'translate.google.com');
    loadTranslate();
  }

  function loadTranslate() {
    if (window.google && window.google.translate) return;
    if (document.getElementById('google-translate-script')) return;
    window.googleTranslateElementInit = function () {
      new google.translate.TranslateElement({
        pageLanguage: 'en',
        includedLanguages: 'en,sv',
        autoDisplay: false
      }, 'google_translate_element');
    };
    const s = document.createElement('script');
    s.id = 'google-translate-script';
    s.src = 'https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit';
    s.defer = true;
    document.head.appendChild(s);
  }

  const saved = (() => {
    try { return localStorage.getItem(STORAGE_KEY); } catch (e) { return null; }
  })();
  setLang(saved || 'en');

  btn.addEventListener('click', () => {
    const current = btn.classList.contains('is-sv') ? 'sv' : 'en';
    const next = current === 'sv' ? 'en' : 'sv';
    setLang(next);
  });
})();
