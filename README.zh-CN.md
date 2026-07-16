# Claude Paper

Claude Paper 是一套非官方 Obsidian 主题。它参考 Claude 与 Anthropic 温暖、克制、适合长时间阅读的视觉语言，将陶土橙、安静的纸张底色、统一的中英文宋体和精确的等宽代码字体组合在一起，并完整支持亮色与暗色模式。

> 本项目由 Law-Of-Cycles 独立制作，与 Anthropic 没有隶属、授权、赞助或合作关系。Claude 与 Anthropic 是 Anthropic PBC 的商标。项目没有打包 Anthropic 素材，也没有分发商业字体文件。

[English README](README.md)

![Claude Paper 总览](screenshot.png)

## 预览

| 亮色模式 | 暗色模式 |
| --- | --- |
| ![Claude Paper 亮色模式](docs/images/light-mode.png) | ![Claude Paper 暗色模式](docs/images/dark-mode.png) |

![Markdown 排版示意](docs/images/typography.png)

## 这次完善了什么

- 界面、标题、编辑区和阅读视图统一使用思源宋体 SC 可变字体
- 所有行内代码、代码块和 Markdown 格式标记统一优先使用 SF Mono
- 同时兼容 `SourceHanSerifSC-VF` 文件名与常见字体家族注册名
- 一级到六级标题在阅读视图和实时预览中都有清楚层级
- 加粗、斜体、高亮、链接、标签、引用、列表、任务、表格、Callout、脚注和属性均有完整样式
- 暗色模式单独配色，不会退回 Obsidian 默认外观
- 标签页、文件树、控件、设置、搜索、关系图、Canvas、嵌入内容和代码块统一设计
- 兼顾键盘焦点、高对比度、窄屏、打印和减少动画设置
- 纯 CSS，不联网，不收集数据，也不内置任何字体文件

## 字体方案

主题围绕你指定的两套本地字体设计。界面与普通文档内容保持同一套中英文字体，避免一行文字在中英文之间出现突兀的风格切换；代码区域保持独立的等宽节奏。

| 用途 | 字体调用顺序 |
| --- | --- |
| 界面、标题和正文 | `SourceHanSerifSC-VF` 别名 → Source Han Serif SC → Source Han Serif → 思源宋体 |
| 代码 | SF Mono → SFMono-Regular → Cascadia Mono → Cascadia Code → Consolas |
| 英文真斜体回退 | Source Serif 4 → Source Serif Pro → Georgia → Times New Roman |

主题只设置 Obsidian 的主题字体变量，因此你在“设置 → 外观”中手动选择的字体仍然拥有最高优先级。项目不会打包或下载字体。具体别名与排查方式见 [字体说明](docs/FONTS.md)。

## Windows 一键安装

1. 解压项目 ZIP。
2. 双击 `install.cmd`。
3. 按提示选择 Obsidian 仓库文件夹。
4. 打开 Obsidian 的“设置 → 外观 → 主题”，选择 **Claude Paper**。

安装完成窗口会同时显示 Windows 是否识别到 Source Han Serif SC 与 SF Mono。

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
- 读取 `manifest.json` 中的当前版本，创建或刷新对应 Release
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

字体别名、强调色和正文宽度都集中在 `theme.css` 顶部。修改那里即可，无需在整份 CSS 中逐项查找。

更完整的颜色与组件规则见 [视觉规范](docs/STYLE-GUIDE.md)。

## 许可

[MIT](LICENSE) © Law-Of-Cycles
