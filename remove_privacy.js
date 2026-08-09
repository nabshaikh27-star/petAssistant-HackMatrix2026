const fs = require('fs');

let c = fs.readFileSync('src/app/page.js', 'utf8');

// Remove the privacy nav link
c = c.replace(/<a[^>]*href="#privacy"[^>]*>Privacy<\/a>/gi, '');

// Remove the Privacy section
const start = c.indexOf('{/* Privacy Section */}');
const end = c.indexOf('{/* Team Section */}');

if (start !== -1 && end !== -1) {
    c = c.substring(0, start) + c.substring(end);
    fs.writeFileSync('src/app/page.js', c);
    console.log('Privacy section and link removed.');
} else {
    console.log('Could not find privacy section markers.');
}
