# Font strategy

Claude Paper uses one bilingual serif family for the interface and document surface, plus one monospaced family for code. This keeps Chinese and English visually coherent while preserving the precision expected from code.

## Theme defaults

```css
/* Interface, headings, editing, and reading */
"SourceHanSerifSC-VF", "Source Han Serif SC VF", "Source Han Serif VF",
"Source Han Serif SC", "Source Han Serif", "思源宋体 CN", "思源宋体",
"Noto Serif CJK SC", "Songti SC", serif;

/* Inline code, fenced code, Markdown marks, and numeric markers */
"SF Mono", "SFMono-Regular", "Cascadia Mono", "Cascadia Code",
Consolas, "Liberation Mono", monospace;
```

`SourceHanSerifSC-VF` is normally a font filename. CSS selects an installed font by its registered family name, which can vary across packages and operating systems. The aliases above let the same theme match the common registrations without requiring a per-machine edit.

## Obsidian font overrides

The theme defines only these theme defaults:

```css
--font-interface-theme: var(--claude-paper-font-serif);
--font-text-theme: var(--claude-paper-font-serif);
--font-monospace-theme: var(--claude-paper-font-code);
```

Obsidian combines them with the choices under **Settings → Appearance → Fonts**. A font selected there therefore remains the final override.

## Italic text

Source Han Serif includes broad Latin and CJK coverage but does not include a dedicated italic family. Markdown emphasis tries Source Serif 4, Source Serif Pro, Georgia, and Times New Roman for true English italics, then falls back to Source Han Serif for Chinese. The regular interface and body remain entirely in Source Han Serif.

## Installation check

The Windows installer checks the user and system font registries after copying the theme. Its completion message reports whether a Source Han Serif SC family and SF Mono were detected. Fonts remain external to the project and are never downloaded automatically.

After adding or changing a font, fully quit and reopen Obsidian so Electron rebuilds its font list.

## Upstream projects

- Source Han Serif: <https://github.com/adobe-fonts/source-han-serif>
- Source Serif 4: <https://github.com/adobe-fonts/source-serif>
- Cascadia Code fallback: <https://github.com/microsoft/cascadia-code>

SF Mono is referenced only by family name and is not redistributed.
