# サントリー標準テーマ — 日本語デザインリファレンス

共通仕様は `design-system.md` を参照。このファイルは日本語プレゼンテーション固有のフォント・サイズ・注意点を定義する。

---

## 1. フォント定数

```python
FONT = "Meiryo UI"
FONT_NUM = "Calibri"
# フォールバック: Yu Gothic → MS Gothic
```

---

## 2. タイポグラフィ

| 用途 | フォント | サイズ | ウェイト | カラー |
|------|---------|--------|---------|--------|
| 表紙タイトル | Meiryo UI | 32pt | Bold | `C_DARK` |
| 表紙サブタイトル | Meiryo UI | 14pt | Regular | `C_CYAN` |
| タイトル（idx=15） | Meiryo UI | 24pt | Bold | `C_DARK` |
| キーメッセージ（idx=10） | Meiryo UI | 16pt | Regular | `C_TEXT` |
| アジェンダ項目 | Meiryo UI | 24pt | Regular | `C_DARK` |
| セクションヘッダー | Meiryo UI | 14-16pt | Bold | `C_DARK` |
| 本文 | Meiryo UI | 12-14pt | Regular | `C_TEXT` |
| 小テキスト | Meiryo UI | 10-12pt | Regular | `C_TEXT` |
| 大数値（KPI） | Calibri | 36-40pt | Bold | `C_CYAN` |
| 中数値 | Calibri | 20-22pt | Bold | `C_CYAN` |
| ソースライン | Meiryo UI | 10pt | Italic | `C_MUTED` |
| ページ番号 | Meiryo UI | 8pt | Regular | `C_MUTED` |

---

## 3. 日本語特有の注意点

- **フォント統一**: 見出し・本文ともに Meiryo UI。英数字やデータ数値のみ Calibri を使用
- **文字サイズ**: 日本語は英語より1-2pt大きめ設定（可読性確保のため）
- **テキストボックスの幅**: 日本語テキストは英語より横幅が必要。余裕を持った幅設定を行う
- **句読点**: 全角の「。」「、」を使用
- **敬語レベル**: ビジネス文書として「です・ます」調を基本とする
- **数字表記**: 大きな数字は漢数字と算用数字を適切に組み合わせる（例: 1.2兆円、340億円）
- **フォールバック**: Meiryo UIが利用できない環境では Yu Gothic → MS Gothic を代替

---

## 4. 使用例

```python
# フォント定数の設定
FONT = "Meiryo UI"
FONT_NUM = "Calibri"

# 表紙
set_ph_text(slide, 16, "NBD AI活用方針", size=Pt(32), color=C_DARK, bold=True)
set_ph_text(slide, 17, "データ基盤・分析・業務効率化の3軸でAIを推進", size=Pt(14), color=C_CYAN)
set_ph_text(slide, 18, "NBD IT")
set_ph_text(slide, 11, "2026年3月", size=Pt(10), color=C_MUTED)

# 本文スライド
slide = add_content_slide(
    title="AI活用の定義と目的",
    key_message="AI活用は「効率化」と「意思決定の高度化」の2軸で推進し、3プロジェクトが稼働中",
    page_num=1,
)

# セクションヘッダー
add_textbox(slide, Inches(0.5), Inches(CY), Inches(6), Inches(0.3),
            "稼働中の3プロジェクト", size=Pt(16), color=C_DARK, bold=True)
```
