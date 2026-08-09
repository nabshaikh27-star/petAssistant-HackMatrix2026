'use client';
import Link from 'next/link';

export default function PPTViewer() {
  return (
    <div className="min-h-screen bg-[#0A0A0A] flex flex-col">
      {/* Top Bar */}
      <div className="w-full h-14 border-b border-[#1f1f1f] flex items-center justify-between px-6 bg-[#111111] z-10">
        <div className="flex items-center gap-4">
          <Link
            href="/"
            className="text-[#10B981] font-mono text-sm uppercase tracking-widest hover:opacity-80 transition-opacity flex items-center gap-2"
          >
            <span className="material-symbols-outlined text-base">arrow_back</span>
            Back
          </Link>
          <span className="text-[#444] text-sm font-mono">|</span>
          <span className="text-[#888] font-mono text-xs tracking-widest">coding_rockerz_hackathon.pdf</span>
        </div>

        <a
          href="/hackathon_ppt.pdf"
          download="Coding_Rockerz_Hackathon.pdf"
          className="flex items-center gap-2 bg-[#10B981] text-black px-5 py-2 font-mono text-xs uppercase tracking-widest hover:bg-[#0d9a6e] transition-colors"
        >
          <span className="material-symbols-outlined text-base">download</span>
          Download PDF
        </a>
      </div>

      {/* PDF Viewer */}
      <div className="flex-1 w-full">
        <iframe
          src="/hackathon_ppt.pdf#toolbar=0&navpanes=0&scrollbar=0"
          className="w-full h-full border-none"
          style={{ minHeight: 'calc(100vh - 56px)' }}
          title="Coding Rockerz Hackathon PPT"
        />
      </div>
    </div>
  );
}
