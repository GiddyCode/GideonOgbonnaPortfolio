from pathlib import Path
import re,json,shutil,hashlib
ROOT=Path(__file__).resolve().parents[1]; OUT=ROOT/'dist'
OUT.mkdir(parents=True,exist_ok=True)
for filename in ['app.js','style.css','reference.css','revision.css','motion.js','polish.css','v2.css','gallery.js']:
 shutil.copy2(ROOT/'src'/filename,OUT/filename)
shutil.copytree(ROOT/'assets',OUT/'assets',dirs_exist_ok=True)
# Curated public content imported once; subsequent builds have no outside dependencies.
data=json.loads((ROOT/'content.json').read_text())
galleries=json.loads((ROOT/'galleries.json').read_text())
client_count=sum(p.get('kind')=='client' for p in data['projects'])
nav=(ROOT/'src/partials/header.html').read_text()
footer=(ROOT/'src/partials/footer.html').read_text()
def asset_version(name):
 return hashlib.sha256((ROOT/'src'/name).read_bytes()).hexdigest()[:12]
def page(title,body,path='index.html',desc='Gideon Ogbonna — Mobile & AI Engineer in Calgary. Thoughtful interfaces, reliable systems and human-centred AI.'):
 p=OUT/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(f'<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="description" content="{desc}"><link rel="canonical" href="https://gideonogbonna.dev/{path.replace('index.html','')}"><meta property="og:title" content="{title} — Gideon Ogbonna"><meta property="og:description" content="{desc}"><meta property="og:type" content="website"><meta property="og:image" content="https://gideonogbonna.dev/assets/gideon-portrait.png"><meta name="theme-color" content="#f6f5f1"><title>{title} — Gideon Ogbonna</title><link rel="icon" href="/assets/gideon-logo.png"><link rel="stylesheet" href="/style.css?v={asset_version('style.css')}"><link rel="stylesheet" href="/reference.css?v={asset_version('reference.css')}"><link rel="stylesheet" href="/revision.css?v={asset_version('revision.css')}"><link rel="stylesheet" href="/polish.css?v={asset_version('polish.css')}"><link rel="stylesheet" href="/v2.css?v={asset_version('v2.css')}"><script src="/gallery.js?v={asset_version('gallery.js')}" defer></script><script src="/app.js?v={asset_version('app.js')}" defer></script><script src="/motion.js?v={asset_version('motion.js')}" defer></script></head><body>{nav}<main id="main">{body}</main>{footer}</body></html>')
def personal_projects():
 voice=next(p for p in data['projects'] if p['slug']=='voice-to-action')
 screens=''.join(f'<img loading="lazy" src="/assets/voice-{n}.png" alt="Voice to Action {n} mobile screen">' for n in ['recording','home','review'])
 return '<div class="project-grid personal-grid"><a class="project" data-reveal href="/projects/voice-to-action/"><div class="project-art"><div class="phone-trio">'+screens+'</div><span class="project-arrow">↗</span></div><div class="project-caption"><div><h3>Voice to Action</h3><p>Capture a thought. Review a possible next step.</p></div><span>Personal · Mobile + AI</span></div></a><a class="project" data-reveal href="https://github.com/GiddyCode/gemini_ai_chat"><div class="project-art sdk-art"><div class="sdk-window"><div class="window-bar"><i></i><i></i><i></i><span>gemini_ai_chat / Dart</span></div><div class="sdk-symbol">✳</div><h3>Gemini AI Chat</h3><p>A Dart SDK.<br>A Flutter starting point.</p><div class="architecture"><span>Presentation</span><b>↓</b><span>Domain</span><b>↓</b><span>Data</span></div><small>Clean architecture · SDK & examples</small></div><span class="project-arrow">↗</span></div><div class="project-caption"><div><h3>Gemini AI Chat</h3><p>Open-source chat integration, organised with care.</p></div><span>Personal · Open source</span></div></a></div>'
client_meta={
 'carter':('Field service','Danihel Group Inc. · 2025–2026','Senior Mobile Engineer','Mobile field operations, schedules and service workflows.','Flutter / Dart'),
 'gladefinance':('Fintech','GladeFinance · 2022–2023','Lead Mobile Application Developer','Wallets, payments, authentication and financial-service API integration.','Flutter / Swift / Kotlin'),
 'elderberry':('Healthcare','Elderberry.care · 2023–2025','Senior Mobile Engineer','Caregiver features, scheduling, bookings, reporting and live tracking.','Flutter / Native mobile / Firebase'),
 'superpow':('Wellbeing','Through Demz Analytics · 2020–2021','Mobile Application Developer','Team contribution to a therapy product with messaging and video communication.','React Native / Flutter / WebRTC'),
 'schoolgate':('Education','Platforms Innovations · 2021–2022','Senior Mobile Application Developer','Education workflows with local persistence and backend integration.','React Native / SQLite / REST'),
 'rightq':('Customer experience','RightCom · 2017–2020','Mobile Application Developer','Customer check-in, queue monitoring and device/backend integration.','Android / Java / Kotlin'),
 'relen':('Audio learning','Earlier client & team work','Mobile project contribution','Audio-course discovery and continued listening. Detailed implementation responsibilities are not documented.','Archived product overview')}
def detail_visual(p):
 slug=p['slug']
 if slug=='gladefinance':
  return '<img src="/assets/glade-app-screens.jpg" alt="Six original GladeFinance app screens arranged in a tilted collage" width="876" height="799" loading="lazy">'
 items=galleries.get(slug,[])
 if not items:return ''
 landscape=slug=='rightq'
 collage='<div class="app-collage '+('tablet-collage' if landscape else 'phone-collage')+f' count-{min(6,len(items))}" aria-label="{p["name"]} app screen collage">'
 for i,item in enumerate(items[:6]):
  collage+=f'<button class="collage-shot shot-{i+1} '+(('already-framed ' if item['mockup'] else '')+('square-screen' if .8<item['width']/item['height']<1.2 else ''))+f'" data-screen="/assets/{item["asset"]}" data-caption="{item["label"]}" aria-label="Enlarge {p["name"]}: {item["label"]}"><img src="/assets/{item["asset"]}" alt="{item["label"]}" width="{item["width"]}" height="{item["height"]}" loading="eager"></button>'
 collage+='</div><div class="gallery-toolbar"><span>'+str(len(items))+' views</span><a href="/assets/collages/'+slug+'.jpg" download>Download collage ↓</a></div><p class="gallery-hint">Select a screen for a closer look ↗</p><div class="screen-rail" aria-label="All project screens">'
 for item in items:
  collage+=f'<button data-screen="/assets/{item["asset"]}" data-caption="{item["label"]}" aria-label="Enlarge {item["label"]}"><img src="/assets/{item["asset"]}" alt="" width="{item["width"]}" height="{item["height"]}" loading="lazy"><span>{item["label"]}</span></button>'
 return collage+'</div>'
client_meta.update({
 'rightq-welcomer':('Customer experience','RightCom','Mobile application development','Service selection, customer queues and ticket workflows.','Client & team project'),
 'eduportal':('Education','Platforms Innovations','Mobile development','School access, assignments and results in a mobile education experience.','Client & team project'),
 'storri':('Social & discovery','Client & team project','Mobile product contribution','Account creation, interest selection and a visual storytelling feed.','Original product screen archive'),
 'bloverse':('Social & video','Client & team project','Mobile product contribution','Welcome and video discovery experiences for a social mobile product.','Original product screen archive')})
def client_projects():
 cards=[]
 for p in data['projects']:
  if p.get('kind')!='client':continue
  category,company,role,scope,stack=client_meta[p['slug']]
  slug=p['slug']
  cards.append(f'<article class="client-card" data-reveal data-project="{slug}"><div class="client-card-head"><h3>{p["name"]}</h3><span>{category}</span></div><div class="client-stage"><a class="client-image-link" href="/projects/{slug}/" aria-label="Read the {p["name"]} project overview"><img src="/assets/{p["image"]}" alt="{p["name"]} product presentation" loading="lazy"><span class="image-caption">Explore the product ↗</span></a><div class="client-contribution" id="contribution-{slug}" hidden><span class="eyebrow">MY CONTRIBUTION</span><h4>{role}</h4><p>{scope}</p><small>{stack}</small><a href="/projects/{slug}/">Read the project story ↗</a></div></div><div class="client-card-foot"><p>{company}</p><button class="contribution-toggle" aria-expanded="false" aria-controls="contribution-{slug}">My contribution <span>+</span></button></div></article>')
 return '<div class="client-grid">'+''.join(cards)+'</div>'
companies=[('Danihel Group','danihel.svg','https://danihelgroup.com/'),('Elderberry.care','elderberry.png','https://elderberry.care/'),('GladeFinance','glade.png','https://gladefinance.co/'),('Platforms Innovations','platforms.png','https://platforms.com.ng/'),('RightCom','rightcom.svg','https://rightcom.com/'),('Demz Analytics',None,None)]
def company_strip():
 def items(copy=False,reverse=False):
  result=''
  for name,file,url in (list(reversed(companies)) if reverse else companies):
   content=f'<img src="/assets/companies/{file}" alt="{name}" loading="lazy">' if file else '<span class="unavailable-wordmark">Demz Analytics</span>'
   result+=f'<a class="company-logo" href="{url}"'+(' tabindex="-1"' if copy else '')+'>'+content+'</a>' if url else '<span class="company-logo">'+content+'</span>'
  return result
 rows=''
 for reverse in [False,True]:
  rows+='<div class="logo-marquee'+(' reverse' if reverse else '')+'"><div class="logo-track"><div class="logo-group">'+items(reverse=reverse)+'</div><div class="logo-group" aria-hidden="true" inert>'+items(copy=True,reverse=reverse)+'</div></div></div>'
 return '<section class="company-section" aria-label="Companies I have worked with"><div class="company-heading" data-reveal><p class="eyebrow">TEAMS I’VE BUILT WITH</p><button id="motion-toggle" aria-pressed="false" aria-label="Pause moving elements">Pause motion Ⅱ</button></div>'+rows+'</section>'
hero=(ROOT/'src/partials/hero.html').read_text()
intro=company_strip()
clients='<section class="section client-section" id="client-work"><span id="interactions" class="anchor-alias"></span><div class="section-heading" data-reveal><div><p class="eyebrow">BUILT WITH TEAMS</p><h2>Client & team work</h2></div><p>Real products I’ve contributed to.<br>Explore the screens, then take a closer look at my part.</p></div><p class="client-disclosure">Historical product visuals · Team contributions · Tap “My contribution” for context</p>'+client_projects()+'</section>'
work='<section class="section" id="work"><div class="section-heading" data-reveal><div><p class="eyebrow">PERSONAL PROJECTS</p><h2>Selected work</h2></div><p>Independent builds exploring mobile experiences, AI engineering and useful developer tools.</p></div>'+personal_projects()+'</section>'
about=(ROOT/'src/partials/about.html').read_text()
experience_links={'Danihel Group':[('Carter App','carter')], 'Danihel Group Inc.':[('Carter App','carter')],'Elderberry.care':[('Elderberry','elderberry')],'GladeFinance':[('GladeFinance','gladefinance')],'Platforms Innovations':[('Schoolgate','schoolgate'),('Eduportal','eduportal')],'Demz Analytics':[('Superpow','superpow')],'RightCom Technology':[('RightQ Kiosk','rightq'),('RightQ Welcomer','rightq-welcomer')]}
experience='<section class="experience section" id="experience"><div data-reveal><p class="eyebrow">ALONG THE WAY</p><h2>Built with good teams.</h2></div>'
for date,company,role in data['experience']:
 links=''.join(f'<a href="/projects/{slug}/">{label} ↗</a>' for label,slug in experience_links.get(company,[]))
 experience+=f'<div class="experience-row" data-reveal><span>{date}</span><h3>{company}</h3><div><p>{role}</p><div class="experience-links">{links}</div></div></div>'
experience+='</section>'

page('Mobile & AI Engineer',hero+intro+clients+work+about+experience)
collection_nav='<nav class="collection-nav" aria-label="Work collections"><a href="/work/">Personal projects <sup>02</sup></a><a href="/client-work/">Client & team work <sup>11</sup></a></nav>'
page('Personal projects','<section class="page-intro"><p class="eyebrow">INDEPENDENT EXPLORATION</p><h1>Selected work.</h1><p>Personal projects in mobile and AI engineering.</p>'+collection_nav+'</section>'+work,'work/index.html')
client_page='<section class="page-intro"><p class="eyebrow">COLLABORATIVE PRODUCT WORK</p><h1>Built together.</h1><p>Commercial and earlier client projects. Clear context for my contribution.</p>'+collection_nav+'</section>'+clients
page('Client & team work',client_page,'client-work/index.html')
page('Client & team work',client_page,'interactions/index.html')
def project_body(project):
 body=project['body']
 if project['slug']=='gladefinance' or project['slug'] in galleries:
  caption='Two public app-store screenshots and four source-derived Flutter previews with demo data. Preview layouts are adapted from the app code; they are not production captures.' if project['slug']=='carter' else 'Original screens from the product archive. Each view is distinct.'
  gallery='<section class="app-detail-gallery"><span class="section-label">04 / APP SCREENS</span><div><h2>Inside the app.</h2><figure>'+detail_visual(project)+'<figcaption>'+caption+'</figcaption></figure></div></section>'
  body=body.replace('<aside>',gallery+'<aside>',1)
 if project.get('kind')=='client':
  body=body.replace('/work/','/client-work/').replace('← Selected work','← Client & team work')
 if project['slug']=='voice-to-action':
  cover_start=body.index('<div class="case-cover"')
  cover_end=body.index('<p class="cover-caption"')
  intro=body[:cover_start]
  meta=re.search(r'<dl class="case-meta">.*?</dl>',intro,re.S).group(0)
  intro=intro.replace(meta,'')
  return '<div class="case-opening">'+intro+body[cover_start:cover_end]+'</div>'+meta+body[cover_end:]
 if project.get('kind')=='client':
  clients=[p for p in data['projects'] if p.get('kind')=='client'];idx=next(i for i,p in enumerate(clients) if p['slug']==project['slug']);nxt=clients[(idx+1)%len(clients)]
  body=re.sub(r'<div class="next-project">.*?</div>','',body,flags=re.S)
  body+=f'<div class="next-project"><a href="/projects/{nxt["slug"]}/"><span>NEXT PROJECT</span><strong>{nxt["name"]} ↗</strong></a><a class="back-collection" href="/client-work/">All client & team work ↗</a></div>'
 return body
for p in data['projects']:
 page(p['name'],project_body(p),f'projects/{p["slug"]}/index.html',p['subtitle'])
page('Résumé',data['resume'],'resume/index.html')
print(f'Built {len(data["projects"])+5} static pages.')

# Public discovery and a real missing-page document.
urls=['https://gideonogbonna.dev/'+str(p.relative_to(OUT)).replace('index.html','') for p in sorted(OUT.rglob('index.html'))]
(OUT/'sitemap.xml').write_text('<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'+''.join('<url><loc>'+u+'</loc></url>' for u in urls)+'</urlset>')
(OUT/'robots.txt').write_text('User-agent: *\nAllow: /\nSitemap: https://gideonogbonna.dev/sitemap.xml\n')
page('Page not found','<section class="page-intro missing-page"><p class="eyebrow">404 / A SMALL DETOUR</p><h1>Let’s get you<br>back on track.</h1><p>This page may have moved. There’s plenty more to explore.</p><a class="outline" href="/">Back to the portfolio ↗</a></section>','404.html')
