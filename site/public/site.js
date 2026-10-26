const email = 'ogbonnagideonofficial@gmail.com';
for (const button of document.querySelectorAll('[data-copy-email]')) {
  button.addEventListener('click', async () => {
    const status = button.parentElement.querySelector('[role="status"]');
    try {
      await navigator.clipboard.writeText(email);
      status.textContent = 'Email address copied.';
    } catch {
      status.textContent = email;
    }
  });
}
const progress = document.querySelector('.site-progress');
if (progress) {
  const update = () => {
    const range = document.documentElement.scrollHeight - window.innerHeight;
    progress.style.width = `${range > 0 ? Math.min(100, Math.max(0, window.scrollY / range * 100)) : 100}%`;
  };
  window.addEventListener('scroll', update, {passive: true});
  window.addEventListener('resize', update);
  update();
}
