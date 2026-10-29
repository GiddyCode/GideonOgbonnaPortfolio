// Original motion implementation based on observed entrance, marquee and scroll behaviour.
(()=>{
 const reduce=matchMedia('(prefers-reduced-motion: reduce)');
 let paused=false;
 const moving=()=>!reduce.matches&&!paused;
 const active=new Set();
 const animate=(el,frames,options)=>{if(!moving())return;const animation=el.animate(frames,options);active.add(animation);animation.finished.catch(()=>{}).finally(()=>active.delete(animation));return animation};
 const ease='cubic-bezier(.16,1,.3,1)';
 const toggle=document.querySelector('#motion-toggle');
 const sync=()=>{document.body.classList.toggle('motion-paused',paused||reduce.matches);if(toggle){toggle.setAttribute('aria-pressed',paused);toggle.setAttribute('aria-label',paused?'Resume moving elements':'Pause moving elements');toggle.textContent=paused?'Resume motion ▶':'Pause motion Ⅱ'}if(!moving()){for(const animation of active)animation.finish();document.querySelectorAll('[data-parallax],.hero-art').forEach(e=>e.style.removeProperty('translate'));document.querySelectorAll('.screen-collage,.app-collage').forEach(e=>e.style.removeProperty('--collage-drift'))}};
 toggle?.addEventListener('click',()=>{paused=!paused;sync()});reduce.addEventListener('change',sync);sync();
 const heroItems=[document.querySelector('header'),document.querySelector('.hero-art'),document.querySelector('.hero-intro'),document.querySelector('.tool-tray'),document.querySelector('.hero h1'),...document.querySelectorAll('.build-chip,.hero-theme,.hero-appreciate,.hero-pointer,.radius-demo')].filter(Boolean);
 heroItems.forEach((el,index)=>animate(el,[{opacity:0,transform:`translateY(${index===1?55:30}px)`},{opacity:1,transform:'translateY(0)'}],{duration:index===1?1400:1000,delay:Math.min(index*85,650),easing:ease,fill:'backwards'}));
 // One-time chapter reveals. Content stays visible without JS or with reduced motion.
 const observer=new IntersectionObserver(entries=>{entries.forEach(entry=>{
  if(!entry.isIntersecting)return;
  const el=entry.target;observer.unobserve(el);el.dataset.revealed='true';
  const heading=el.matches('.section-heading,.about-heading,.footer-invitation');
  const card=el.matches('.client-card,.project');
  const start=heading?'translate3d(-28px,38px,0)':card?'translate3d(0,64px,0) scale(.985)':'translate3d(0,48px,0)';
  animate(el,[{opacity:0,transform:start},{opacity:1,transform:'translate3d(0,0,0) scale(1)'}],{duration:heading?1050:850,delay:Number(el.dataset.stagger||0),easing:ease,fill:'backwards'});
 })},{threshold:.06,rootMargin:'0px 0px -20px 0px'});
 document.querySelectorAll('[data-reveal],.section-heading,.about-heading,.project-story>section,.article>section,.footer-directory').forEach(el=>{
  if(el.matches('.client-card,.project')){const siblings=[...el.parentElement.children];el.dataset.stagger=String((siblings.indexOf(el)%3)*70)}
  // A parent section already animates these children as one coherent scene.
  if(!el.parentElement.closest('[data-reveal],.project-story>section,.article>section'))observer.observe(el);
 });
 const footer=document.querySelector('footer');
 if(footer)new IntersectionObserver(([entry])=>document.body.classList.toggle('at-contact',entry.isIntersecting),{threshold:.08}).observe(footer);
 const visibleMotion=new IntersectionObserver(entries=>entries.forEach(entry=>entry.target.classList.toggle('motion-offscreen',!entry.isIntersecting)),{rootMargin:'100px'});
 document.querySelectorAll('.company-section,.hero').forEach(el=>visibleMotion.observe(el));
 // Tool magnification, button magnetism and gentle image depth on precise pointers.
 if(matchMedia('(hover:hover) and (pointer:fine)').matches){
  const tray=document.querySelector('.tool-tray');
  tray?.addEventListener('pointermove',event=>{if(!moving())return;tray.querySelectorAll('a').forEach(a=>{const r=a.getBoundingClientRect(),distance=Math.abs(event.clientX-(r.left+r.width/2)),strength=Math.max(0,1-distance/100);a.style.transform=`translateY(${-10*strength}px) scale(${1+.2*strength})`})});
  tray?.addEventListener('pointerleave',()=>tray.querySelectorAll('a').forEach(a=>a.style.removeProperty('transform')));
  document.querySelectorAll('[data-magnetic],.contact-link,.purple-button').forEach(el=>{el.addEventListener('pointermove',event=>{if(!moving())return;const r=el.getBoundingClientRect();el.style.translate=`${(event.clientX-r.left-r.width/2)*.09}px ${(event.clientY-r.top-r.height/2)*.12}px`});el.addEventListener('pointerleave',()=>el.style.removeProperty('translate'))});
 }
 // Preserve native scrolling while adding the observed slow artwork depth and progress.
 const hero=document.querySelector('.hero'),art=document.querySelector('.hero-art');const collages=[...document.querySelectorAll('.screen-collage,.app-collage')];let frame=0;
 const update=()=>{frame=0;const max=document.documentElement.scrollHeight-innerHeight;document.documentElement.style.setProperty('--scroll-progress',`${max>0?scrollY/max*100:0}%`);if(art&&hero&&moving()&&innerWidth>760){const r=hero.getBoundingClientRect();art.style.translate=`0 ${Math.min(35,Math.max(-10,-r.top*.045))}px`}if(moving()&&innerWidth>760){for(const collage of collages){const r=collage.getBoundingClientRect();if(r.bottom>0&&r.top<innerHeight)collage.style.setProperty('--collage-drift',`${Math.max(-10,Math.min(10,(innerHeight/2-r.top-r.height/2)*.025))}px`)}}};
 addEventListener('scroll',()=>{if(!frame)frame=requestAnimationFrame(update)},{passive:true});addEventListener('resize',()=>{if(!frame)frame=requestAnimationFrame(update)},{passive:true});update();
 // The contact action is local-only; no message is sent when copying.
 const copy=document.querySelector('.copy-email'),copyStatus=document.querySelector('.copy-status');
 copy?.addEventListener('click',async()=>{
  try{await navigator.clipboard.writeText('ogbonnagideonofficial@gmail.com');copyStatus.textContent='Email copied';copy.setAttribute('aria-label','Email address copied');}
  catch{copyStatus.textContent='Select the address above to copy it.';}
 });
 // Duplicate only the visual button label; retain a single accessible name.
 document.querySelectorAll('.contact-link,.purple-button,.about-story>.outline').forEach(a=>{const label=a.textContent.trim();a.setAttribute('aria-label',label);a.innerHTML='';const clip=document.createElement('span');clip.className='roll-label';for(let i=0;i<2;i++){const line=document.createElement('span');line.textContent=label;line.setAttribute('aria-hidden','true');clip.append(line)}a.append(clip)});
})();
