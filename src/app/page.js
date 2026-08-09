
export default function Home() {
  return (
    <div className="text-on-background font-body-md bg-background selection:bg-primary-container selection:text-black antialiased overflow-x-hidden">
      
{/* TopNavBar Shared Component */}
<nav className="fixed top-0 w-full z-50 flex justify-between items-center px-margin-desktop py-4 bg-background/90 backdrop-blur-sm border-b border-outline-variant flat no shadows">
<a className="font-headline-sm text-headline-sm tracking-tighter text-primary dark:text-primary hover:text-primary transition-colors duration-200" href="#">
            CODING ROCKERZ
        </a>
<div className="hidden md:flex gap-8 items-center">
<a className="text-on-surface-variant font-label-mono text-label-mono uppercase hover:text-primary transition-colors duration-200" href="#problem">Problem</a>
<a className="text-on-surface-variant font-label-mono text-label-mono uppercase hover:text-primary transition-colors duration-200" href="#solution">Solution</a>
<a className="text-on-surface-variant font-label-mono text-label-mono uppercase hover:text-primary transition-colors duration-200" href="#stack">Stack</a>

<a className="text-on-surface-variant font-label-mono text-label-mono uppercase hover:text-primary transition-colors duration-200" href="#team">Team</a>
</div>
<button className="bg-primary text-[#0A0A0A] px-6 py-2 font-label-mono text-label-mono hover:bg-primary-fixed transition-colors">
            Get Started
        </button>
</nav>
<main className="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop pt-32 pb-section-gap">
{/* Hero Section */}
<section className="min-h-[819px] flex flex-col justify-center items-start border-l tech-border pl-gutter mb-section-gap relative">
<div className="absolute top-0 right-0 w-1/2 h-full opacity-10 pointer-events-none" style={{ backgroundImage: `radial-gradient(circle at top right, #10B981, transparent 70%)` }}></div>

<h1 className="font-display-lg text-display-lg mb-6 max-w-4xl text-on-surface tracking-tighter leading-none">
                Virtual Desktop Pet <br/>&amp; AI Assistant
            </h1>
<p className="font-body-lg text-body-lg text-on-surface-variant max-w-2xl mb-12 border-l-2 border-primary-container pl-6">
                Privacy-first workspace companionship. A technical companion that resides on your desktop, analyzing context securely without sending sensitive data to the cloud.
            </p>
<div className="flex flex-col sm:flex-row gap-6">
<a className="bg-primary text-[#0A0A0A] px-8 py-4 font-label-mono text-label-mono uppercase tracking-widest hover:bg-primary-fixed transition-all flex items-center gap-2" href="/CodingRockerz_Installer.exe" download>
<span className="material-symbols-outlined">download</span>
                    Download for Windows
                </a>
<a className="emerald-border text-primary px-8 py-4 font-label-mono text-label-mono uppercase tracking-widest hover:bg-primary-container hover:text-black transition-all flex items-center gap-2 group" href="#demo">
<span className="material-symbols-outlined group-hover:animate-pulse">play_circle</span>
                    Watch Video
                </a>
<a className="border border-on-surface text-on-surface px-8 py-4 font-label-mono text-label-mono uppercase tracking-widest hover:bg-surface-container-high transition-all flex items-center gap-2" href="/ppt">
<span className="material-symbols-outlined">description</span>
                    View PPT
                </a>
</div>
</section>
{/* Problem -> Solution Section */}
<section className="mb-section-gap scroll-mt-32" id="problem">
<div className="font-label-mono text-label-mono text-on-surface-variant mb-12 flex items-center gap-4">
<span className="w-12 h-px bg-outline-variant"></span>
                [ 01 / STATEMENT ]
            </div>
<div className="grid grid-cols-1 md:grid-cols-2 gap-px bg-outline-variant">
<div className="bg-background p-12 lg:p-16 relative group">
<div className="absolute top-4 right-4 w-4 h-4 border-t border-r border-outline-variant group-hover:border-error transition-colors"></div>
<h3 className="font-label-mono text-label-mono text-error mb-4">_PROBLEM</h3>
<p className="font-headline-md text-headline-md text-on-surface-variant leading-tight">
                        Modern workspaces lack contextual, privacy-respecting companionship. Cloud-dependent AI assistants compromise local security, require constant internet connection, and disrupt workflow continuity.
                    </p>
</div>
<div className="bg-background p-12 lg:p-16 relative group">
<div className="absolute top-4 right-4 w-4 h-4 border-t border-r border-outline-variant group-hover:border-primary-container transition-colors"></div>
<h3 className="font-label-mono text-label-mono emerald-text mb-4">_SOLUTION</h3>
<p className="font-headline-md text-headline-md text-on-surface leading-tight">
                        A strictly local, context-aware digital companion. Operating directly on the desktop overlay, ensuring absolute data sovereignty with offline-first capabilities, custom reminders, and intelligent workflow assistance.
                    </p>
</div>
</div>
</section>
{/* Demo Section */}
<section className="mb-section-gap scroll-mt-32" id="demo">
<div className="font-label-mono text-label-mono text-on-surface-variant mb-12 flex items-center gap-4">
<span className="w-12 h-px bg-outline-variant"></span>
                [ 02 / DEMO ]
            </div>
<div className="aspect-video w-full emerald-border bg-surface-container-lowest relative overflow-hidden group">
<div className="absolute inset-0 flex items-center justify-center z-10 pointer-events-none">
<span className="material-symbols-outlined text-6xl text-primary opacity-50 group-hover:opacity-100 transition-opacity drop-shadow-[0_0_15px_rgba(16,185,129,0.5)]">play_arrow</span>
</div>
<div className="w-full h-full bg-cover bg-center opacity-40 group-hover:opacity-60 transition-opacity duration-500 mix-blend-luminosity" data-alt="A highly detailed, ultra-realistic digital mockup of a futuristic desktop environment in a dark mode setting. The screen displays a sleek, minimalist AI assistant interface with glowing emerald green accents (#10B981) against a deep obsidian black background (#0A0A0A). The virtual pet is a stylized, geometric low-poly creature hovering near terminal-like windows showing code. The lighting is moody, cinematic, and emphasizes sharp 1px borders and high contrast. The overall aesthetic is techno-brutalist, professional, and secure." style={{ backgroundImage: `url("https://lh3.googleusercontent.com/aida-public/AB6AXuBW3kIuNFrSiFXSfDhx41b10v_G4RuDJ_OX_1EFsn3VVW9eskyG5sqmTkZAFsJi-HQxq_sGxru3CBmGFBke4pUuK62aFPXko75K93q4bZz11_BJ8xUqvIoHWqiXtZD0gk8dc7jbcuHJ0ZHZoaPf6eIAngqkv7BlWzeRv--5ah3Ikqr5IgEl870kYcv72aXllD_IQMX6xeMtrrbxN0saRHmlyd6hUJYr-CCcesSqHggFAQb3_REgxKyK0g")` }}></div>
<div className="absolute bottom-0 left-0 w-full p-4 border-t border-outline-variant bg-background/80 backdrop-blur-md flex justify-between items-center font-label-mono text-label-mono text-on-surface-variant">
<span>STATUS: READY</span>
<span>00:00 / 02:45</span>
</div>
</div>
</section>
{/* Pitch Deck Section */}
<section className="mb-section-gap scroll-mt-32" id="slides">
<div className="font-label-mono text-label-mono text-on-surface-variant mb-12 flex items-center gap-4">
<span className="w-12 h-px bg-outline-variant"></span>
                [ 03 / SLIDES ]
            </div>
<div className="aspect-[16/9] w-screen relative left-1/2 -translate-x-1/2 tech-border bg-surface-container-low flex flex-col">
<div className="w-full h-12 border-b tech-border flex items-center px-4 gap-2 bg-surface-container-highest">
<span className="w-3 h-3 rounded-full bg-outline-variant"></span>
<span className="w-3 h-3 rounded-full bg-outline-variant"></span>
<span className="w-3 h-3 rounded-full bg-outline-variant"></span>
<span className="ml-4 font-label-mono text-label-mono text-on-surface-variant">coding_rockerz_deck_vfinal.pdf</span>
</div>
<div className="flex-1 relative bg-surface-container-lowest flex items-center justify-center p-12">
<div className="max-w-2xl text-center">
<h3 className="font-headline-lg text-headline-lg text-on-surface mb-6">Redefining Desktop Companionship</h3>
<p className="font-body-lg text-body-lg text-on-surface-variant mb-8">Secure, contextual, and unobtrusive.</p>
<div className="flex justify-center gap-4">
<button className="w-10 h-10 border tech-border flex items-center justify-center hover:bg-surface-container-high transition-colors"><span className="material-symbols-outlined text-sm">chevron_left</span></button>
<button className="w-10 h-10 border tech-border flex items-center justify-center hover:bg-surface-container-high transition-colors"><span className="material-symbols-outlined text-sm">chevron_right</span></button>
</div>
</div>
</div>
</div>
</section>
{/* Tech Stack Section */}
<section className="mb-section-gap scroll-mt-32" id="stack">
<div className="font-label-mono text-label-mono text-on-surface-variant mb-12 flex items-center gap-4">
<span className="w-12 h-px bg-outline-variant"></span>
                [ 04 / STACK ]
            </div>
<div className="border tech-border overflow-hidden">
<table className="w-full text-left border-collapse">
<thead>
<tr className="bg-surface-container-high font-label-mono text-label-mono text-on-surface-variant uppercase border-b tech-border">
<th className="p-6 font-medium">Technology</th>
<th className="p-6 font-medium hidden sm:table-cell border-l tech-border">Category</th>
<th className="p-6 font-medium border-l tech-border">Implementation</th>
</tr>
</thead>
<tbody className="font-label-mono text-label-mono">
<tr className="border-b tech-border hover:bg-surface-container-lowest transition-colors">
<td className="p-6 text-on-surface">Flutter Desktop</td>
<td className="p-6 text-on-surface-variant hidden sm:table-cell border-l tech-border">Framework</td>
<td className="p-6 text-on-surface-variant border-l tech-border">Cross-platform UI rendering engine</td>
</tr>
<tr className="border-b tech-border hover:bg-surface-container-lowest transition-colors">
<td className="p-6 text-on-surface">window_manager</td>
<td className="p-6 text-on-surface-variant hidden sm:table-cell border-l tech-border">System API</td>
<td className="p-6 text-on-surface-variant border-l tech-border">Borderless overlay &amp; always-on-top execution</td>
</tr>
<tr className="border-b tech-border hover:bg-surface-container-lowest transition-colors">
<td className="p-6 text-on-surface">Rive / Lottie</td>
<td className="p-6 text-on-surface-variant hidden sm:table-cell border-l tech-border">Animation</td>
<td className="p-6 text-on-surface-variant border-l tech-border">State-driven vector companion animations</td>
</tr>
<tr className="border-b tech-border hover:bg-surface-container-lowest transition-colors">
<td className="p-6 text-on-surface">screen_capturer</td>
<td className="p-6 text-on-surface-variant hidden sm:table-cell border-l tech-border">Vision</td>
<td className="p-6 text-on-surface-variant border-l tech-border">Local contextual analysis (opt-in)</td>
</tr>
<tr className="border-b tech-border hover:bg-surface-container-lowest transition-colors">
<td className="p-6 text-on-surface">isar</td>
<td className="p-6 text-on-surface-variant hidden sm:table-cell border-l tech-border">Database</td>
<td className="p-6 text-on-surface-variant border-l tech-border">High-performance local NoSQL storage</td>
</tr>
</tbody>
</table>
</div>
</section>
{/* Team Section */}
<section className="mb-section-gap scroll-mt-32" id="team">
<div className="font-label-mono text-label-mono text-on-surface-variant mb-12 flex items-center gap-4">
<span className="w-12 h-px bg-outline-variant"></span>
                [ 06 / TEAM ]
            </div>
<div className="grid grid-cols-2 md:grid-cols-4 gap-8">
{/* Team Member */}
<div className="flex flex-col items-center group">
<div className="w-24 h-24 rounded-full border tech-border flex items-center justify-center mb-6 group-hover:border-primary-container transition-colors">
<span className="font-headline-md text-headline-md text-on-surface-variant group-hover:text-primary transition-colors">AN</span>
</div>
<h5 className="font-label-mono text-label-mono text-on-surface uppercase tracking-widest">Anmay</h5>

</div>
{/* Team Member */}
<div className="flex flex-col items-center group">
<div className="w-24 h-24 rounded-full border tech-border flex items-center justify-center mb-6 group-hover:border-primary-container transition-colors">
<span className="font-headline-md text-headline-md text-on-surface-variant group-hover:text-primary transition-colors">NB</span>
</div>
<h5 className="font-label-mono text-label-mono text-on-surface uppercase tracking-widest">Nabeel</h5>

</div>
{/* Team Member */}
<div className="flex flex-col items-center group">
<div className="w-24 h-24 rounded-full border tech-border flex items-center justify-center mb-6 group-hover:border-primary-container transition-colors">
<span className="font-headline-md text-headline-md text-on-surface-variant group-hover:text-primary transition-colors">AM</span>
</div>
<h5 className="font-label-mono text-label-mono text-on-surface uppercase tracking-widest">Amrutha</h5>

</div>
{/* Team Member */}
<div className="flex flex-col items-center group">
<div className="w-24 h-24 rounded-full border tech-border flex items-center justify-center mb-6 group-hover:border-primary-container transition-colors">
<span className="font-headline-md text-headline-md text-on-surface-variant group-hover:text-primary transition-colors">AY</span>
</div>
<h5 className="font-label-mono text-label-mono text-on-surface uppercase tracking-widest">Ananya</h5>

</div>
</div>
</section>
</main>
{/* Footer Shared Component */}
<footer className="w-full bg-background dark:bg-background border-t border-outline-variant flat no shadows font-label-mono text-label-mono transition-all duration-300 flex flex-col md:flex-row justify-between items-center px-margin-desktop py-gutter gap-4">
<span className="text-on-surface">Â© 2024 Coding Rockerz. PRIVACY BY DESIGN.</span>
<div className="flex gap-6">
<a className="text-on-surface-variant hover:text-primary underline" href="https://github.com/nabshaikh27-star/petAssistant-HackMatrix2026.git" target="_blank" rel="noopener noreferrer">GitHub</a>
<a className="text-on-surface-variant hover:text-primary underline" href="#">Documentation</a>
<a className="text-on-surface-variant hover:text-primary underline" href="#">Contact</a>
<a className="text-on-surface-variant hover:text-primary underline" href="#">Security Policy</a>
</div>
</footer>

    </div>
  );
}
