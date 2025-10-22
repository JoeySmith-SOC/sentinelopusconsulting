(function(){
  const btn = document.getElementById('themeToggle');
  const setTheme = (t)=>{
    const root = document.documentElement;
    root.classList.remove('light');
    if (t === 'light') root.classList.add('light');
    localStorage.setItem('theme', t);
  };
  const saved = localStorage.getItem('theme') || 'auto';
  setTheme(saved);
  if (btn){
    btn.addEventListener('click', ()=>{
      const current = localStorage.getItem('theme') || 'auto';
      const next = current === 'auto' ? 'light' : (current === 'light' ? 'auto' : 'auto');
      setTheme(next);
    });
  }
})();
