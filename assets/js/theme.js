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
