(function () {
  function build(Reveal) {
    var container = document.querySelector('.reveal');
    if (!container) return;

    var topSlides = Array.from(container.querySelectorAll('.slides > section'));
    var sections = [];

    topSlides.forEach(function (slide, idx) {
      // Case 1: the top-level slide itself is a section divider.
      var bg = slide.getAttribute('data-background-color');
      var h1 = slide.querySelector(':scope > h1');

      // Case 2: the top-level slide is a vertical stack whose first child is the divider.
      if (!bg || !h1) {
        var firstChild = slide.querySelector(':scope > section');
        if (firstChild) {
          bg = firstChild.getAttribute('data-background-color');
          h1 = firstChild.querySelector(':scope > h1');
        }
      }

      if (bg && h1) {
        sections.push({
          slideIndex: idx,
          title: h1.textContent.trim()
        });
      }
    });

    if (sections.length === 0) return;

    var nav = document.createElement('nav');
    nav.className = 'toc-nav';
    nav.setAttribute('aria-label', 'Section navigation');

    sections.forEach(function (section) {
      var chip = document.createElement('button');
      chip.className = 'toc-chip';
      chip.type = 'button';
      chip.textContent = section.title;
      chip.title = section.title;
      chip.addEventListener('click', function (e) {
        e.preventDefault();
        Reveal.slide(section.slideIndex, 0, 0);
      });
      nav.appendChild(chip);
    });

    container.appendChild(nav);

    function updateActive() {
      var currentH = Reveal.getIndices().h;
      var active = -1;
      for (var i = sections.length - 1; i >= 0; i--) {
        if (sections[i].slideIndex <= currentH) {
          active = i;
          break;
        }
      }
      var chips = nav.querySelectorAll('.toc-chip');
      chips.forEach(function (chip, i) {
        chip.classList.toggle('active', i === active);
      });
      if (active >= 0 && chips[active]) {
        chips[active].scrollIntoView({ block: 'nearest', inline: 'center', behavior: 'smooth' });
      }
    }

    Reveal.on('slidechanged', updateActive);
    updateActive();
  }

  function init() {
    if (typeof Reveal === 'undefined') {
      setTimeout(init, 100);
      return;
    }
    if (Reveal.isReady && Reveal.isReady()) {
      build(Reveal);
    } else {
      Reveal.on('ready', function () { build(Reveal); });
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
