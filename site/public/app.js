const $=selector=>document.querySelector(selector);
const $$=selector=>[...document.querySelectorAll(selector)];
const themeButton=$('.theme');
function syncThemeLabel(){const dark=document.body.classList.contains('dark');themeButton.setAttribute('aria-label',dark?'Switch to light theme':'Switch to dark theme');themeButton.setAttribute('aria-pressed',dark);$('.hero-theme')?.setAttribute('aria-pressed',dark)}
try{const saved=localStorage.getItem('theme');document.body.classList.toggle('dark',saved?saved==='dark':window.matchMedia('(prefers-color-scheme: dark)').matches)}catch{}
syncThemeLabel();
themeButton.addEventListener('click',()=>{const dark=document.body.classList.toggle('dark');syncThemeLabel();try{localStorage.setItem('theme',dark?'dark':'light')}catch{}});
const dialog=$('#menu-dialog'),menu=$('.menu');
menu.addEventListener('click',()=>{dialog.showModal();menu.setAttribute('aria-expanded','true')});
$('.close').addEventListener('click',()=>dialog.close());
dialog.addEventListener('close',()=>{menu.setAttribute('aria-expanded','false');menu.focus()});
dialog.addEventListener('click',event=>{if(event.target===dialog){const r=dialog.getBoundingClientRect();if(event.clientX<r.left||event.clientX>r.right||event.clientY<r.top||event.clientY>r.bottom)dialog.close()}});
$$('#menu-dialog a').forEach(a=>a.addEventListener('click',()=>dialog.close()));
$$('.contribution-toggle').forEach(button=>button.addEventListener('click',()=>{
 const card=button.closest('.client-card'),panel=document.getElementById(button.getAttribute('aria-controls'));
 const expanded=button.getAttribute('aria-expanded')!=='true';
 button.setAttribute('aria-expanded',expanded);panel.hidden=!expanded;
 card.querySelector('.client-image-link').hidden=expanded;
 button.innerHTML=expanded?'Back to product <span>−</span>':'My contribution <span>+</span>';
 if(!window.matchMedia('(prefers-reduced-motion: reduce)').matches){(expanded?panel:card.querySelector('.client-image-link')).animate([{opacity:0,transform:'translateY(12px)'},{opacity:1,transform:'translateY(0)'}],{duration:350,easing:'cubic-bezier(.2,.7,.2,1)'})}
}));
$$('[data-print]').forEach(button=>button.addEventListener('click',()=>window.print()));
document.addEventListener('visibilitychange',()=>document.body.classList.toggle('page-hidden',document.hidden));
$$('header nav a,.dock a,.collection-nav a').forEach(a=>{const href=a.getAttribute('href');if(href&&!href.includes('#')&&href===location.pathname)a.setAttribute('aria-current','page')});
if($('.hero-theme')){
 $('.hero-theme').addEventListener('click',()=>themeButton.click());
 $('.hero-appreciate').addEventListener('click',()=>{const button=$('.hero-appreciate'),liked=button.getAttribute('aria-pressed')!=='true';button.setAttribute('aria-pressed',liked);button.querySelector('span').textContent=liked?'Made with love':'A little craft'});
 $('#hero-radius').addEventListener('input',event=>{const value=Number(event.target.value);$('.hero').style.setProperty('--hero-radius',value+'px');$('#radius-value').textContent=value});
 new IntersectionObserver(([entry])=>document.body.classList.toggle('at-hero',entry.isIntersecting),{threshold:.15}).observe($('.hero'));
}
