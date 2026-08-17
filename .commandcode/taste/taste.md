# Taste (Continuously Learned by [CommandCode][cmd])

[cmd]: https://commandcode.ai/

# Project Conventions
- Store planning documents and design plans in the `ai-docs/` project directory. Confidence: 0.70
- Use `agent-browser` CLI for browser automation/testing (set viewport, open URL, reload, screenshot) and save verification screenshots to `ai-docs/images/`. Confidence: 0.60
- Consult `ai-docs/` (design plans, frontend guide) as the authoritative reference when making design/styling decisions. Confidence: 0.70

# Package Management
- Use "bun" instead of "npm" for package management and dependency installation. Confidence: 0.70

# CSS / Tailwind
- Only use valid Tailwind CSS utility classes; do not invent or hallucinate non-existent classes. Confidence: 0.70

# Git
- Use conventional-commit format (feat:, fix:, chore:, docs:) for git commit messages that describe the change context. Confidence: 0.60
- On Windows (this project), heredoc syntax `git commit -F - <<'EOF'` fails (`<<` is unexpected); instead write the commit message to a temp file and use `git commit -F <file>`, then delete the temp file. Confidence: 0.65

