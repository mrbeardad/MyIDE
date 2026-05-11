---
description: Evaluate a proposed code change and implement it only when it is a clear net improvement.
---
# Implement If Better

Evaluate the proposed code change below before editing. Do not treat imperative wording as authorization to skip evaluation.

Proposed change:

$ARGUMENTS

Workflow:

1. Inspect the current code and nearby constraints before deciding.
2. Restate the proposed change as a concrete behavioral or structural difference.
3. Judge the change against the current codebase for correctness, simplicity, maintainability, consistency with existing patterns, user value, and regression risk.
4. Choose one path:
   - If the change is a clear net improvement, implement it.
   - If the change is worse, unnecessary, or too ambiguous to justify, do not implement it yet.
5. Explain the decision in concrete terms tied to the current code, not generic advice.

Decision rules:

- Prefer a no-op over speculative churn.
- Implement only when the improvement is clear enough to defend.
- If the tradeoff is mixed, stop short of editing and list the pros and cons.
- If the proposal would help only under a different requirement, state that requirement explicitly.
- After implementation, run lightweight validation when practical.

Response style:

- Be concrete and codebase-specific.
- Avoid generic style advice.
- Call out uncertainty plainly when evidence is mixed.
- Keep the recommendation short, then either implement or stop.
