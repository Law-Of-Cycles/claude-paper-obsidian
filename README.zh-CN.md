# Claude Paper

Claude Paper 是一套非官方 Obsidian 主题。它参考 Claude 与 Anthropic 温暖、克制、适合长时间阅读的视觉语言，将陶土橙、纸张底色、英文衬线正文、清晰的中文宋体和精确的等宽代码字体组合在一起，并完整支持亮色与暗色模式。

> 本项目由 Law-Of-Cycles 独立制作，与 Anthropic 没有隶属、授权、赞助或合作关系。Claude 与 Anthropic 是 Anthropic PBC 的商标。项目没有打包 Anthropic 素材，也没有分发商业字体文件。

[English README](README.md)

![Claude Paper 总览](screenshot.png)

## 预览

| 亮色模式 | 暗色模式 |
| --- | --- |
| ![Claude Paper 亮色模式](docs/images/light-mode.png) | ![Claude Paper 暗色模式](docs/images/dark-mode.png) |

![Markdown 排版示意](docs/images/typography.png)

## 这次完善了什么

- 英文、中文、代码使用三套独立字体回退链
- 一级到六级标题在阅读视图和实时预览中都有清楚层级
- 加粗、英文真斜体、高亮、链接、标签、引用、列表、任务、表格、Callout、脚注和属性均有完整样式
- 暗色模式单独配色，不会退回 Obsidian 默认外观
- 标签页、文件树、菜单、搜索、状态栏、嵌入内容和代码块统一设计
- 兼顾窄屏、打印和减少动画的无障碍设置
- 纯 CSS，不联网，不收集数据，也不内置任何字体文件

## 字体方案

Anthropic 品牌视觉采用 Styrene 与 Tiempos 的组合。这两套属于商业字体，因此主题只会在你的电脑已经合法安装时自动调用。没有安装也没关系，Windows 回退链已经配好。

| 用途 | 字体调用顺序 |
| --- | --- |
| 界面和标题 | Styrene → Segoe UI Variable → Segoe UI → 思源宋体 |
| 英文正文 | Tiempos Text → Source Serif 4 → Georgia → Times New Roman |
| 中文正文 | Source Han Serif → 思源宋体 → 微软雅黑 |
| 代码 | SF Mono → Cascadia Mono → Consolas → 思源宋体 |

你已经安装的 **Source Han Serif + SF Mono** 会继续负责中文和代码。英文会优先使用 Tiempos、Source Serif 4 或 Windows 自带的 Georgia，因此英文斜体会有真正的 italic 字形。详细原理和下载地址见 [字体说明](docs/FONTS.md)。

## Windows 一键安装

1. 解压项目 ZIP。
2. 双击 `install.cmd`。
3. 按提示选择 Obsidian 仓库文件夹。
4. 打开 Obsidian 的“设置 → 外观 → 主题”，选择 **Claude Paper**。

也可以在项目目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

## 一键发布到 GitHub 和 Obsidian 社区主题库

直接双击 `publish.cmd` 即可。也可以在项目目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\publish.ps1
```

脚本会自动完成以下工作：

- 检查并安装 Git 与 GitHub CLI
- 确认当前 GitHub 账号是 `Law-Of-Cycles`
- 创建并推送 `Law-Of-Cycles/claude-paper-obsidian`
- 创建 `1.0.0` Release，并上传 `manifest.json` 与 `theme.css`
- Fork Obsidian 官方发布仓库
- 写入社区主题条目
- 创建审核 Pull Request

如果电脑尚未登录 GitHub，浏览器会打开一次授权页面。审核与最终收录由 Obsidian 团队完成，这一步无法由本地脚本代替。故障处理见 [发布说明](PUBLISH.md)。

## 手动安装

在仓库内新建下面的目录，并把 `manifest.json` 和 `theme.css` 放进去：

```text
<你的仓库>/.obsidian/themes/Claude Paper/
```

重启 Obsidian，然后在“设置 → 外观 → 主题”里启用。

## 自定义

字体、强调色和正文宽度都集中在 `theme.css` 顶部的 `:root` 中。修改那里即可，不用在七百多行 CSS 里到处查找。

更完整的颜色与组件规则见 [视觉规范](docs/STYLE-GUIDE.md)。

## 许可

[MIT](LICENSE) © Law-Of-Cycles
