# Presentation Tools

> **What's in this folder:** Philosophy, principles, and prompts for creating effective slide presentations with AI assistance.

---

## Contents

### `rhetoric_of_decks.md` — Practical Principles (Condensed)

**What it is:** A condensed guide to what makes presentations work. The actionable principles extracted from years of giving and watching academic talks.

**How to use it:**
- **Read it** to internalize the principles
- **Reference it** when designing a new deck
- **Paste it** into Claude when you want it to follow these principles

**Core concepts:**
- **The Three Laws**: Beauty is function, cognitive load is the enemy, slides serve speech
- **Aristotle**: Ethos (credibility), Pathos (emotion), Logos (logic)
- **MB/MC equivalence**: Every slide should have the same marginal benefit to marginal cost ratio
- **Titles are assertions**: "Treatment increased distance by 61 miles" not "Results"
- **Bullets are defeat**: Find the structure hiding in your list

---

### `rhetoric_of_decks_full_essay.md` — The Full Intellectual Framework

**What it is:** A 600+ line essay tracing rhetoric from Aristotle through LLMs. The complete intellectual foundation behind the practical principles.

**Covers:**
- The history of rhetoric (Aristotle, Cicero, Quintilian, Augustine)
- Technology's transformation of persuasion (printing press through PowerPoint)
- The economics of attention (Netflix streaming vs. theater viewing)
- Defamiliarization (Shklovsky's "making the stones feel like stones")
- The academic job market talk as case study
- What LLMs see when trained on presentations
- Tufte's critique and its limits

**When to use it:** When you want to understand *why* the principles work, not just *what* they are.

---

### `deck_generation_prompt.md` — The Prompt

**What it is:** A tested prompt for generating Beamer presentations with Claude Code, including an iterative multi-agent review process.

**How to use it:**
1. Open Claude Code in your project directory
2. Have existing content ready (notes, old slides, paper draft)
3. Customize the bracketed sections in the prompt
4. Paste the prompt
5. Follow the iterative workflow

**The Iterative Workflow:**

```
┌─────────────────────────────────────────┐
│  Step 1: Build deck with MB/MC          │
│          equivalence, compile           │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│  Step 2: Fix ALL compilation warnings   │
│          (no matter how small)          │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│  Step 3: Check silent visual errors     │
│          (Tikz coords, ggplot labels)   │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│  Step 4: Recompile, check flow          │
│          and MB/MC equivalence          │
└──────────────────┬──────────────────────┘
                   │
                   ▼
              ┌────┴────┐
              │ Pass?   │──No──┐
              └────┬────┘      │
                   │           │
                  Yes          │
                   │           │
                   ▼           │
          ┌────────────────┐   │
          │ Human reviews  │   │
          └────────────────┘   │
                               │
               ┌───────────────┘
               │
               ▼
        Back to Step 1
```

**Key insight:** The goal is NOT maximum cognitive density. The goal is **smoothness** — consistent MB/MC ratio across all slides. Exception: deliberate "jump scares" for rhetorical effect.

---

## The Silent Killers

> **Note:** This section was written for a Beamer/LaTeX workflow. The PSY 410 course uses Quarto/Reveal.js, where the equivalent problems are text overflowing slide boundaries (no LaTeX warnings exist in HTML output). The ggplot2 visual errors section still applies. See the Quarto-specific notes below.

### Beamer/LaTeX Warnings (for Beamer projects only)

LaTeX compilation succeeds with two types of output: **warnings** and **errors**. Errors stop compilation; warnings don't. But warnings matter enormously for visual quality.

- **Overfull `\hbox`**: Content too wide — text bleeds into margins
- **Underfull `\hbox`**: Content too sparse — awkward whitespace stretching
- **Overfull/Underfull `\vbox`**: Same problems, vertical

### Quarto/Reveal.js Equivalent

Reveal.js slides don't produce LaTeX warnings, but the same *category* of problem exists:

- **Text overflow**: Content too long for the slide viewport — text runs off the bottom or right edge
- **Code blocks too wide**: Long code lines extend past the slide boundary
- **Figure sizing**: Plots rendered at sizes that don't fit the slide dimensions

**How to check:** Render all decks and visually inspect, or use automated screenshot comparison. (This is a known gap in our workflow — a systematic check is planned.)

### Visual Errors That Don't Warn (applies to both formats)

Neither LaTeX nor Quarto catches coordinate or positioning problems in ggplot2. These render silently but look wrong:

- Axis labels cut off at figure boundary
- Legends obscuring data points
- Text sizing inconsistent across panels
- Tick marks misaligned with gridlines

### The Two-Pass Workflow

1. **Render and check for overflow** — No text running off slides
2. **Visually inspect figures** — Claude cannot verify layouts from code alone
3. **Re-render after fixes** — Changes may introduce new issues

The goal is zero overflow AND visual correctness.

---

## Examples

### `examples/rhetoric_of_decks/` — The Philosophy Deck

A 45-slide Beamer presentation that teaches the rhetoric of decks philosophy itself. This deck practices what it preaches:
- Custom professional color palette (DeepNavy, Teal, WarmOrange)
- TikZ diagrams throughout
- MB/MC equivalence across slides
- Titles as assertions
- Zero compilation warnings

Contains: LaTeX source, compiled PDF, figure generation R script, all figure PDFs.

### `examples/gov2001_probability/` — A Lecture Deck

A complete probability lecture deck (Harvard Gov 2001) showing:
- A full probability lecture deck
- Custom Beamer theme (inline in preamble)
- The rhetoric principles in practice
- What the iterative workflow caught
