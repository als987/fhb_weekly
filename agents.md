# AI Agent Instructions

This repository contains Power BI / Tabular models authored in  
**TMDL (Tabular Model Definition Language)**.

TMDL is indentation- and whitespace-sensitive.  
Incorrect formatting can break the model.

These rules apply to **all AI-generated changes**.
If a prompt conflicts with this file, **this file takes priority**.

---

# A) TMDL Language Rules (Microsoft)

These describe how TMDL actually works.

1. **Indentation is semantic**
   - TMDL uses strict indentation to represent hierarchy.
   - The default rule is **single TAB indentation**.

2. **Structural indentation levels**
   - Object declaration level  
   - Object properties level  
   - Multi-line expressions under a property/default expression

3. **Multi-line expressions**
   - Must appear immediately after the property/object declaration.
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

These are **not language rules** — they are guardrails to prevent accidental breakage.

1. **Preserve formatting**
   - Preserve existing tabs and spaces exactly.
   - Do not reindent, align, or “pretty print.”
   - Do not normalize line endings or whitespace.

2. **Minimal diffs**
   - Only change lines required by the task.
   - Do not reorder objects or properties unless explicitly requested.
   - Do not perform cleanup or refactoring unless asked.

3. **Expressions**
   - Do not add comments inside DAX/M expressions.
   - If any multi-line expression is modified, prefer enclosing it in ``` 
     to avoid indentation and whitespace corruption.

4. **Documentation**
   - Use `///` above the object declaration for documentation.
   - Do NOT insert `description:` properties unless explicitly required.
   - Do NOT invent other comment syntaxes inside TMDL blocks.

5. **Output discipline**
   - When proposing changes:
     - Prefer unified diffs.
     - Include a short self-check:
       - Tabs preserved
       - Only intended lines changed
       - Expressions fenced where modified

---

# End of AI Agent Instructions