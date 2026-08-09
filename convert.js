const fs = require('fs');

const rawHtml = fs.readFileSync('landing_raw.html', 'utf8');

// extract everything between <body> and </body>
const bodyMatch = rawHtml.match(/<body[^>]*>([\s\S]*?)<\/body>/i);
if (!bodyMatch) {
  console.log("No body found");
  process.exit(1);
}

let jsxStr = bodyMatch[1];
// replace class= with className=
jsxStr = jsxStr.replace(/class="/g, 'className="');
// replace <!-- --> with {/* */}
jsxStr = jsxStr.replace(/<!--([\s\S]*?)-->/g, '{/*$1*/}');
// replace inline styles style="background-image: url('...')"
jsxStr = jsxStr.replace(/style="background-image:([^"]+)"/g, (match, p1) => {
  return `style={{ backgroundImage: \`${p1.replace(/'/g, '"').trim().replace(/;$/, '')}\` }}`;
});

// Any <br> should be <br/>
jsxStr = jsxStr.replace(/<br>/g, '<br/>');

const component = `
export default function Home() {
  return (
    <div className="text-on-background font-body-md bg-background selection:bg-primary-container selection:text-black antialiased overflow-x-hidden">
      ${jsxStr}
    </div>
  );
}
`;

fs.writeFileSync('src/app/page.js', component);
console.log("Written to src/app/page.js");
