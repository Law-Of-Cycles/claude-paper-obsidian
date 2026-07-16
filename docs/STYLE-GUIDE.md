# Claude Paper style guide

Claude Paper translates Claude's warm, quiet interface language into Obsidian while keeping the theme practical for long bilingual notes.

## Core palette

| Token | Light | Dark | Purpose |
| --- | --- | --- | --- |
| Accent | `#d97757` | `#e38b6b` | Selection, active states, checks, structural emphasis |
| Ink | `#141413` | `#faf9f5` | Primary text |
| Secondary ink | `#3d3d3a` | `#c2c0b6` | Supporting text |
| Editor surface | `#faf9f5` | `#30302e` | Editing and reading background |
| Sidebar surface | `#f5f4ed` | `#262624` | Navigation and secondary panes |
| Raised surface | `#ffffff` | `#383835` | Menus, dialogs, and cards |
| Code surface | `#f1efe8` | `#242422` | Inline and fenced code |

Borders use translucent ink instead of a separate opaque gray. This keeps the hierarchy consistent as surfaces change.

## Typography

- Interface, headings, editing, and reading use Source Han Serif SC Variable.
- Code and Markdown formatting marks use SF Mono.
- Body text is `17px` with a `1.72` line height and a `780px` readable width.
- Heading levels use a restrained size and weight ladder without forced uppercase, wide tracking, or decorative underlines that disturb Chinese text.
- Bold relies on weight. Italic relies on a real Latin italic fallback where available. Highlight uses a quiet full-glyph wash.
- CJK line breaking is strict, and supported Electron versions receive automatic spacing between Chinese and Latin runs.

## Interface language

- Light surfaces follow the public Claude token family of `#faf9f5`, `#f5f4ed`, and `#141413`.
- Dark surfaces follow `#30302e`, `#262624`, and `#141413`, with softened warm text.
- Corners use `4px`, `6px`, `8px`, and `12px` radii.
- Active navigation uses a warm tint and text color. Active tabs add a narrow clay indicator.
- Shadows remain short and low contrast. Borders carry most of the structure.

## Compatibility and accessibility

- Theme-level font variables preserve Obsidian Appearance overrides.
- Live Preview heading rhythm uses padding instead of vertical margins.
- The CSS avoids remote assets, `@import`, `:has()`, and `!important`.
- Keyboard focus, increased contrast, reduced motion, forced colors, small screens, and print are handled explicitly.
- Code ligatures are disabled to preserve literal character recognition.
