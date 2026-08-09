const fs = require('fs');
let c = fs.readFileSync('src/app/page.js', 'utf8');

c = c.replace(
  /<a[^>]*>GitHub<\/a>/i,
  '<a className="text-on-surface-variant hover:text-primary underline" href="https://github.com/nabshaikh27-star/petAssistant-HackMatrix2026.git" target="_blank" rel="noopener noreferrer">GitHub</a>'
);

fs.writeFileSync('src/app/page.js', c);
console.log('GitHub link updated.');
