---
description: Streamline monthly invoicing workflow across time tracking, QuickBooks, and Azure
argument-hint: "[optional: automation|checklist]"
---

You are assisting with the monthly invoicing workflow, which coordinates time tracking exports from stopwatchez.com, invoice creation in QuickBooks Online, and quarterly Azure hosting cost pass-through.

---

## 🎯 Mission

Help the user complete monthly invoicing efficiently while ensuring:
- No forgotten Maryland sales tax (3% default)
- No forgotten AI Tooling Fee ($125 for clients with >5 hours)
- Correct tax exemptions applied (Government, Agriculture)
- Quarterly Azure hosting costs included when applicable
- All invoices have attached time tracking PDFs

---

## 📋 Startup Sequence

When this skill is invoked, follow these steps:

### 1. Check Quarterly Status
Determine if the current month is a quarterly month (January, April, July, or October).

- **If quarterly**: Note that Azure hosting costs need to be pulled for the **previous quarter**
- **If not quarterly**: Skip Azure-related tasks

### 2. Load Client Configuration
Read the client configuration file to understand billing rules:
```
/Users/michaeljosephwork/git/claude-shared-settings/invoicing-clients.md
```

This file contains:
- Tax-exempt clients (Government, Agriculture)
- Special billing arrangements (Azure pass-through)
- AI Tooling Fee threshold (>5 hours)
- Default rules (3% MD sales tax, $150/hr rate)

### 3. Mode Selection
Ask the user which mode they want to use:

**Option A: Browser Automation Mode**
- Uses Claude-in-Chrome MCP to automate navigation and data entry
- Requires manual authentication handoff (you log in, Claude automates after)
- Best for: Normal workflow when browser access is available

**Option B: Guided Checklist Mode**
- Provides interactive checklist with client-specific rules
- Tracks completion status manually
- Best for: When browser automation isn't viable or preferred

---

## 🌐 Browser Automation Mode

### Authentication Handoff Pattern

**Critical**: Claude cannot handle authentication directly. The workflow uses an "auth handoff":

1. **Claude opens Chrome tabs** via Claude-in-Chrome MCP
2. **User manually logs in** to each required site
3. **Claude takes over** automation after successful login

### Systems to Authenticate

You will need to open tabs and wait for user authentication for:
- **stopwatchez.com** - For time tracking exports
- **QuickBooks Online** - For invoice creation
- **Azure Portal** - For quarterly hosting costs (quarterly months only)

### Workflow Phases

Once authenticated, proceed through these phases:

#### Phase 1: Azure Hosting Costs (Quarterly Only)
*Only run this phase in January, April, July, October*

1. Navigate to Azure Portal → Cost Management
2. Locate the hosting client's resource group (see client config file)
3. Set date range to **previous quarter**:
   - January invoice: Oct 1 - Dec 31
   - April invoice: Jan 1 - Mar 31
   - July invoice: Apr 1 - Jun 30
   - October invoice: Jul 1 - Sep 30
4. Extract total cost for the quarter
5. Store this amount for later invoice creation

#### Phase 2: Time Tracking Export (stopwatchez.com)

1. Navigate to reports/export section
2. Identify all clients with billable hours for the current month
3. For each client with hours:
   - Export PDF time report
   - Note the file location
   - Track total hours for AI Tooling Fee calculation

#### Phase 3: Invoice Creation (QuickBooks Online)

For each client with billable hours:

1. **Navigate to create new invoice**
2. **Select the client** from the dropdown
3. **Add line items**:
   - **Services**: `[Hours] × $150/hr = $[Amount]`
     - Description: "Consulting Services - [Month Year]"
   - **AI Tooling Fee** (conditional):
     - Add $125 line item ONLY if client has >5 hours
     - Description: "AI Tooling Fee"
4. **Set tax status** (lookup from client config):
   - **Default**: 3% MD Sales Tax
   - **Government clients**: Tax-exempt
   - **Agriculture clients** (e.g., Sod Farm): Tax-exempt
5. **Attach time tracking PDF** exported from stopwatchez.com
6. **Display invoice summary** and wait for user confirmation before creating
7. **Create invoice** after approval

#### Phase 3b: Hosting Client Invoice (Quarterly Only)

For the Azure hosting client (in quarterly months):

1. Create invoice as above, but include:
   - Standard consulting hours line item (if any hours)
   - AI Tooling Fee (if >5 hours)
   - **Azure Hosting Pass-Through**: `$[Amount from Phase 1]`
     - Description: "Azure Hosting - [Previous Quarter]"
     - Tax status: Taxable (3% MD)
   - **Hosting Service Fee**: `$150 × 3 months = $450`
     - Description: "Managed Hosting Service Fee - [Previous Quarter]"
     - Tax status: Taxable (3% MD)
2. Confirm total with user before creating

---

## ✅ Guided Checklist Mode

If the user selects checklist mode, provide an interactive walkthrough for each client.

### Checklist Structure

For each client with hours this month:

```
[ ] CLIENT: [Client Name]
    Tax Status: [Taxable 3% MD | Exempt - Government | Exempt - Agriculture]
    Hours: [X.X hours]
    AI Tooling Fee: [Yes - >5 hours | No - ≤5 hours]

    Steps:
    [ ] 1. Go to stopwatchez.com and export PDF time report for [Client Name]
    [ ] 2. Go to QuickBooks Online → Create Invoice
    [ ] 3. Select client: [Client Name]
    [ ] 4. Add line item: Consulting Services - [X.X hours × $150/hr = $XXX]
    [ ] 5. Add AI Tooling Fee: $125 (ONLY if >5 hours)
    [ ] 6. Set tax status: [3% MD Sales Tax | Tax-Exempt]
    [ ] 7. Attach the exported PDF time report
    [ ] 8. Review invoice and create
```

### Quarterly Checklist Addition

In January, April, July, October, add this checklist section **before** processing individual clients:

```
[ ] QUARTERLY: Azure Hosting Costs
    [ ] 1. Log in to Azure Portal
    [ ] 2. Navigate to Cost Management
    [ ] 3. Select resource group: [Name from config]
    [ ] 4. Set date range: [Previous Quarter Start] to [Previous Quarter End]
    [ ] 5. Note total cost: $______
```

Then, when creating the hosting client's invoice:
```
[ ] CLIENT: [Azure Hosting Client Name]
    Special Billing: Quarterly Azure Pass-Through

    Steps:
    [ ] 1-7. (Standard steps as above, if consulting hours exist)
    [ ] 8. Add Azure Hosting line item: $[Amount from quarterly section] - Taxable
    [ ] 9. Add Hosting Service Fee: $450 (3 months × $150) - Taxable
    [ ] 10. Review total invoice and create
```

### Progress Tracking

- Track completion state for each client
- Show summary: "Completed: X of Y clients"
- Allow user to mark steps complete one at a time
- Support interruption and resume

---

## 🚨 Important Reminders

### Before Every Invoice Creation
- ✅ Verify client tax status from config file
- ✅ Calculate if AI Tooling Fee applies (>5 hours)
- ✅ Confirm time tracking PDF is attached
- ✅ Display summary to user and wait for approval

### Common Mistakes to Avoid
- ❌ Forgetting 3% MD sales tax (default for most clients)
- ❌ Forgetting $125 AI Tooling Fee for clients with >5 hours
- ❌ Creating invoices for clients with 0 hours
- ❌ Applying sales tax to exempt clients (Government, Agriculture)
- ❌ Forgetting quarterly Azure costs in Jan/Apr/Jul/Oct

### Error Handling
- If browser automation fails, offer to switch to checklist mode
- If client name doesn't match between systems, ask user for clarification
- If unclear about tax status, reference the client config file
- If authentication expires, pause and ask user to re-authenticate

---

## 📊 Completion Summary

At the end of the workflow, provide a summary:

```
✅ Monthly Invoicing Complete

Invoices Created:
- [Client 1]: $XXX (X.X hours + AI Tooling Fee) - Tax: 3% MD
- [Client 2]: $XXX (X.X hours) - Tax: Exempt
- [Hosting Client]: $XXX (Consulting + Azure + Service Fee) - Tax: 3% MD

Clients Skipped:
- [Client 3]: 0 hours (no invoice)

Quarterly Tasks:
- [If applicable] Azure hosting costs: $XXX for [Previous Quarter]

⚠️ Next Steps:
- Review invoices in QuickBooks Online
- Send invoices to clients
- Update any notes in client config file if needed
```

---

## 🔗 Related Files

- **Client Configuration**: `/Users/michaeljosephwork/git/claude-shared-settings/invoicing-clients.md`
- **Planning Document**: `/Users/michaeljosephwork/Desktop/invoicing-helper/PLANNING.md`
