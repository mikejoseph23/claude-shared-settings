# Monthly Invoicing - Client Configuration

This file contains client-specific rules for monthly invoicing, including tax status, special billing arrangements, and thresholds.

---

## Default Rules

These rules apply to all clients unless explicitly overridden below:

- **Hourly Rate**: $150/hour (universal)
- **AI Tooling Fee**: $125 (applied when client has >5 hours in the month)
- **MD Sales Tax**: 3% (default for all clients unless tax-exempt)
- **No Hours = No Invoice**: If a client has 0 hours, no invoice is created

---

## Tax Status

### Taxable Clients (3% MD Sales Tax - Default)
All clients are subject to 3% Maryland sales tax unless listed in the exempt categories below.

### Tax-Exempt Clients

#### Exempt - Government
Government entities are exempt from Maryland sales tax. Add specific government clients here:
- *[List government agency clients here]*

#### Exempt - Agriculture
Agricultural businesses are exempt from Maryland sales tax:
- **Sod Farm**

---

## Special Billing Arrangements

### Azure Hosting Pass-Through
**Client**: *[Azure Hosting Client Name]*

**Billing Structure**:
- Azure hosting costs passed through at cost (no markup)
- Service fee: $150/month
- Billing frequency: Quarterly (January, April, July, October)
- Process: Pull previous quarter's costs from Azure Portal resource group

**Azure Details**:
- Resource Group: *[Specify resource group name]*
- Billing period: Previous quarter (e.g., Oct-Dec for January invoice)

---

## Billing Thresholds & Triggers

### AI Tooling Fee Threshold
- **Condition**: Client has >5 billable hours in the month
- **Fee Amount**: $125
- **Line Item Description**: "AI Tooling Fee"

### Quarterly Invoicing Months
Certain actions only occur in these months:
- **January**: Azure hosting costs for Oct-Dec
- **April**: Azure hosting costs for Jan-Mar
- **July**: Azure hosting costs for Apr-Jun
- **October**: Azure hosting costs for Jul-Sep

### Zero Hours Policy
- If a client has 0 hours for the month, skip invoice creation entirely
- No invoice is created for clients without billable time

---

## Client Directory

*Use this section to track all active clients and their special considerations*

| Client Name | Tax Status | Special Billing | Notes |
|-------------|------------|-----------------|-------|
| Sod Farm | Exempt (Agriculture) | Standard | Agricultural exemption |
| *[Azure Hosting Client]* | Taxable | Azure Pass-Through | Quarterly hosting + $150/mo service fee |
| *[Add other clients]* | Taxable | Standard | |

---

## Notes & Future Considerations

- **Client Name Matching**: Verify that client names are identical between stopwatchez.com and QuickBooks Online to enable automatic matching
- **Service Period**: Consider including service period date range on invoice line items (e.g., "January 2025 Consulting Services")
- **PDF Attachments**: Time tracking PDFs should be attached to each invoice in QuickBooks Online
