# AI Agent Instructions for This Repository

This repository contains Power BI assets, including:
- Tabular models authored in **TMDL (Tabular Model Definition Language)**
- Power BI PBIP projects (semantic models and reports)
- Supporting SQL and documentation files

These instructions apply to **all AI-assisted analysis and edits**.

If a prompt or instruction conflicts with this file,  
**this file takes priority**.

When in doubt, prefer **analysis-only output** over making changes.

---

# A) TMDL Language Rules (Microsoft)

These describe how TMDL actually works.
They are strict and must be followed exactly.

1. **Indentation is semantic**
   - TMDL uses strict indentation to represent hierarchy.
   - The default rule is **single TAB indentation**.

2. **Structural indentation levels**
   - Object declaration level
   - Object properties level
   - Multi-line expressions under a property or default expression

3. **Multi-line expressions**
   - Must appear immediately after the property or object declaration.
   - Must be indented **one level deeper** than the parent properties.
   - Any outer indentation beyond that level is stripped by TMDL.

4. **Backtick-fenced expressions**
   - Enclosing an expression in triple backticks ``` preserves:
     - indentation
     - trailing whitespace
     - exact text
   - Microsoft recommends this when round-tripping could otherwise modify the expression.

5. **Object names**
   - Must be enclosed in **single quotes** if they contain special characters
     (including whitespace, `.`, `=`, `:`).
   - Single quotes inside names are escaped by doubling them.

6. **Property values**
   - Are single-line after `:`.
   - Text values may be enclosed in **double quotes**.
   - Double quotes are stripped during serialization.
   - Double quotes are **required** when the value has leading or trailing whitespace.

7. **Descriptions**
   - Are supported using `///` lines **directly above the object declaration**
     (tables, measures, columns, etc.).
   - They may span multiple lines.
   - No blank line may appear between the last `///` line and the object declaration.

8. **Object ordering**
   - Child objects do **not** need to be contiguous.
   - They may be declared in any order and intermingled.
   - Ordering does not affect validity.

9. **Whitespace behavior**
   - Property values may be trimmed.
   - Expressions drop trailing whitespace lines unless backtick-enclosed.
   - Backticks and double quotes change these default behaviors.

---

# B) Editing Discipline (LLM Safety Rules)

These are guardrails to prevent accidental breakage.

1. **Preserve formatting**
   - Preserve existing tabs and spaces exactly.
   - Do not reindent, align, or “pretty print.”
   - Do not normalize line endings or whitespace.

2. **Minimal diffs**
   - Only change lines required by the task.
   - Do not reorder objects or properties unless explicitly requested.
   - Do not perform cleanup or refactoring unless asked.

3. **Expressions**
   - Do not add comments inside DAX or M expressions.
   - If any multi-line expression is modified, prefer enclosing it in ``` 
     to avoid indentation and whitespace corruption.

4. **Documentation**
   - Use `///` above the object declaration for documentation.
   - Do NOT insert `description:` properties unless explicitly required.
   - Do NOT invent other comment syntaxes inside TMDL blocks.

5. **Output discipline**
   - When proposing changes:
     - Prefer unified diffs.
     - Include a short self-check confirming:
       - Tabs preserved
       - Only intended lines changed
       - Expressions fenced where modified

---

# C) Repository Purpose and Structure

This repository supports a Power BI reporting application with:

- **One shared semantic model (dataset)** feeding all reports
- **Multiple thin reports** built on top of that model
- Supporting SQL and documentation

The goal of AI-assisted work in this repository is to:
- Improve model quality, consistency, and documentation
- Analyse report usage against the underlying model
- Propose safe, reviewable changes via pull requests

---

# D) High-Level Structure (Indicative)

- dataset
  - FinanceModel.pbip
  - FinanceModel.SemanticModel
  - FinanceModel_DevScratch.Report

- reports
  - Exec
    - Exec.pbip
    - Exec.Report
  - Ops
    - Ops.pbip
    - Ops.Report
  - Sales
    - Sales.pbip
    - Sales.Report

- sql
  - one or more SQL files

- docs
  - markdown documentation files

---

# E) Source of Truth Rules

## Semantic Model

- The **only authoritative semantic model** is:
  - dataset → FinanceModel.SemanticModel
- All measures, relationships, metadata, and modelling changes must be made here.
- Do **not** create, modify, or infer additional semantic models elsewhere.

## Reports

- All folders under `reports` are **thin reports**.
- These reports reference the shared semantic model.
- Reports may be analysed to determine:
  - Which measures are used
  - Which fields appear in visuals, filters, or slicers
- Reports may be edited **only when explicitly instructed**.

---

# F) Dev-Only / Non-Published Content

The following content exists for development purposes only and is **not published**:

- dataset → FinanceModel_DevScratch.Report

Rules:
- Do not refactor, enhance, or optimise this report.
- Do not treat it as representative for usage analysis.
- You may ignore this folder entirely unless explicitly instructed otherwise.

---

# G) Change Strategy and Safety

When identifying unused or questionable items:

1. Prefer **analysis-only output first** (lists, markdown, CSV).
2. Recommend **hiding or archiving** rather than deleting.
3. Preserve all dependencies (measure-to-measure, calculation groups, filters).
4. Assume reports may contain:
   - Hidden visuals
   - Tooltips
   - Drillthrough pages
   - Conditional formatting references

If uncertain, **do not modify**. Report findings instead.

---

# H) Pull Request Expectations

All changes must:
- Be scoped to the request
- Be clearly explained in the pull request description
- Avoid unrelated refactors
- Preserve the ability to open all PBIP projects in Power BI Desktop

If a requested change risks breaking a report or model:
- Explain the risk
- Propose a safer alternative

---

# I) Final Instruction

When in doubt:

**Explain, don’t edit.**

Your job is to assist safely, not to guess intent.