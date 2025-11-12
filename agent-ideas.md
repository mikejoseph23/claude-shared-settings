# Agent Ideas

> **Note:** This file is AI-generated and contains potential agent implementations for future consideration. These are not implemented yet - they serve as a reference for when specific automation needs arise.

---

## Common Agent Types

### 1. Code Review Agent
**Purpose:** Automated code quality and security analysis

**Capabilities:**
- Reviews pull requests automatically
- Checks for security vulnerabilities (OWASP Top 10, injection attacks, XSS, etc.)
- Identifies code smells and anti-patterns
- Validates performance considerations
- Suggests improvements and best practices
- Can block merges if critical issues are found

**When to use:** Before merging code to main branches

---

### 2. Documentation Sync Agent
**Purpose:** Keep documentation in sync with code changes

**Capabilities:**
- Detects code changes and updates corresponding docs
- Keeps API documentation aligned with actual endpoints
- Updates README files when features change
- Generates changelog entries from commits
- Maintains accuracy between implementation and documentation

**When to use:** After significant feature additions or API changes

---

### 3. Test Generation Agent
**Purpose:** Automated test creation and coverage analysis

**Capabilities:**
- Analyzes code and generates unit tests
- Identifies untested code paths
- Creates test cases for edge cases
- Runs tests and reports coverage gaps
- Suggests additional test scenarios

**When to use:** When test coverage is low or new features need testing

---

### 4. Dependency Update Agent
**Purpose:** Proactive dependency management

**Capabilities:**
- Monitors for outdated packages
- Checks for security vulnerabilities in dependencies
- Creates PRs to update packages
- Runs tests to verify updates don't break functionality
- Prioritizes security patches

**When to use:** Regular maintenance cycles, security alerts

---

### 5. Bug Triage Agent
**Purpose:** Intelligent issue classification and routing

**Capabilities:**
- Analyzes new bug reports
- Categorizes and prioritizes issues
- Suggests potential root causes
- Assigns to appropriate team members based on expertise
- Identifies duplicate issues

**When to use:** Issue intake and management workflows

---

### 6. Performance Monitoring Agent
**Purpose:** Proactive performance optimization

**Capabilities:**
- Analyzes code for performance bottlenecks
- Monitors API response times
- Identifies slow database queries
- Suggests optimization strategies
- Tracks performance metrics over time

**When to use:** Performance optimization initiatives, production monitoring

---

### 7. Refactoring Agent
**Purpose:** Technical debt reduction

**Capabilities:**
- Identifies code duplication across codebase
- Suggests opportunities to extract reusable components
- Detects anti-patterns and technical debt
- Proposes incremental refactoring steps
- Maintains backward compatibility

**When to use:** Code maintenance sprints, architectural improvements

---

### 8. Integration Test Agent
**Purpose:** End-to-end validation

**Capabilities:**
- Runs end-to-end tests across multiple services
- Validates API contracts between services
- Tests database migrations
- Verifies deployment readiness
- Simulates production scenarios

**When to use:** Pre-deployment validation, integration testing

---

### 9. Git Workflow Agent
**Purpose:** Enforce development standards

**Capabilities:**
- Enforces branch naming conventions
- Validates commit message format
- Ensures PRs have proper descriptions
- Checks that tickets are linked to commits
- Maintains git hygiene

**When to use:** Every commit/PR, enforcing team standards

---

### 10. Migration Assistant Agent
**Purpose:** Framework and version upgrades

**Capabilities:**
- Helps migrate code between frameworks/versions
- Identifies deprecated API usage
- Suggests modern alternatives
- Generates migration scripts
- Validates migration completeness

**When to use:** Major framework upgrades, technology migrations

---

## LymeStack-Specific Agents

### 11. LymeStack Scaffolding Agent
**Purpose:** Rapid full-stack development with LymeStack conventions

**Capabilities:**
- Generates .NET Core API endpoints following project patterns
- Creates matching Angular components and services
- Sets up Blazor admin panels in LymeTools
- Follows established architectural patterns
- Maintains consistency across stack layers
- Generates TypeScript interfaces from C# DTOs
- Creates database migrations for new entities

**When to use:** Starting new features, adding CRUD operations

**Example workflow:**
1. Define entity model
2. Agent generates API controller, service layer, repository
3. Agent creates Angular service and components
4. Agent builds Blazor admin interface
5. All layers follow team conventions

---

### 12. API-Frontend Sync Agent
**Purpose:** Keep Angular frontend aligned with .NET API

**Capabilities:**
- Ensures Angular services match .NET API contracts
- Updates TypeScript interfaces when C# models change
- Validates API calls use correct endpoints
- Generates client-side models from backend DTOs
- Detects breaking API changes before deployment
- Syncs route definitions between frontend and backend

**When to use:** API changes, model updates, contract validation

**Example workflow:**
1. C# DTO is modified
2. Agent detects change
3. Updates TypeScript interface
4. Updates Angular services
5. Flags any breaking changes for review

---

## Implementation Priority Recommendations

Based on typical development workflows:

### High Priority
1. **Code Review Agent** - Immediate quality improvement, catches issues early
2. **LymeStack Scaffolding Agent** - Reduces boilerplate, maintains consistency
3. **Documentation Sync Agent** - Aligns with planning-focused approach

### Medium Priority
4. **API-Frontend Sync Agent** - Prevents frontend/backend drift
5. **Test Generation Agent** - Improves coverage systematically
6. **Git Workflow Agent** - Enforces standards consistently

### Lower Priority (As Needed)
7. **Performance Monitoring Agent** - When performance becomes an issue
8. **Refactoring Agent** - During technical debt reduction efforts
9. **Bug Triage Agent** - When issue volume increases
10. **Migration Assistant Agent** - During major upgrades

---

## Notes on Agent Development

**Before creating an agent, consider:**
- Is this task repetitive enough to warrant automation?
- Will the agent save more time than it takes to maintain?
- Does this align with team workflows?
- Is this better as a Skill (expertise) or Agent (automation)?

**Agent vs Skill vs Command:**
- **Command:** User explicitly invokes (e.g., `/iadev:make-planning-document`)
- **Skill:** Claude automatically uses expertise (e.g., requirements-interviewer)
- **Agent:** Autonomous multi-step task execution (e.g., code review on every PR)

**Start simple:**
- Begin with one well-scoped agent
- Test thoroughly in non-critical scenarios
- Gather team feedback
- Iterate based on actual usage

---

## Additional Resources

- [Claude Code Agent Documentation](https://docs.claude.com/claude-code)
- Current Skills: `skills/requirements-interviewer/`
- Current Commands: `commands/`
- Planning Documents: `scratchpad.md`, `backlog.md`
