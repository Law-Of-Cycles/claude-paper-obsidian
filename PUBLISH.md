# Publish Claude Paper

The repository includes a Windows publishing assistant tailored to the GitHub account `Law-Of-Cycles`.

## One command

Double-click `publish.cmd` in the extracted project folder. If you prefer a terminal, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\publish.ps1
```

The script is safe to run again. Existing repositories, releases, directory entries, and pull requests are detected and reused.

## What the script does

1. Installs Git and GitHub CLI with `winget` when needed.
2. Opens GitHub's official browser login if the CLI has not been authorized.
3. Verifies that the authenticated account is `Law-Of-Cycles`.
4. Initializes the project repository and pushes `main`.
5. Creates release `1.0.0` with `manifest.json` and `theme.css` as separate assets.
6. Forks `obsidianmd/obsidian-releases`.
7. Adds the Claude Paper record to `community-css-themes.json` without reformatting unrelated entries.
8. Pushes a review branch and opens the official community theme pull request.

## What still requires a person

- GitHub may require one browser authorization.
- The Obsidian team reviews and merges community themes. Respond to any reviewer comment in the pull request created by the script.
- A theme name cannot be changed after acceptance, so confirm **Claude Paper** before the PR is merged.

## Official references

- Obsidian community releases: <https://github.com/obsidianmd/obsidian-releases>
- Manifest requirements: <https://docs.obsidian.md/Reference/Manifest>
- Developer policies: <https://docs.obsidian.md/Developer+policies>
- Theme guidelines: <https://docs.obsidian.md/Themes/App+themes/Theme+guidelines>
