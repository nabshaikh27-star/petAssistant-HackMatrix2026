const fs = require('fs');

let page = fs.readFileSync('src/app/page.js', 'utf8');

// 1. Navbar branding to uppercase CODING ROCKERZ (if it's not already)
page = page.replace(
  />\s*(Coding Rockerz|SENTINEL AI|SENTINEL)\s*<\/a>/gi,
  '>\n            CODING ROCKERZ\n        </a>'
);
page = page.replace(/Coding Rockerz/g, 'Coding Rockerz'); // Already done

// 2. Add Download Button to Hero Section
const heroButtonsStr = `<div className="flex flex-col sm:flex-row gap-6">`;
const heroButtonsReplacement = `<div className="flex flex-col sm:flex-row gap-6">
<a className="bg-primary text-[#0A0A0A] px-8 py-4 font-label-mono text-label-mono uppercase tracking-widest hover:bg-primary-fixed transition-all flex items-center gap-2" href="/CodingRockerz_Installer.exe" download>
<span className="material-symbols-outlined">download</span>
                    Download for Windows
                </a>`;
page = page.replace(heroButtonsStr, heroButtonsReplacement);

// 3. Update Problem Section
const problemStr = `Modern workspaces lack contextual, privacy-respecting companionship. Cloud-dependent AI assistants compromise local security and disrupt workflow continuity.`;
const problemReplacement = `Modern workspaces lack contextual, privacy-respecting companionship. Cloud-dependent AI assistants compromise local security, require constant internet connection, and disrupt workflow continuity.`;
page = page.replace(problemStr, problemReplacement);

// 4. Update Solution Section
const solutionStr = `A strictly local, context-aware digital companion. Operating directly on the desktop overlay, ensuring absolute data sovereignty while providing intelligent workflow assistance.`;
const solutionReplacement = `A strictly local, context-aware digital companion. Operating directly on the desktop overlay, ensuring absolute data sovereignty with offline-first capabilities, custom reminders, and intelligent workflow assistance.`;
page = page.replace(solutionStr, solutionReplacement);

fs.writeFileSync('src/app/page.js', page);
console.log('page.js updated');
