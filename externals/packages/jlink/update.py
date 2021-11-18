#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p "python3.withPackages (ps: with ps; [ beautifulsoup4 requests ] )" nix-prefetch
import requests
import bs4
import json
import subprocess
import os


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
URL_FORMAT = 'https://www.segger.com/downloads/jlink/JLink_Linux_V{version}_{arch}.tgz'
CURL_OPTS = '-d accept_license_agreement=accepted -d submit=Download+software'

page = requests.get('https://www.segger.com/downloads/jlink').text
elem = bs4.BeautifulSoup(page, features='lxml').find(
    'select', {'class': 'version'}).find('option')
version = elem.children.__next__().lstrip('V')


arches = [
    ('x86_64-linux', 'x86_64'),
    ('i686-linux', 'i686'),
    ('armv7l-linux', 'arm'),
    ('aarch64-linux', 'arm64')
]


out_obj = {}
for nix_arch, jlink_arch in arches:
    url = URL_FORMAT.format(version=version.replace('.', ''), arch=jlink_arch)
    out = subprocess.run(
        ['nix-prefetch', f'{{fetchurl}}: fetchurl {{ url = "{url}"; curlOpts = "{CURL_OPTS}"; }}'], stdout=subprocess.PIPE, check=True)
    sha256 = out.stdout.decode('utf8').strip()
    out_obj[nix_arch] = {
        'url': url,
        'version': version,
        'curlOpts': CURL_OPTS,
        'sha256': sha256
    }

out_file = open(os.path.join(BASE_DIR, 'version.json'), 'w')
json.dump(out_obj, out_file)
out_file.close()
