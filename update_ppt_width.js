const fs = require('fs');
let c = fs.readFileSync('src/app/page.js', 'utf8');

c = c.replace(
  '<div className="aspect-[16/9] w-full tech-border bg-surface-container-low flex flex-col">',
  '<div className="aspect-[16/9] w-screen relative left-1/2 -translate-x-1/2 tech-border bg-surface-container-low flex flex-col">'
);

fs.writeFileSync('src/app/page.js', c);
console.log('PPT width updated.');
