---
description: Create or update a repository-specific AGENTS.md from evidence in the current project.
---
# Init AGENTS.md

Create or update an AGENTS.md that gives future coding agents concrete, repository-specific operating instructions. Treat the outline below as a structure, not text to copy literally. The final AGENTS.md must reflect the workspace, not an imagined ideal project.

Additional user instructions:

$ARGUMENTS

Workflow:

1. Inspect before writing.
   - Read existing AGENTS.md, README files, package manifests, build files, CI files, tests, and obvious entry points.
   - Use rg --files when available to map languages, manifests, lockfiles, scripts, tests, and docs.
   - Identify the repository shape: single app, library, monorepo, plugin, script workspace, docs repo, demo collection, or mixed.
2. Preserve valid local rules.
   - Keep accurate existing instructions.
   - Replace stale, generic, placeholder, or contradicted content.
   - Respect nested AGENTS.md scopes if present.
3. Generate from evidence.
   - Document only commands, files, modules, generated artifacts, dependencies, platforms, and workflows that are present or clearly implied.
   - Do not invent architecture, UML, build steps, test commands, dependency policies, or supported systems.
   - Use exact command names from manifests, scripts, README, CI, or local tooling.
4. Adapt the template.
   - Keep sections that help future agents work safely.
   - Merge or omit sections that do not fit the project.
   - Replace language-specific examples with the idioms and commands used by the repository.
5. Verify the result.
   - Read back the edited AGENTS.md.
   - Check that it has no TODO placeholders, invented facts, stale references, or irrelevant language rules.

Evidence to collect:

- Project name, purpose, audience, and repository shape.
- Primary languages, runtime versions, frameworks, libraries, package managers, and lockfiles.
- Build, run, test, lint, format, package, migration, generation, and release commands.
- Important directories, entry points, modules, packages, services, CLIs, GUI apps, workers, native boundaries, or plugin boundaries.
- Generated artifacts and where they are written.
- Side effects: network calls, credentials, databases, live services, deploys, signing, installers, webhooks, destructive cleanup, or external machine paths.
- Existing conventions for naming, comments, logging, errors, dependencies, tests, and docs.

Default AGENTS.md blueprint:

```markdown
# Agent Instructions

This file provides project-specific context and rules for AI coding agents working in this repository. Follow it strictly.

## Project Overview

- **Project Name**: <actual name>
- **Description**: <purpose, product/library/script role, audience, or workspace role>
- **Primary Language(s)**: <languages actually present>
- **Main Libraries**: <important frameworks/libraries actually used>
- **Supported Systems**: <platforms supported or implied by code/docs>

## Architecture Overview

### System Structure

Describe the real boundaries: apps, packages, libraries, services, CLIs, GUI processes, workers, plugins, native modules, DLLs, IPC, threads, or external services. For small script or demo workspaces, state that there is no single app architecture and document isolation rules.

**Key Flows**

1. <real flow>
2. <real flow>
3. <real flow>

### Design Pattern

Describe interfaces, classes, state ownership, module relationships, and thread/process boundaries only when they are evident and useful. Add Mermaid UML or sequence diagrams only for non-obvious relationships.

### Directory Structure

List important directories and explain what each owns. Keep this high signal; avoid enumerating obvious files.

### Workflow Commands

List real commands for build, run, test, lint, format, package, migration, generation, or release. Explain generated artifacts, paths, and side effects.

## Coding Standards

### Naming

- Match existing codebase naming.
- Prefer descriptive names over short abbreviations.
- Add project-specific naming rules only when visible in the repository.

### Comments

- Add doc comments for public functions and public types when the project style supports them.
- Include error conditions in public API comments when they exist.
- Comment complex conditionals, workarounds, edge cases, non-obvious algorithms, and important side effects.
- Prefer intent and behavior over obvious syntax narration.

### Logging

Describe logging conventions used by the project. If the project has no logger, keep guidance brief and avoid inventing a logging framework.

### Error Handling

Describe the repository's real error-handling idioms. Examples: Rust ?, RAII, JavaScript rejection handling, typed results, Bash trap, PowerShell terminating errors, or framework-specific error types.

### Testing

- Add or update tests for new behavior when practical.
- Use the repository's actual test commands.
- Do not delete failing tests without explanation.
- Document dry-run or manual verification for side-effecting scripts.

### Dependency Policy

- Use the package manager and dependency patterns already present.
- Prefer package-manager add/install commands so the tool resolves the current compatible version and updates manifests and lockfiles. Avoid hand-writing guessed version pins unless the repository already requires exact pins or the user asks for one.
- Keep dependency and lockfile changes scoped to the affected package or workspace.
- Add dependencies only when they reduce meaningful complexity or match the existing stack.
- Mention dependency rationale in the PR or final summary.

### Documentation

- Keep README.md, AGENTS.md, manifests, scripts, and tests aligned.
- Do not document commands, files, outputs, or behavior not present in the workspace.
- Prefer source, tests, manifests, scripts, and CI config over stale prose when resolving conflicts.

## Checklist

- Relevant formatter, linter, test, build, dry-run, or manual verification completed, or skipped with reason.
- Tests or sample verification updated for behavior changes when practical.
- Docs updated if setup, commands, inputs, outputs, or public behavior changed.
- Dependencies and generated files scoped correctly.
- No secrets or sensitive data added.
- No unrelated refactors introduced.
```

Adaptation rules:

- Rust: include cargo fmt, cargo clippy --workspace --all-targets -- -D warnings, and cargo test only when Cargo is actually used.
- JavaScript: infer npm, pnpm, yarn, or bun from lockfiles and packageManager; do not assume.
- Python: infer commands from pyproject.toml, requirements*.txt, tox.ini, noxfile.py, pytest.ini, CI, or README.
- Monorepo: document package boundaries and per-package commands instead of forcing one root workflow.
- Demo/script workspace: emphasize isolation, local dependencies, and avoiding root-level runtime artifacts.
- Live-service, installer, deployment, signing, database, or webhook scripts: mark side effects clearly and avoid treating real runs as routine validation.

Quality gate:

Before finishing, confirm the generated AGENTS.md is specific enough that another agent can identify where to make changes, run the right validation commands, avoid unsafe side effects, understand generated artifacts and dependency scope, and distinguish project facts from general engineering advice.
