from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit,unquote
import re
root=Path(__file__).resolve().parents[1]/'dist'
class Document(HTMLParser):
 def __init__(self):super().__init__();self.links=[];self.ids=[];self.h1=0;self.errors=[]
 def handle_starttag(self,tag,attrs):
  a=dict(attrs)
  if 'id' in a:self.ids.append(a['id'])
  if tag=='h1':self.h1+=1
  if tag=='img' and 'alt' not in a:self.errors.append('Image missing alt')
  for key in ['src','href']:
   if key in a:self.links.append(a[key])
docs={}
for path in root.rglob('*.html'):
 d=Document();d.feed(path.read_text());docs[path]=d
errors=[];links=0
for path,d in docs.items():
 if d.h1!=1:errors.append(f'{path}: expected one h1, got {d.h1}')
 if len(set(d.ids))!=len(d.ids):errors.append(f'{path}: duplicate IDs')
 errors.extend(d.errors)
 for link in d.links:
  u=urlsplit(link)
  if u.scheme or u.netloc:continue
  target=(root/u.path.lstrip('/')) if u.path.startswith('/') else path.parent/u.path
  if not u.path:target=path
  if target.is_dir():target=target/'index.html'
  links+=1
  if not target.exists():errors.append(f'{path.name}: missing {link}')
  elif u.fragment and target in docs and unquote(u.fragment) not in docs[target].ids:errors.append(f'{path}: missing anchor {link}')
for file in root.rglob('*'):
 if file.is_file() and file.suffix in ['.html','.js','.json']:
  s=file.read_text()
  if re.search(r'sk-[A-Za-z0-9]{25,}',s):errors.append(f'Possible secret in {file}')
if errors:raise SystemExit('\n'.join(errors))
print(f'PASS: {len(docs)} pages, {links} local links/assets, unique IDs, image alt text, one h1 per page, secret-pattern check.')
