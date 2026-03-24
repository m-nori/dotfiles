# サントリー標準テーマ デザインシステム（共通）

python-pptx を使用してサントリー社内標準スライドマスターに準拠したプレゼンテーションを作成するための共通設計仕様。

**言語別リファレンス:**
- 日本語: `design-ja.md` — フォント・サイズ・日本語特有の注意点
- 英語: `design-en.md` — フォント・サイズ・英語特有の注意点

---

## 1. テンプレートとレイアウト

### テンプレートの読み込み

```python
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.enum.shapes import MSO_SHAPE
from pptx.oxml.ns import qn
import os

TEMPLATE = os.path.expanduser("~/.claude/skills/slides-maker/references/assets/template.pptx")
prs = Presentation(TEMPLATE)

# マスター0のレイアウトを取得
master = prs.slide_masters[0]
layouts = {layout.name: layout for layout in master.slide_layouts}
```

### スライドレイアウト（マスター0）

| レイアウト | 用途 | プレースホルダー |
|-----------|------|-----------------|
| `表紙` | タイトル | idx=16: タイトル, idx=17: サブタイトル, idx=18: 部署, idx=11: 日付, idx=12: 作成者 |
| `アジェンダ` | 目次 | idx=10: コンテンツ, idx=4: ページ番号 |
| `本文` | コンテンツ | idx=15: **タイトル**, idx=10: **キーメッセージ**, idx=4: ページ番号 |
| `締め` | エンディング | なし（マスターに「以上」テキスト済み、追加不要） |

**重要**: ロゴ、シアンアクセントバー、左上矩形アクセント等はマスターに定義済み。手動配置は不要。

### 本文スライドの3ゾーン構造

```
┌─────────────────────────────────────────┐
│ idx=15: タイトル                         │ y: 0.13" - 0.52"  (h: 0.39")
│ Short topic title (matches agenda)      │ 24pt, Bold, C_DARK
├─────────────────────────────────────────┤
│ idx=10: キーメッセージ                    │ y: 0.81" - 1.51"  (h: 0.70")
│ Key insight / takeaway in one sentence  │ 16pt, C_TEXT
├─────────────────────────────────────────┤
│                                         │
│ Free-layout zone (CY = 1.6" onwards)   │ Textboxes, tables, shapes
│                                         │
└─────────────────────────────────────────┘
```

### スライドサイズ

```
13.33" x 7.5" (LAYOUT_WIDE)
```

---

## 2. カラートークン

```python
# === サントリー標準 カラーパレット ===
C_DARK    = RGBColor(0x3E, 0x3A, 0x39)   # 見出し、ダークテキスト
C_TEXT    = RGBColor(0x33, 0x33, 0x33)   # 本文
C_MUTED   = RGBColor(0x88, 0x88, 0x88)   # ソースライン、キャプション
C_WHITE   = RGBColor(0xFF, 0xFF, 0xFF)
C_BLACK   = RGBColor(0x1A, 0x1A, 0x1A)

C_CYAN    = RGBColor(0x00, 0xAB, 0xE4)   # プライマリ — チャート、強調
C_CYAN2   = RGBColor(0x5B, 0xC2, 0xDC)   # セカンダリ
C_CYAN3   = RGBColor(0x91, 0xD7, 0xE7)   # ターシャリ
C_CYAN4   = RGBColor(0xB3, 0xE4, 0xEF)   # クォータナリ
C_CYAN5   = RGBColor(0xD9, 0xF0, 0xF7)   # 最も薄い — 背景ティント

C_ORANGE  = RGBColor(0xFB, 0xAE, 0x40)   # アクセント（コールアウト、アラート）
C_CORAL   = RGBColor(0xF2, 0x6B, 0x43)   # ネガティブデルタ
C_GREEN   = RGBColor(0x2E, 0x7D, 0x32)   # ポジティブデルタ

C_GRID    = RGBColor(0xCD, 0xCA, 0xC9)   # テーブルボーダー
C_BGLIGHT = RGBColor(0xF0, 0xF8, 0xFC)   # 交互行背景
```

---

## 3. ヘルパー関数

### プレースホルダーテキスト設定

```python
def set_ph_text(slide, idx, text, font_name=FONT, size=Pt(11), color=C_TEXT, bold=False):
    """プレースホルダーにテキスト設定"""
    ph = slide.placeholders[idx]
    ph.text = text
    for p in ph.text_frame.paragraphs:
        for run in p.runs:
            run.font.name = font_name
            run.font.size = size
            run.font.color.rgb = color
            run.font.bold = bold
```

### テキスト設定

```python
def set_text(tf, text, font_name=FONT, size=Pt(11), color=C_TEXT, bold=False, alignment=PP_ALIGN.LEFT):
    """テキストフレームにテキストを設定"""
    tf.clear()
    tf.word_wrap = True
    p = tf.paragraphs[0]
    p.alignment = alignment
    run = p.add_run()
    run.text = text
    run.font.name = font_name
    run.font.size = size
    run.font.color.rgb = color
    run.font.bold = bold


def add_paragraph(tf, text, font_name=FONT, size=Pt(11), color=C_TEXT, bold=False, alignment=PP_ALIGN.LEFT, space_before=Pt(0)):
    """テキストフレームに段落を追加"""
    p = tf.add_paragraph()
    p.alignment = alignment
    p.space_before = space_before
    run = p.add_run()
    run.text = text
    run.font.name = font_name
    run.font.size = size
    run.font.color.rgb = color
    run.font.bold = bold
    return p
```

### テキストボックス追加

```python
def add_textbox(slide, left, top, width, height, text,
                font_name=FONT, size=Pt(11), color=C_TEXT, bold=False,
                alignment=PP_ALIGN.LEFT, valign=MSO_ANCHOR.TOP):
    """テキストボックスを追加"""
    txBox = slide.shapes.add_textbox(left, top, width, height)
    tf = txBox.text_frame
    tf.word_wrap = True
    tf.auto_size = None
    p = tf.paragraphs[0]
    p.alignment = alignment
    run = p.add_run()
    run.text = text
    run.font.name = font_name
    run.font.size = size
    run.font.color.rgb = color
    run.font.bold = bold
    # 垂直配置
    bodyPr = txBox.text_frame._txBody.find(qn("a:bodyPr"))
    anchor_map = {MSO_ANCHOR.TOP: "t", MSO_ANCHOR.MIDDLE: "ctr", MSO_ANCHOR.BOTTOM: "b"}
    bodyPr.set("anchor", anchor_map.get(valign, "t"))
    return txBox
```

### 矩形シェイプ追加

```python
def add_rect(slide, left, top, width, height, fill_color=None, line_color=None, line_width=Pt(0.5)):
    """矩形シェイプを追加"""
    shape = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left, top, width, height)
    shape.text = ""
    if fill_color:
        shape.fill.solid()
        shape.fill.fore_color.rgb = fill_color
    else:
        shape.fill.background()
    if line_color:
        shape.line.color.rgb = line_color
        shape.line.width = line_width
    else:
        shape.line.fill.background()
    return shape
```

### 矢印シェイプ追加

```python
def add_arrow(slide, left, top, width, height, fill_color=C_CYAN, direction="right"):
    """矢印シェイプを追加（テキスト矢印は使わない）"""
    shape_type = {
        "right": MSO_SHAPE.RIGHT_ARROW,
        "left": MSO_SHAPE.LEFT_ARROW,
        "down": MSO_SHAPE.DOWN_ARROW,
        "up": MSO_SHAPE.UP_ARROW,
    }[direction]
    shape = slide.shapes.add_shape(shape_type, left, top, width, height)
    shape.text = ""
    shape.fill.solid()
    shape.fill.fore_color.rgb = fill_color
    shape.line.fill.background()
    return shape
```

### テーブル追加

```python
def add_table(slide, left, top, rows_data, col_widths, headers):
    """スタイル付きテーブルを追加（FONT は言語別定数を使用）"""
    n_rows = len(rows_data) + 1
    n_cols = len(headers)
    table_shape = slide.shapes.add_table(n_rows, n_cols, left, top,
                                          sum(col_widths), Pt(25) * n_rows)
    table = table_shape.table

    for i, w in enumerate(col_widths):
        table.columns[i].width = w

    # ヘッダー行（シアン背景 + 白テキスト）
    for i, h in enumerate(headers):
        cell = table.cell(0, i)
        cell.text = h
        for p in cell.text_frame.paragraphs:
            p.alignment = PP_ALIGN.CENTER
            for run in p.runs:
                run.font.name = FONT
                run.font.size = Pt(11)
                run.font.bold = True
                run.font.color.rgb = C_WHITE
        cell.fill.solid()
        cell.fill.fore_color.rgb = C_CYAN

    # データ行（交互色）
    for r, row in enumerate(rows_data):
        for c, val in enumerate(row):
            cell = table.cell(r + 1, c)
            cell.text = str(val)
            for p in cell.text_frame.paragraphs:
                p.alignment = PP_ALIGN.LEFT
                for run in p.runs:
                    run.font.name = FONT
                    run.font.size = Pt(11)
                    run.font.color.rgb = C_TEXT
            cell.fill.solid()
            cell.fill.fore_color.rgb = C_WHITE if r % 2 == 0 else C_BGLIGHT

    return table_shape
```

---

## 4. スライドテンプレートの使い方

### 表紙

```python
slide = prs.slides.add_slide(layouts["表紙"])
set_ph_text(slide, 16, "Main Title", size=Pt(32), color=C_DARK, bold=True)
set_ph_text(slide, 17, "Subtitle", size=Pt(14), color=C_CYAN)
set_ph_text(slide, 18, "NBD IT")
set_ph_text(slide, 11, "March 2026", size=Pt(10), color=C_MUTED)
```

### アジェンダ

```python
slide = prs.slides.add_slide(layouts["アジェンダ"])

items = ["Item 1", "Item 2", "Item 3"]
tf = slide.placeholders[10].text_frame
tf.clear()
for i, item in enumerate(items):
    p = tf.paragraphs[0] if i == 0 else tf.add_paragraph()
    p.space_before = Pt(12)
    p.space_after = Pt(6)

    run_text = p.add_run()
    run_text.text = item
    run_text.font.name = FONT
    run_text.font.size = Pt(24)
    run_text.font.color.rgb = C_DARK
```

### 本文（コンテンツ）— add_content_slide ヘルパー

```python
def add_content_slide(title, key_message, page_num):
    """本文スライドを作成し、タイトルとキーメッセージを設定"""
    slide = prs.slides.add_slide(layouts["本文"])

    # タイトル（idx=15）: アジェンダレベルの短いトピック名
    set_ph_text(slide, 15, title, size=Pt(24), color=C_DARK, bold=True)

    # キーメッセージ（idx=10）: 洞察を述べる文
    ph10 = slide.placeholders[10]
    ph10.text = key_message
    ph10.left = Inches(0.37)
    ph10.top = Inches(0.81)
    ph10.width = Inches(12.6)
    ph10.height = Inches(0.7)
    for p in ph10.text_frame.paragraphs:
        for run in p.runs:
            run.font.name = FONT
            run.font.size = Pt(16)
            run.font.color.rgb = C_TEXT
            run.font.bold = False

    # ページ番号
    if 4 in slide.placeholders:
        slide.placeholders[4].text = str(page_num)

    return slide

# 自由配置コンテンツは CY = 1.6 以降
CY = 1.6
```

### 締め

```python
slide = prs.slides.add_slide(layouts["締め"])
# マスターに「以上」テキスト済み。追加のテキストボックスは不要。
```

---

## 5. 重要な注意事項（共通）

1. **テンプレートマスターを使う** — ロゴ・アクセントバーは手動配置しない
2. **タイトル（idx=15）は短いトピック名** — アジェンダと対応する簡潔なタイトル
3. **キーメッセージ（idx=10）は洞察文** — そのスライドで伝えたい結論を1文で
4. **キーメッセージの位置・サイズは明示指定** — left=0.37", top=0.81", width=12.6", height=0.7"
5. **自由配置は CY=1.6" 以降** — キーメッセージ下からコンテンツを配置
6. **セクション間にバッファ確保** — テーブルやセクションヘッダー間に0.2-0.3"の余白
7. **フォント設定はrun単位** — `run.font.*` で必ず設定する
8. **矢印はシェイプで** — テキスト矢印（→、▼）ではなく `MSO_SHAPE.RIGHT_ARROW` 等を使う
9. **`RGBColor`を使う** — python-pptxは `RGBColor(0x00, 0xAB, 0xE4)` 形式
10. **締めスライドは追加不要** — マスターに「以上」テキスト済み
