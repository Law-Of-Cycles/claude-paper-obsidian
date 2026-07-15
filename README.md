# Claude Paper

An unofficial Obsidian theme inspired by Claude and Anthropic's warm, thoughtful visual language. It combines clay accents, paper-like surfaces, editorial body text, restrained interface typography, and matched light and dark modes.

> Claude Paper is an independent community project by Law-Of-Cycles. It is not affiliated with, endorsed by, or sponsored by Anthropic. Claude and Anthropic are trademarks of Anthropic PBC. No Anthropic artwork or commercial font files are included.

[简体中文说明](README.zh-CN.md)

![Claude Paper overview](screenshot.png)

## Preview

| Light mode | Dark mode |
| --- | --- |
| ![Claude Paper light mode](docs/images/light-mode.png) | ![Claude Paper dark mode](docs/images/dark-mode.png) |

![Markdown typography specimen](docs/images/typography.png)

## Highlights

- A complete English, CJK, and code font strategy with sensible Windows fallbacks
- Six clearly differentiated heading levels in Reading View and Live Preview
- Refined bold, real English italics, highlights, links, tags, quotes, lists, tasks, tables, callouts, footnotes, and properties
- Warm light mode and purpose-built dark mode using the same visual hierarchy
- Polished tabs, navigation, menus, search, status bar, embeds, and code blocks
- Responsive small-screen layout, print rules, and reduced-motion support
- Pure CSS with no telemetry, network requests, scripts, or bundled font files

## Typography

Anthropic's identity work uses Styrene with Tiempos. Those are commercial typefaces, so this project only detects them when they are already installed. The included fallback stacks make the theme look intentional without them.

| Role | Preferred order on Windows |
| --- | --- |
| Interface and headings | Styrene, Segoe UI Variable, Segoe UI, Source Han Serif |
| English body text | Tiempos Text, Source Serif 4, Georgia, Times New Roman |
| Chinese body text | Source Han Serif, 思源宋体, Microsoft YaHei |
| Code | SF Mono, Cascadia Mono, Consolas, Source Han Serif |

For the best free bilingual setup, install **Source Serif 4**, **Source Han Serif**, and a mono font. Your existing **Source Han Serif + SF Mono** installation already covers Chinese and code; Georgia or Source Serif 4 supplies proper English italic faces. See [Font strategy](docs/FONTS.md) for details and download links.

## Install in Obsidian

### One-click local install on Windows

1. Extract the project ZIP.
2. Double-click `install.cmd`.
3. Select your vault folder when prompted, then choose **Claude Paper** in Obsidian under **Settings → Appearance → Themes**.

You can also run:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### Manual install

Create this folder inside your vault and copy `manifest.json` and `theme.css` into it:

```text
<your-vault>/.obsidian/themes/Claude Paper/
```

Restart Obsidian or use **Reload app without saving**, then select **Claude Paper**.

## Publish to the Obsidian community directory

Double-click `publish.cmd`. The Windows publishing assistant creates the GitHub repository under `Law-Of-Cycles`, pushes the project, creates release `1.0.0`, forks `obsidianmd/obsidian-releases`, adds the directory entry, and opens the review pull request.

```powershell
powershell -ExecutionPolicy Bypass -File .\publish.ps1
```

If GitHub CLI is not signed in, the script opens GitHub once for browser authorization. The detailed fallback procedure is in [PUBLISH.md](PUBLISH.md).

## Customize

The main editable values are at the top of `theme.css`:

```css
:root {
  --claude-paper-font-ui: ...;
  --claude-paper-font-heading: ...;
  --claude-paper-font-text: ...;
  --claude-paper-font-code: ...;
  --claude-paper-accent: #da7756;
  --claude-paper-content-width: 820px;
}
```

Color and component decisions are documented in the [style guide](docs/STYLE-GUIDE.md).

## Project files

- `theme.css`: the complete Obsidian theme
- `manifest.json`: community theme metadata
- `screenshot.png`: 512 × 288 community directory image
- `install.cmd` and `install.ps1`: local Windows installer
- `publish.cmd` and `publish.ps1`: GitHub and Obsidian submission assistant
- `docs/`: typography, style notes, and additional previews
- `.github/workflows/release.yml`: release asset verification and upload

## License

[MIT](LICENSE) © Law-Of-Cycles
