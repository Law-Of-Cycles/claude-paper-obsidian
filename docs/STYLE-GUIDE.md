# Claude Paper style guide

Claude Paper starts from the original appearance values supplied for this project and develops them into a complete Obsidian system.

## Core palette

| Token | Light | Dark | Purpose |
| --- | --- | --- | --- |
| Accent | `#da7756` | `#e59a73` | Links, active states, H2 rule, checkboxes |
| Ink | `#1d1b16` | `#e9e3d8` | Main text |
| Surface | `#f5f3ee` | `#1c1916` | Editor background |
| Raised paper | `#fbfaf7` | `#24201c` | Cards, menus, callouts |
| Divider | `#d9d1c6` | `#3b332d` | Borders and hierarchy |
| Added | `#00c853` | adjusted by Obsidian syntax variables | Diff additions |
| Removed | `#ff5f38` | adjusted by Obsidian syntax variables | Diff removals |

The dark palette is designed independently for contrast and visual weight. It is not a filter applied to the light palette.

## Markdown hierarchy

- **Inline title and H1:** display face, strong weight, fine divider
- **H2:** compact display face with a clay left rule
- **H3:** quieter display heading for sections within sections
- **H4:** accent color for compact labels
- **H5 and H6:** uppercase, increased tracking, progressively quieter color
- **Bold:** weight plus a soft clay underline so it remains visible in dense Chinese text
- **Italic:** true Latin italic where available, accent tint, and restrained underline
- **Highlight:** marker-like lower-half fill
- **Quote:** clay rule with a soft tinted panel

## Layout

- Reading width: `820px`
- Main text size: `17px`, reduced to `16px` below `700px`
- Body line height: `1.82`
- Rounded corners: `6px`, `10px`, and `14px`
- Motion follows the operating system's reduced-motion preference

## Accessibility decisions

- Light and dark palettes keep text and controls visually separated
- Color is reinforced by borders, underlines, weight, or shape
- Focus and selection use the same accent family consistently
- Code ligatures are disabled to preserve literal character recognition
- Print mode removes dark surfaces and unnecessary workspace chrome
