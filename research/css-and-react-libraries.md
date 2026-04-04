# CSS & React Library Research

> Research date: 2026-04-04
> Context: The blog is currently a Pandoc/bash static site with zero JavaScript.
> Two lightweight CSS frameworks (Ellegant, Kernel CSS) are downloaded at build time.
> This research explores options for migrating to a React-based stack.

---

## Important: You'll Need a Meta-Framework First

Since the project currently has no React at all, you'll need a framework to build on.

| Framework | GitHub Stars | Status | Blog Fit |
|---|---|---|---|
| **Astro** | ~58k | Active (v5.x) | **Best fit.** Markdown-first, zero JS by default, content collections, partial hydration ("Islands"). Closest to current Pandoc workflow. |
| **Next.js** | ~236k | Active (v16.x) | Works, but overkill for a blog. Server components, API routes, middleware you won't need. |
| **Remix** | ~32k | Merged into React Router | Wrong tool for static content. |
| **Gatsby** | ~55k | Maintenance mode (Netlify acquisition) | Not recommended for new projects. |

**Demo links:**
- Astro: https://astro.build/ · Showcase: https://astro.build/showcase/ · Try in browser: https://astro.new/latest/
- Next.js: https://nextjs.org/ · Showcase: https://nextjs.org/showcase

**Recommendation:** Astro. Your existing `.md` files drop into `src/content/` with minimal changes. MDX available when you want React components in posts.

---

## Part 1: CSS / Styling Libraries (7 options)

### 1. Tailwind CSS

**What:** Utility-first CSS framework. Compose styles via classes like `flex pt-4 text-center`.

| Metric | Value |
|---|---|
| GitHub Stars | ~94,300 |
| npm Downloads/week | ~47.8M |
| Latest Version | v4.2.2 (March 2026) |
| First Released | November 2017 (~8.5 years) |
| Bundle Size | < 10kB after purging |

**Used by:** Netflix, Vercel, Shopify, OpenAI (docs), Clerk, 26k+ companies.

**See it:** https://tailwind-nextjs-starter-blog.vercel.app/ (a real blog with posts, tags, dark mode, search)

**Pros:** Massive ecosystem (shadcn/ui, daisyUI, typography plugin, blog templates). First-class Next.js/Astro support. v4 is 5x faster builds. Rapid prototyping.
**Cons:** Verbose class strings in JSX. Requires learning utility vocabulary. Some v3→v4 migration pain.

---

### 2. UnoCSS

**What:** Instant on-demand atomic CSS engine. Tailwind-compatible via presets, but faster and more extensible.

| Metric | Value |
|---|---|
| GitHub Stars | ~18,700 |
| npm Downloads/week | ~317k |
| Latest Version | v66.6.7 (March 2026) |
| First Released | November 2021 (~4.5 years) |
| Bundle Size | ~3.5kB min+gzip, zero deps |

**Used by:** 421+ companies. Strong in Vue/Nuxt ecosystem. Created by Anthony Fu (Vue/Vite core team).

**See it:** https://unocssthemes.maggieliu.dev/ (theme demo — toggle color themes live)

**Pros:** 5x faster than Tailwind JIT. Tailwind-compatible preset. Pure CSS icons, attributify mode. Smallest possible output.
**Cons:** Much smaller ecosystem than Tailwind. Fewer blog templates. Stronger Vue adoption; less common in React/Next.js.

---

### 3. Vanilla Extract

**What:** Zero-runtime stylesheets-in-TypeScript. Styles in `.css.ts` files, compiled to static CSS.

| Metric | Value |
|---|---|
| GitHub Stars | ~10,300 |
| npm Downloads/week | ~1,340,000 |
| Latest Version | v1.20.1 (March 2026) |
| First Released | 2021 (~5 years) |
| Bundle Size | Zero runtime |

**Used by:** Shopify (Polaris), SEEK, Glean, Remix docs.

**See it:** https://polaris-react.shopify.com/components (Shopify Polaris, built with Vanilla Extract — cards, buttons, tables in Shopify's design)

**Pros:** True zero-runtime. Full TypeScript type safety. Sprinkles API for atomic styles. Created by Mark Dalgleish (co-creator of CSS Modules). Mature with 1.3M+ weekly downloads.
**Cons:** Requires separate `.css.ts` files (more boilerplate). Learning curve for Sprinkles/Recipes. No inline styles. Fewer blog starters.

---

### 4. Panda CSS

**What:** Build-time, type-safe CSS-in-JS. Write styles in TypeScript, get zero-runtime static CSS.

| Metric | Value |
|---|---|
| GitHub Stars | ~6,000 |
| npm Downloads/week | ~130k |
| Latest Version | v1.9.1 (March 2026) |
| First Released | 2023 (~3 years) |
| Bundle Size | Zero runtime |

**Used by:** Created by Segun Adebayo (Chakra UI creator). Adopted by teams migrating from Chakra UI.

**See it:** https://park-ui.com/ (Park UI — the styled component layer for Panda CSS, with theme color customization)

**Pros:** Zero runtime. Full TypeScript autocomplete. Built-in design token system. Works with React Server Components.
**Cons:** Smaller community. Handles dynamic styles poorly (build-time limitation). Relatively young.

---

### 5. Open Props

**What:** Library of CSS custom properties (design tokens) for colors, typography, spacing, shadows, animations. Not a framework — just expert-crafted CSS variables.

| Metric | Value |
|---|---|
| GitHub Stars | ~5,300 |
| npm Downloads/week | ~31k |
| Latest Version | v1.7.23 (stable) / v2.0.0-beta.5 |
| First Released | ~2022 (~4 years) |
| Bundle Size | 4.4kB base |

**Used by:** Created by Adam Argyle (Google Chrome CSS developer advocate). Popular in CSS education community.

**See it:** https://open-props-ui.netlify.app/ (25+ pre-styled components — buttons, cards, dialogs built on Open Props variables)

**Pros:** Extremely lightweight. Framework-agnostic. Total design flexibility. Progressive enhancement friendly. Built by a CSS standards expert.
**Cons:** Not a framework — you write all your own CSS. Sparse docs. Fewer templates. v2 still in beta.

---

### 6. StyleX (Meta)

**What:** Compile-time CSS-in-JS generating atomic CSS. Powers Facebook, Instagram, WhatsApp, Threads.

| Metric | Value |
|---|---|
| GitHub Stars | ~9,100 |
| npm Downloads/week | ~14–38k |
| Latest Version | v0.17.5 (January 2026) |
| First Released | Open-sourced December 2023 (internal since ~2019) |
| Bundle Size | Zero runtime. Reduced Facebook CSS from 15–45MB to ~200–300KB |

**Used by:** Meta (Facebook, Instagram, WhatsApp, Messenger, Threads), Figma, Snowflake.

**See it:** https://www.threads.net/ (Threads by Meta — production app built with StyleX. Also facebook.com, instagram.com)

**Pros:** Battle-tested at Meta scale. Atomic CSS output plateaus as app grows. Full TypeScript. RSC compatible.
**Cons:** Still pre-1.0 (v0.17.x). Smaller community. Designed for scale — overkill for a blog. Requires bundler plugin.

---

### 7. Pigment CSS (MUI)

**What:** Zero-runtime CSS-in-JS from the Material UI team. Extracts styles to static CSS at build time.

| Metric | Value |
|---|---|
| GitHub Stars | ~1,100 |
| npm Downloads/week | ~61k |
| Latest Version | v0.0.30 (January 2025) |
| First Released | 2024 (~2 years) |
| Bundle Size | Zero runtime |

**Used by:** MUI / Material UI (planned default for future MUI versions).

**See it:** https://mui.com/material-ui/getting-started/templates/ (MUI template gallery — dashboard, blog, marketing page, sign-in)

**Pros:** Natural MUI upgrade path. 20% reduction in first-load JS vs Emotion. RSC compatible.
**Cons:** **Still alpha.** No releases since January 2025. Very small community. Tightly coupled to MUI.

---

### CSS Summary Table

| Library | Stars | npm/week | Runtime | TypeSafe | Age | Ecosystem Size |
|---|---|---|---|---|---|---|
| **Tailwind CSS** | 94.3k | 47.8M | Zero | Partial | 8.5yr | Massive |
| **UnoCSS** | 18.7k | 317k | Zero | Partial | 4.5yr | Medium |
| **Vanilla Extract** | 10.3k | 1.34M | Zero | Full TS | 5yr | Good |
| **Panda CSS** | 6k | 130k | Zero | Full TS | 3yr | Growing |
| **Open Props** | 5.3k | 31k | 4.4kB | No | 4yr | Small |
| **StyleX** | 9.1k | 14–38k | Zero | Full TS | 2.5yr | Small |
| **Pigment CSS** | 1.1k | 61k | Zero | Yes | 2yr | Tiny (alpha) |

---

## Part 2: React UI / Component Libraries (8 options)

### 1. shadcn/ui

**What:** Copy-paste component collection built on Radix UI + Tailwind CSS. You own the source code.

| Metric | Value |
|---|---|
| GitHub Stars | ~111,000 |
| npm Downloads/week | ~137k (CLI); actual usage much higher (code is copied, not installed) |
| Latest Version | shadcn@4.1.2 (March 2026) |
| First Released | 2023 (~3 years) |
| Styled/Headless | Pre-styled with Tailwind, but you own and modify everything |
| Accessibility | Inherits Radix UI's ARIA support |

**Used by:** Vercel (official adoption), widely across the Next.js ecosystem.

**See it:** https://tx.shadcn.com/ (Taxonomy — full app by the shadcn creator: blog, docs, auth pages, dashboard)

**Pros:** Beautiful defaults (Card, Typography, Badge, Table, Tabs). Full code ownership — no dependency lock-in. Massive community, thousands of blog templates. Tailwind-first.
**Cons:** Components copied into codebase = maintenance burden. Manual per-component install. Tight Tailwind coupling.

---

### 2. Radix UI (Primitives)

**What:** Headless (unstyled) UI component library. The foundation behind shadcn/ui.

| Metric | Value |
|---|---|
| GitHub Stars | ~18,700 |
| npm Downloads/week | ~3–4M (unified package); primitives collectively ~17M+ |
| Latest Version | `radix-ui` v1.4.3 |
| First Released | November 2020 (~5.5 years) |
| Styled/Headless | Fully headless |
| Accessibility | WAI-ARIA patterns, focus management, keyboard nav |

**Used by:** Vercel, Linear, WorkOS, CodeSandbox, Supabase.

**See it:** https://www.radix-ui.com/themes/playground (full page of styled components — toggle dark mode with Cmd+D, open theme panel with Cmd+C)

**Pros:** Battle-tested primitives (Dialog, Popover, Dropdown, Tooltip). Zero style opinions = full design freedom. Tree-shakable.
**Cons:** Must build all styling yourself. No page-level components. Development pace has slowed since WorkOS acquisition.

---

### 3. Mantine

**What:** Full-featured React component library. 120+ components, 100+ hooks, form management, rich text editor, notifications.

| Metric | Value |
|---|---|
| GitHub Stars | ~30,900 |
| npm Downloads/week | ~1.2M (`@mantine/core`) |
| Latest Version | v9.0.0 (March 31, 2026) |
| First Released | January 2021 (~5 years, 200+ releases) |
| Styled/Headless | Comes with full design system (CSS Modules internally). Also supports Tailwind |
| Accessibility | Built-in ARIA, keyboard nav, focus management |

**Used by:** Microsoft, CodeParrot, SegmentX, many startups.

**See it:** https://mantine-analytics-dashboard.netlify.app/ (full analytics dashboard — charts, tables, kanban, calendar, chat)

**Pros:** Most complete all-in-one: RichTextEditor (Tiptap-based), code highlighting, notifications, forms, dates. Excellent docs. Built-in dark mode. v9 just released.
**Cons:** Opinionated styling (harder to make unique). Larger bundle. Tied to Mantine ecosystem.

---

### 4. React Aria (Adobe)

**What:** Headless hooks and component library focused on accessibility. Part of Adobe's React Spectrum.

| Metric | Value |
|---|---|
| GitHub Stars | ~15,000 (react-spectrum monorepo) |
| npm Downloads/week | ~1.8M (`react-aria-components`) |
| Latest Version | v1.16.0 (March 2026) |
| First Released | ~2019 (~7 years) |
| Styled/Headless | Fully headless |
| Accessibility | **Gold standard.** WAI-ARIA, 30+ language localizations, RTL, internationalized dates/numbers |

**Used by:** Adobe (Creative Cloud, Experience Platform), Untitled UI.

**See it:** https://react-spectrum.adobe.com/react-spectrum/index.html (React Spectrum — Adobe's styled layer on React Aria, 50+ components in Adobe's design language)

**Pros:** Best-in-class accessibility and i18n. Adobe-backed enterprise reliability. Both hooks and component APIs.
**Cons:** Steeper learning curve (verbose API). No visual output. Smaller template ecosystem. Overkill for a simple English-only blog.

---

### 5. Headless UI (Tailwind Labs)

**What:** Small set of unstyled, accessible components designed for Tailwind CSS.

| Metric | Value |
|---|---|
| GitHub Stars | ~28,500 |
| npm Downloads/week | ~3.3–4.2M |
| Latest Version | v2.2.9 (September 2025) |
| First Released | September 2020 (~5.5 years) |
| Styled/Headless | Fully headless, designed for Tailwind |
| Accessibility | Good — keyboard nav, focus management, ARIA |

**Used by:** Tailwind UI (paid component kit), broadly in the Tailwind ecosystem.

**See it:** https://tailwindcss.com/plus/templates/spotlight (Spotlight — polished personal site template by Tailwind team, built with Headless UI)

**Pros:** Official Tailwind companion. Simple API. Lightweight. Well-documented.
**Cons:** **Very limited** — only ~10–16 components. No forms, tables, toasts. Last release September 2025. Need supplemental libraries.

---

### 6. HeroUI (formerly NextUI)

**What:** Styled React component library built on React Aria + Tailwind CSS.

| Metric | Value |
|---|---|
| GitHub Stars | ~28,800 |
| npm Downloads/week | ~120k |
| Latest Version | v3.0.2 (April 3, 2026) |
| First Released | ~2021 as NextUI, rebranded January 2025 (~5 years) |
| Styled/Headless | Styled with Tailwind. Not headless |
| Accessibility | Strong — inherits React Aria |

**Used by:** Tidyread, Quantera.ai, popular with Next.js developers.

**See it:** https://landing-template-nextui.vercel.app/ (SaaS landing page — hero, features, pricing cards)

**Pros:** Beautiful modern design out of the box. Tailwind customization. React Aria accessibility.
**Cons:** Rebrand adds confusion (NextUI→HeroUI). Smaller community than Mantine/Radix. Lower npm downloads = less battle-testing.

---

### 7. Ark UI

**What:** Headless UI library built on Zag.js state machines, from the Chakra UI team.

| Metric | Value |
|---|---|
| GitHub Stars | ~5,100 |
| npm Downloads/week | ~544k |
| Latest Version | Active development (5,500+ commits) |
| First Released | ~2023 (~3 years) |
| Styled/Headless | Fully headless |
| Accessibility | WAI-ARIA via Zag.js state machines |

**Used by:** Chakra UI ecosystem. Park UI is built on top of it.

**See it:** https://park-ui.com/ (Park UI — the styled layer for Ark UI, browse components with theme customization)

**Pros:** State-machine-driven = predictable and bug-resistant. Framework-agnostic (React, Vue, Solid, Svelte). 45+ components. Clean API.
**Cons:** Smaller community. Fewer blog examples. Must build all styles. Still young.

---

### 8. Park UI

**What:** Pre-styled component collection built on Ark UI + Panda CSS (or Tailwind). Similar to shadcn/ui for the Chakra ecosystem.

| Metric | Value |
|---|---|
| GitHub Stars | ~2,300 |
| npm Downloads/week | Low (distributed as source code via CLI) |
| Latest Version | Active development |
| First Released | ~2023 (~3 years) |
| Styled/Headless | Pre-styled (Panda CSS or Tailwind variants) |
| Accessibility | Inherits Ark UI's accessibility |

**Used by:** Chakra/Panda CSS ecosystem adopters.

**See it:** https://park-ui.com/ (styled components on Ark UI + Panda CSS — buttons, dialogs, menus, date pickers with theme colors)

**Pros:** shadcn/ui alternative for Panda CSS users. Code ownership model. Multiple style variants.
**Cons:** Very small community. Young project. Tightly coupled to Ark/Panda ecosystem.

---

### React UI Summary Table

| Library | Stars | npm/week | Type | Styled? | Age | Component Count |
|---|---|---|---|---|---|---|
| **shadcn/ui** | 111k | 137k (CLI) | Copy-paste | Tailwind styled | 3yr | 50+ |
| **Mantine** | 30.9k | 1.2M | Full library | Yes (CSS Modules) | 5yr | 120+ |
| **HeroUI** | 28.8k | 120k | Full library | Yes (Tailwind) | 5yr | 40+ |
| **Headless UI** | 28.5k | 3.3M | Headless | No | 5.5yr | ~16 |
| **Radix UI** | 18.7k | 3–4M | Headless | No | 5.5yr | 30+ |
| **React Aria** | 15k | 1.8M | Headless | No | 7yr | 40+ |
| **Ark UI** | 5.1k | 544k | Headless | No | 3yr | 45+ |
| **Park UI** | 2.3k | Low | Copy-paste | Yes (Panda/TW) | 3yr | 40+ |

---

## Recommended Combinations for This Blog

### Option A: Astro + Tailwind CSS + shadcn/ui (Safe, Popular)
The most ecosystem support. Tons of blog templates and examples. Fastest to get started.

### Option B: Astro + Tailwind CSS + Radix UI (Flexible)
Tailwind for styling, Radix for interactive primitives. Full design control. More work but more unique.

### Option C: Astro + Vanilla Extract + Radix UI (Type-Safe Purist)
Full TypeScript safety for styles. Zero runtime. More boilerplate but very clean architecture.

### Option D: Astro + Panda CSS + Park UI (Chakra Successor)
Modern CSS-in-JS without runtime cost. Design tokens built in. Smaller ecosystem but growing.

### Option E: Astro + Mantine (Batteries-Included)
Everything in one box: components, hooks, rich text editor, dark mode. Trade off design uniqueness for speed.
