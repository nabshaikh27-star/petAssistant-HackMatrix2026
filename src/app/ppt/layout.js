export const metadata = {
  title: 'Coding Rockerz — PPT Viewer',
  description: 'Hackathon Presentation',
};

export default function PPTLayout({ children }) {
  return (
    <>
      <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&display=swap"
        rel="stylesheet"
      />
      {children}
    </>
  );
}
