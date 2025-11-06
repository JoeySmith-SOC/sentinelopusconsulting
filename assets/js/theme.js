(function () {
  const key = 'soc-theme';
  const btn = document.getElementById('themeToggle');
  if (!btn) return;

  function setTheme(mode) {
    document.documentElement.setAttribute('data-theme', mode);
    try { localStorage.setItem(key, mode); } catch (e) {}
  }

  // Initialize from localStorage or OS
  try {
    const saved = localStorage.getItem(key);
    if (saved) setTheme(saved);
    else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      setTheme('dark');
    } else {
      setTheme('light');
    }
  } catch (e) {}

  btn.addEventListener('click', () => {
    const current = document.documentElement.getAttribute('data-theme') || 'light';
    setTheme(current === 'dark' ? 'light' : 'dark');
  });
})();
// Mobile menu toggle
(function(){
  const btn = document.getElementById('navToggle');
  const nav = document.getElementById('primaryNav');
  if (!btn || !nav) return;

  function setOpen(open){
    btn.setAttribute('aria-expanded', open ? 'true' : 'false');
    nav.classList.toggle('is-open', open);
    document.documentElement.classList.toggle('nav-open', open);
  }

  let open = false;
  btn.addEventListener('click', () => { open = !open; setOpen(open); });

  // Close on Escape and when clicking a nav link (good UX)
  document.addEventListener('keydown', (e)=>{ if(e.key==='Escape' && open){ open=false; setOpen(false);} });
  nav.addEventListener('click', (e)=>{ if(e.target.closest('a')) { open=false; setOpen(false);} });
})();
