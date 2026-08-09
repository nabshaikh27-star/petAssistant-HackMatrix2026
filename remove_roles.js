const fs = require('fs');
let c = fs.readFileSync('src/app/page.js', 'utf8');

c = c.replace(/<p className="font-label-mono text-label-mono text-on-surface-variant text-\[10px\] mt-2">[^<]+<\/p>/g, '');

fs.writeFileSync('src/app/page.js', c);
console.log('Roles removed.');
