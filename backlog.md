# Claude Code Shared Settings - Backlog

This document tracks potential future enhancements and ideas for the shared Claude Code configuration repository.

## Skills to Develop

### Requirements Interviewer (In Progress)
**Status:** Starting development
**Priority:** High
**Description:** A skill that gives Claude expertise in conducting requirements interviews. Works alongside the `/iadev:planning-interview` command but provides this capability throughout any conversation where requirements gathering is needed.

**Use Cases:**
- Gathering project requirements
- Conducting stakeholder interviews
- Clarifying feature specifications
- Extracting technical requirements from business needs

---

### LymeStack Developer
**Status:** Backlog
**Priority:** High
**Description:** Specialized knowledge of the LymeStack framework and development patterns.

**Expertise Areas:**
- .NET Core / C# / Entity Framework best practices
- Angular / TypeScript frontend development
- LymeStack architecture patterns and conventions
- Using LymeTools for scaffolding apps and features
- SQL Server database design for LymeStack apps
- Azure deployment for LymeStack applications
- LymeTemplate admin features (users, logging, settings, etc.)
- Real-time data features via SignalR
- Audit logging and change tracking
- Invoice/payment integration with Stripe

**Reference Documentation:** `~/git/lymestack/documentation/`

---

### Front End Developer
**Status:** Backlog
**Priority:** Medium
**Description:** General frontend development expertise beyond LymeStack-specific patterns.

**Expertise Areas:**
- Angular/React/Vue best practices
- TypeScript patterns
- Responsive design and CSS frameworks
- UI/UX principles
- Frontend performance optimization
- State management patterns
- Component architecture
- Accessibility (a11y) standards

---

### API Developer
**Status:** Backlog
**Priority:** Medium
**Description:** Backend API design and development expertise.

**Expertise Areas:**
- REST API design principles
- GraphQL patterns (if needed)
- API versioning strategies
- Authentication and authorization (OAuth, JWT, etc.)
- API documentation (OpenAPI/Swagger)
- Rate limiting and throttling
- Caching strategies
- Error handling and status codes
- API security best practices

---

### Researcher
**Status:** Backlog
**Priority:** Medium
**Description:** Enhanced research and investigation capabilities.

**Expertise Areas:**
- Technical research methodologies
- Fact-checking and verification
- Analyzing documentation
- Comparing technologies and frameworks
- Investigating bugs and issues
- Literature review techniques
- Synthesizing information from multiple sources

---

## MCP Servers (Plugins) to Evaluate

### Ideas for Investigation
- [ ] Database inspection MCP server (for LymeStack SQL Server databases)
- [ ] Git operations MCP server (enhanced git workflows)
- [ ] Documentation generator MCP server
- [ ] Code analysis MCP server
- [ ] Azure DevOps / Octopus Deploy integration

**Note:** Need to research available MCP servers and how they're installed/shared across team.

---

## Global CLAUDE.md Configuration

### Ideas for Team-Wide Configuration
- [ ] Research what can be configured in a global CLAUDE.md
- [ ] Determine if CLAUDE.md can be symlinked or must be copied
- [ ] Create team standards for code style and conventions
- [ ] Add Interapp Development coding guidelines
- [ ] Include LymeStack-specific patterns and anti-patterns
- [ ] Add links to internal documentation

**Questions:**
- Can CLAUDE.md be project-specific vs. truly global?
- How does global CLAUDE.md interact with project-specific ones?
- What configuration options are available?

---

## Future Slash Commands

### Potential New Commands
- [ ] `/iadev:generate-test-plan` - Create comprehensive test plans from requirements
- [ ] `/iadev:code-review-checklist` - Generate code review checklist based on file types
- [ ] `/iadev:api-endpoint-generator` - Scaffold new API endpoints for LymeStack
- [ ] `/iadev:git-commit-analyzer` - Analyze git history and suggest improvements
- [ ] `/iadev:meeting-notes-formatter` - Structure meeting notes into actionable items

---

## Repository Enhancements

### Documentation
- [ ] Create video walkthrough for team onboarding
- [ ] Add troubleshooting FAQ section
- [ ] Create contribution guidelines for adding new commands/skills
- [ ] Document naming conventions for namespaces

### Infrastructure
- [ ] Automated testing for symlink setup scripts
- [ ] CI/CD validation for command syntax
- [ ] Version tagging strategy
- [ ] Changelog automation

---

## Team Collaboration Ideas

### Process Improvements
- [ ] Monthly review of shared configurations
- [ ] Feedback mechanism for command/skill improvements
- [ ] Shared learning sessions on new Claude Code features
- [ ] Template for proposing new commands/skills

---

## Notes

- This backlog should be reviewed quarterly
- Prioritize based on team needs and time availability
- Not all ideas need to be implemented - focus on high-value items
- Keep the repository simple and maintainable
