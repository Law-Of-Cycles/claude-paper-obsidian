# Font strategy

Claude Paper separates interface, headings, body text, and code. This avoids forcing one typeface to do jobs it was not designed for.

## Brand reference and licensing

Geist's Anthropic identity case study describes a pairing of **Styrene** and **Tiempos**. Both families are commercially licensed. Claude Paper references their installed family names but does not include, download, or redistribute them.

- Anthropic identity case study: <https://geist.co/work/anthropic>
- Styrene foundry page: <https://commercialtype.com/catalog/styrene>
- Tiempos foundry page: <https://klim.co.nz/retail-fonts/tiempos/>

## Default fallback chains

```css
/* Interface and headings */
"Styrene B", "Styrene A", Styrene,
"Segoe UI Variable", "Segoe UI",
"Source Han Serif", "思源宋体", "Microsoft YaHei UI", sans-serif;

/* Reading and editing */
"Tiempos Text", Tiempos, "Source Serif 4", Georgia, "Times New Roman",
"Source Han Serif", "思源宋体", "Microsoft YaHei", serif;

/* Code */
"SF Mono", "Cascadia Mono", Consolas,
"Source Han Serif", "思源宋体", "Microsoft YaHei", monospace;
```

Font fallback happens per glyph. A Latin-only English face can render the English characters, while Source Han Serif renders Chinese characters on the same line.

## Why English needed its own fallback

Source Han Serif contains useful Latin glyphs, but it is primarily a pan-CJK family and does not provide the same dedicated italic family expected from an editorial Latin typeface. Markdown emphasis looks more natural when English text can use a true italic face from Tiempos, Source Serif 4, Georgia, or Times New Roman.

Claude Paper keeps synthesized style support enabled for CJK emphasis, because a slanted CJK fallback remains more visible than silently ignoring italic markup.

## Recommended Windows setup

### Already sufficient

- **Source Han Serif** for Chinese
- **SF Mono** for code
- **Georgia** from Windows for English body and italics
- **Segoe UI** from Windows for interface and headings

### Optional free upgrade

Install Adobe's open-source **Source Serif 4**, including Roman and Italic variable fonts:

- Project and releases: <https://github.com/adobe-fonts/source-serif>

For a freely distributed code font on Windows, Cascadia Code includes Cascadia Mono:

- Project and releases: <https://github.com/microsoft/cascadia-code>

After installing fonts, fully quit and reopen Obsidian so Electron rebuilds its font list.

## Registered family names matter

CSS must use the registered Windows family name, which can differ from a downloaded filename. Open **Settings → Personalization → Fonts**, select the font, and copy its displayed family name. The theme already includes the names seen most often for Source Han Serif and SF Mono.

