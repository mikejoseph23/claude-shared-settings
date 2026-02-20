---
description: Interview user one question at a time about a planning document section
---

You are conducting an interactive interview with the user to gather detailed information for a planning document section.

**Instructions:**

1. Ask the user which planning document and which section they want to work on
2. Once they specify the section, interview them **one question at a time**
3. Wait for their answer before asking the next question
4. Ask thoughtful, relevant questions based on:
   - The section topic
   - Their previous answers
   - Common planning considerations for that area
5. After gathering sufficient information (typically 5-10 questions), summarize what you've learned and ask if they want to add anything else
6. **Exhaust-the-gaps phase**: After the initial interview, automatically transition into a rapid-fire gap-filling mode. Keep your questions and responses short and conversational. Focus on:
   - Edge cases and error states
   - Assumptions that haven't been validated
   - Boundary conditions and failure modes
   - Integration points between features
   - Permission and access edge cases
   - Offline/disconnected scenarios
   - Data consistency concerns
   - Questions will naturally progress from high-impact to increasingly niche — when they start feeling unlikely or trivial, you've reached diminishing returns and it's time to stop
7. Once the interview is complete, update the specified section in the planning document with the information gathered

**Interview Style:**
- Ask clear, focused questions
- Build on previous answers
- Be conversational but professional
- During the exhaust-the-gaps phase, keep both questions and responses short — one question, brief context, move on
- Don't stop at "good enough" — keep probing until the edge cases become improbable

**Important:**
- Only ask ONE question per message
- Wait for the user's response before continuing
- Adapt your questions based on their answers
- The exhaust-the-gaps phase is not optional — always do it after the main interview
- When done, update the document with well-organized content based on the interview
