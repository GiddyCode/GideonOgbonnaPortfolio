(()=>{
 const triggers=[...document.querySelectorAll('[data-screen]')];if(!triggers.length)return;
 const viewer=document.createElement('dialog');viewer.className='screen-viewer';viewer.setAttribute('aria-label','Project screen viewer');
 const bar=document.createElement('div');bar.className='viewer-bar';const caption=document.createElement('p');caption.id='screen-caption';viewer.setAttribute('aria-labelledby',caption.id);
 const close=document.createElement('button');close.className='viewer-close';close.type='button';close.setAttribute('aria-label','Close enlarged screen');close.textContent='×';
 const img=document.createElement('img');img.className='viewer-image';bar.append(caption,close);viewer.append(bar,img);document.body.append(viewer);let origin;
 triggers.forEach(button=>button.addEventListener('click',()=>{origin=button;img.src=button.dataset.screen;img.alt=button.dataset.caption;caption.textContent=button.dataset.caption;viewer.showModal();document.body.classList.add('viewing-screen');close.focus()}));
 close.addEventListener('click',()=>viewer.close());viewer.addEventListener('close',()=>{document.body.classList.remove('viewing-screen');origin?.focus({preventScroll:true})});
 viewer.addEventListener('click',event=>{if(event.target===viewer){const r=viewer.getBoundingClientRect();if(event.clientX<r.left||event.clientX>r.right||event.clientY<r.top||event.clientY>r.bottom)viewer.close()}});
})();
