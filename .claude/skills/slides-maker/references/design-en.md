# Suntory Standard Theme — English Design Reference

See `design-system.md` for common specifications (template, colors, layout, helpers). This file defines English-specific fonts, sizes, and guidelines.

---

## 1. English Template

Use the English template instead of the default Japanese one:

```python
TEMPLATE = os.path.expanduser("~/.claude/skills/slides-maker/references/assets/template-en.pptx")
```

The English template has the same layout names (`表紙`, `アジェンダ`, `本文`, `締め`) and placeholder indices as the Japanese version. Only the guide text is translated:
- 表紙: "Title", "Subtitle", "Date", "Department / Name", "Author"
- アジェンダ: "Agenda" header, "Agenda items" content
- 本文: "Title" (idx=15), "Key Message" (idx=10)
- 締め: "Thank You" (replaces "以上")

---

## 2. Font Constants

```python
FONT = "Calibri"
FONT_NUM = "Calibri"
# Fallback: Segoe UI → Arial
```

---

## 3. Typography

| Purpose | Font | Size | Weight | Color |
|---------|------|------|--------|-------|
| Cover title | Calibri | 32pt | Bold | `C_DARK` |
| Cover subtitle | Calibri | 13pt | Regular | `C_CYAN` |
| Title (idx=15) | Calibri | 22pt | Bold | `C_DARK` |
| Key message (idx=10) | Calibri | 14pt | Regular | `C_TEXT` |
| Agenda items | Calibri | 22pt | Regular | `C_DARK` |
| Section header | Calibri | 13-14pt | Bold | `C_DARK` |
| Body text | Calibri | 11-12pt | Regular | `C_TEXT` |
| Small text | Calibri | 9-10pt | Regular | `C_TEXT` |
| Large numbers (KPI) | Calibri | 36-40pt | Bold | `C_CYAN` |
| Medium numbers | Calibri | 20-22pt | Bold | `C_CYAN` |
| Source line | Calibri | 9pt | Italic | `C_MUTED` |
| Page number | Calibri | 8pt | Regular | `C_MUTED` |

**Note**: English text is generally 1-2pt smaller than Japanese equivalents since Latin characters are narrower and more compact.

---

## 4. English-Specific Guidelines

- **Font**: Use Calibri throughout. Calibri is clean, modern, and pairs well with the Suntory cyan palette
- **Font size**: English sizes are 1-2pt smaller than Japanese (e.g., JA title 24pt → EN title 22pt) since Latin glyphs are naturally more compact
- **Textbox width**: English text needs less width than Japanese — adjust textbox widths accordingly, but still allow comfortable margins
- **Tone**: Professional business English. Use active voice and concise sentences
- **Numbers**: Use standard formatting with commas (e.g., 1,200, $3.4M, 34%)
- **Date format**: "March 2026" or "Mar 2026" — not "2026/03"
- **Fallback fonts**: If Calibri is unavailable, use Segoe UI → Arial

---

## 5. Usage Examples

```python
# Font constants
FONT = "Calibri"
FONT_NUM = "Calibri"

# Cover slide
set_ph_text(slide, 16, "NBD AI Strategy", size=Pt(32), color=C_DARK, bold=True)
set_ph_text(slide, 17, "Driving AI across data platform, analytics, and operations", size=Pt(13), color=C_CYAN)
set_ph_text(slide, 18, "NBD IT")
set_ph_text(slide, 11, "March 2026", size=Pt(10), color=C_MUTED)

# Content slide
slide = add_content_slide(
    title="AI Strategy Overview",
    key_message="AI adoption focuses on two axes: operational efficiency and enhanced decision-making",
    page_num=1,
)

# Section header
add_textbox(slide, Inches(0.5), Inches(CY), Inches(6), Inches(0.3),
            "Active Projects", size=Pt(14), color=C_DARK, bold=True)
```
