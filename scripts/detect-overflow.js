#!/usr/bin/env node
//
// detect-overflow.js — Find slides with content that overflows the viewport.
//
// Usage:
//   node scripts/detect-overflow.js
//
// Opens a local server and a browser page that checks all rendered slide decks.
// No npm dependencies needed — uses only Node.js built-ins + your system browser.
//
// Alternatively, paste this snippet into the browser console while viewing
// any single Reveal.js slide deck:
//
//   (function() {
//     var slides = Reveal.getSlides();
//     var problems = [];
//     slides.forEach(function(s, i) {
//       var h = s.querySelector('h1,h2,h3');
//       var title = h ? h.textContent.trim() : '(no title)';
//       var overflow = s.scrollHeight - s.clientHeight;
//       if (overflow > 10) problems.push('Slide '+(i+1)+': "'+title+'" — '+overflow+'px');
//     });
//     if (problems.length === 0) console.log('No overflow detected (' + slides.length + ' slides)');
//     else { console.warn(problems.length + ' overflowing slides:'); problems.forEach(p => console.warn('  ' + p)); }
//   })();
//

const http = require("http");
const fs = require("fs");
const path = require("path");
const { exec } = require("child_process");

const PROJECT_ROOT = path.join(__dirname, "..");
const SLIDES_DIR = path.join(PROJECT_ROOT, "slides");
const CHECKER_HTML = path.join(__dirname, "overflow-checker.html");

// Collect slide HTML files
const slideFiles = fs
  .readdirSync(SLIDES_DIR)
  .filter((f) => f.endsWith(".html") && /^\d{2}-/.test(f))
  .sort();

if (slideFiles.length === 0) {
  console.error(
    'No rendered HTML files found in slides/.\nRender first: for f in slides/*.qmd; do quarto render "$f"; done'
  );
  process.exit(1);
}

console.log(`Found ${slideFiles.length} slide decks to check.`);

// MIME types
const MIME = {
  ".html": "text/html",
  ".js": "application/javascript",
  ".mjs": "application/javascript",
  ".css": "text/css",
  ".json": "application/json",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".gif": "image/gif",
  ".svg": "image/svg+xml",
  ".woff": "font/woff",
  ".woff2": "font/woff2",
  ".ttf": "font/ttf",
  ".eot": "application/vnd.ms-fontobject",
};

// Start server
const server = http.createServer((req, res) => {
  const url = decodeURIComponent(req.url.split("?")[0]);

  // Serve the checker page at root
  if (url === "/" || url === "/index.html") {
    let checkerHtml = fs.readFileSync(CHECKER_HTML, "utf-8");
    // Inject the deck list
    checkerHtml = checkerHtml.replace(
      "DECK_LIST_PLACEHOLDER",
      JSON.stringify(slideFiles)
    );
    res.writeHead(200, { "Content-Type": "text/html" });
    res.end(checkerHtml);
    return;
  }

  // Serve slide files and their assets from the slides directory
  if (url.startsWith("/slides/")) {
    const filePath = path.join(PROJECT_ROOT, url);
    try {
      const data = fs.readFileSync(filePath);
      const ext = path.extname(filePath);
      res.writeHead(200, {
        "Content-Type": MIME[ext] || "application/octet-stream",
      });
      res.end(data);
      return;
    } catch {
      // Fall through to 404
    }
  }

  // Serve files from project root (for assets referenced by slides)
  const rootPath = path.join(PROJECT_ROOT, url);
  try {
    const data = fs.readFileSync(rootPath);
    const ext = path.extname(rootPath);
    res.writeHead(200, {
      "Content-Type": MIME[ext] || "application/octet-stream",
    });
    res.end(data);
    return;
  } catch {
    // 404
  }

  res.writeHead(404);
  res.end("Not found");
});

server.listen(0, "127.0.0.1", () => {
  const port = server.address().port;
  const url = `http://127.0.0.1:${port}`;
  console.log(`\nOverflow checker running at: ${url}`);
  console.log("Opening in browser...\n");
  console.log("The page will check each deck automatically.");
  console.log("When done, look for OVERFLOW_RESULTS in the browser console.");
  console.log("Press Ctrl+C to stop the server.\n");

  // Open in default browser
  const openCmd =
    process.platform === "darwin"
      ? `open "${url}"`
      : process.platform === "win32"
      ? `start "${url}"`
      : `xdg-open "${url}"`;

  exec(openCmd, (err) => {
    if (err) {
      console.log(`Could not open browser automatically. Visit: ${url}`);
    }
  });
});
