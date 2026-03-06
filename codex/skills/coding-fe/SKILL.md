---
trigger: manual
---

# FRONTEND CODING STANDARDS & EXECUTION PROTOCOLS

## 1. Core Architecture & Component Standards
All UI code must be strictly typed, modular, and built for reusability.

### A. TypeScript First (MANDATORY)
- **Strict Typing:** NO `any` types allowed. Every component, prop, and state must have an interface or type definition.
- **Props Definition:** Component inputs must be clearly defined. If calling an API from the backend, the FE type must perfectly match the BE response schema.

### B. Component Structure (Atomic/Modular)
- **Size Limit:** A single component file MUST NOT exceed 250-300 lines. If it does, break it down into smaller sub-components.
- **Separation of Concerns:** Keep logic (data fetching, state management) separate from UI rendering. Use Custom Hooks (React) or Composables (Vue) to handle complex business logic.
- **Naming Conventions:**
  - Components: `PascalCase` (e.g., `UserProfile.tsx`)
  - Hooks/Utils: `camelCase` (e.g., `useUserData.ts`)
  - CSS Classes/Ids: `kebab-case`

### C. Styling & UI/UX Rules
- **Utility-First CSS:** Use Tailwind CSS (or the configured UI library) for styling. **NO inline styles** unless dynamically calculated (like mapping SVG coordinates).
- **Responsive Design (Mobile-First):** Always ensure the component looks good on mobile (`sm:`), tablet (`md:`), and desktop (`lg:`).
- **Interactive States:** Every clickable or interactive element MUST have explicitly defined states for:
  - `hover:`
  - `focus:` (for accessibility/keyboard navigation)
  - `disabled:` (with visual feedback like reduced opacity)

---

## 2. API Integration & State Management (CRITICAL)
Since the frontend interacts with complex backend/AI systems, state handling must be bulletproof.

### A. The "3-State" Rule
Every asynchronous action (API call, data fetch) MUST explicitly handle three states in the UI:
1.  **Loading:** Display a skeleton loader or spinner. Never freeze the UI.
2.  **Error:** Display a user-friendly error message. Never leave a blank screen or show raw backend tracebacks to the user.
3.  **Success:** Render the expected data.

### B. Performance Optimization
- **Debouncing:** Any search input or high-frequency event MUST be debounced to prevent spamming backend APIs.
- **Memoization:** Prevent unnecessary re-renders for heavy UI components (e.g., data tables, charts, or SVG overlays).

---

## 3. Implementation Workflow (Antigravity Specific)
Before writing UI code, follow this problem-solving mindset:

1.  **Stop & Think (DOM Tree Planning) 🛑:** Outline the HTML/Component hierarchy structure in 3-5 bullet points. What is the parent? What are the children?
2.  **State Mapping 🔍:** Define what data this component needs and where it comes from (local state vs. global store vs. API).
3.  **Execute 🚀:** Write the code strictly following Section 1 & 2.

---

## 4. Antigravity Browser Subagent Validation (MANDATORY)
After generating or modifying a UI component:
- **Visual Check:** You MUST utilize the Antigravity Browser Subagent to open the local development server (e.g., `localhost:3000`).
- **Interaction Testing:** Verify that the component renders without breaking the layout, and that `hover/focus/disabled` states behave as expected.

---

## 5. Execution Logging Protocol
*(Identical to Backend Protocol for consistency)*

Every UI modification MUST log the action under:
`.agent-execution/{YYYYMMDD}_{task_name}/log/execution__{plan_file_stem}.md`

### Log Entry Format
```markdown
## [YYYY-MM-DD HH:MM:SS] Task: {Brief UI Task Title}
- **Action:** [Create | Update | Delete | Refactor | Styling]
- **Files Affected:**
  - `components/ui/Button.tsx`
- **UI Changes:** {What visual/logical changes were made.}
- **Responsive/State Check:** ✅ Mobile | ✅ Desktop | ✅ Error States Handled
- **Status:** ✅ Success | ⚠️ Partial | ❌ Failed