const fs = require('fs');

const rawHtml = fs.readFileSync('landing_raw.html', 'utf8');

// Extract the JS object from tailwind-config
const twMatch = rawHtml.match(/tailwind\.config\s*=\s*(\{[\s\S]*?\})\s*<\/script>/i);
let themeBlock = `@import "tailwindcss";\n\n@theme {\n`;

if (twMatch) {
  let configStr = twMatch[1];
  // naive evaluation to get the object
  let configObj = eval('(' + configStr + ')');
  let extend = configObj.theme.extend;
  
  if (extend.colors) {
    for (let k in extend.colors) {
      themeBlock += `  --color-${k}: ${extend.colors[k]};\n`;
    }
  }
  if (extend.borderRadius) {
    for (let k in extend.borderRadius) {
      if (k === 'DEFAULT') themeBlock += `  --radius: ${extend.borderRadius[k]};\n`;
      else themeBlock += `  --radius-${k}: ${extend.borderRadius[k]};\n`;
    }
  }
  if (extend.spacing) {
    for (let k in extend.spacing) {
      themeBlock += `  --spacing-${k}: ${extend.spacing[k]};\n`;
    }
  }
  if (extend.fontFamily) {
    for (let k in extend.fontFamily) {
      themeBlock += `  --font-${k}: ${extend.fontFamily[k][0]};\n`;
    }
  }
  if (extend.fontSize) {
    for (let k in extend.fontSize) {
      themeBlock += `  --text-${k}: ${extend.fontSize[k][0]};\n`;
      if (extend.fontSize[k][1].lineHeight) {
         // for simplicity, just skip line heights or add them as --text-xxx--line-height
      }
    }
  }
}

themeBlock += `}\n`;

// Add custom styles from the HTML
const styleMatch = rawHtml.match(/<style>([\s\S]*?)<\/style>/i);
if (styleMatch) {
  themeBlock += `\n${styleMatch[1]}\n`;
}

fs.writeFileSync('src/app/globals.css', themeBlock);
console.log("Written to src/app/globals.css");
