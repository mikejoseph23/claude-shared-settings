# Setup Project with SimpleAuth4Net

You are helping the user initialize a new project based on SimpleAuth4Net.

## Interactive Setup

First, ask the user for the following information:

1. **Project Name** (code-friendly, PascalCase, e.g., "QcSodStore", "MyAppName")
2. **Display Name** (user-friendly, e.g., "QC Sod Store", "My App Name")
3. **Company Name** (for copyright footer, e.g., "Quantico Creek", "ACME Corp")
4. **Icon Class** (FontAwesome icon for sidebar, e.g., "fa-leaf", "fa-home", "fa-store")
5. **Database Server** (e.g., "localhost\\SQLEXPRESS" or "192.168.50.42\\SQLEXPRESS")
6. **Database Name** (e.g., "MyAppDb", "QcSodOrdering")
7. **Database Username** (SQL Auth user, e.g., "appuser", "qcsod")
8. **Database Password** (SQL Auth password)
9. **Email Address** (for no-reply emails, e.g., "noreply@yourdomain.com")

## Setup Steps

Once you have this information, execute the following steps:

### 1. Clone SimpleAuth4Net Repository

```bash
git clone git@github.com:lymestack/SimpleAuth4Net.git temp-simpleauth
```

If SSH fails, try HTTPS:
```bash
git clone https://github.com/lymestack/SimpleAuth4Net.git temp-simpleauth
```

### 2. Move Files to Root

Move all files from `temp-simpleauth/` to the current directory, EXCEPT:
- Do NOT overwrite existing `CLAUDE.md`
- Do NOT overwrite existing `README.md`
- Do NOT copy the `.git` folder

```bash
# Move files (excluding .git, CLAUDE.md, README.md if they exist in current dir)
for item in temp-simpleauth/{.gitattributes,.vscode,CreateDb.sql,LICENSE.txt,Run.bat,WebApi,documentation,generate-token-secret.ps1,generate-token-secret.py,ng-app,react-app,vue-app}; do
  if [ -e "$item" ]; then
    basename=$(basename "$item")
    if [ "$basename" = "CLAUDE.md" ] || [ "$basename" = "README.md" ]; then
      if [ -e "$basename" ]; then
        echo "Skipping $basename (already exists)"
        continue
      fi
    fi
    mv "$item" .
  fi
done

# Remove temp directory
rm -rf temp-simpleauth
```

### 3. Clean Up Unnecessary Folders

```bash
rm -rf react-app vue-app documentation
```

### 4. Upgrade Projects to .NET 9

Update `WebApi/SimpleAuthNet/SimpleAuthNet.csproj`:
- Change `<TargetFramework>net8.0</TargetFramework>` to `<TargetFramework>net9.0</TargetFramework>`
- Change `<PackageReference Include="Microsoft.AspNetCore.Authentication.JwtBearer" Version="8.0.8" />` to `Version="9.0.0"`

Update `WebApi/WebApi/WebApi.csproj`:
- Change `<TargetFramework>net8.0</TargetFramework>` to `<TargetFramework>net9.0</TargetFramework>`
- Change `<PackageReference Include="Microsoft.AspNetCore.Authentication.JwtBearer" Version="8.0.8" />` to `Version="9.0.0"`
- Change `<PackageReference Include="Microsoft.AspNetCore.OpenApi" Version="8.0.8" />` to `Version="9.0.0"`

### 5. Rename Solution File

```bash
mv WebApi/WebApi.sln WebApi/{ProjectName}.sln
```

### 6. Update Angular App Branding

**File: `ng-app/src/app/core/shell/shell.component.html`**

Replace:
```html
<i class="fa fa-lock logo-icon" aria-hidden="true"></i>
<span class="logo-title">SimpleAuth for .NET</span>
```

With:
```html
<i class="fa {IconClass} logo-icon" aria-hidden="true"></i>
<span class="logo-title">{DisplayName}</span>
```

Replace:
```html
<span class="only-handset">SimpleAuth4 for .NET</span>
<span class="no-handset"
  >SimpleAuth for .NET <span *ngIf="pageTitle">- {{ pageTitle }}</span>
</span>
```

With:
```html
<span class="only-handset">{DisplayName}</span>
<span class="no-handset"
  >{DisplayName} <span *ngIf="pageTitle">- {{ pageTitle }}</span>
</span>
```

**File: `ng-app/src/app/about/about.component.html`**

Replace the SimpleAuth welcome content with:
```html
<h2>Welcome to {DisplayName}</h2>

<p>
  Welcome to your application.
</p>
```

**File: `ng-app/src/app/auth-admin/auth-admin.component.html`**

Replace:
```html
<mat-card-title>Welcome to the SimpleAuth Admin Area</mat-card-title>
```

With:
```html
<mat-card-title>Admin Area</mat-card-title>
```

**File: `ng-app/src/app/core/footer/footer.component.html`**

Replace the copyright section:
```html
<p>
  &copy; 2026 {CompanyName}. All rights reserved.
</p>
```

**File: `ng-app/src/index.html`**

Replace:
```html
<title>NgApp</title>
```

With:
```html
<title>{DisplayName}</title>
```

### 7. Configure appsettings.json

**File: `WebApi/WebApi/appsettings.json`**

Update the connection string:
```json
"ConnectionStrings": {
  "DefaultConnection": "Server={DatabaseServer};Database={DatabaseName};User Id={DatabaseUsername};Password={DatabasePassword};TrustServerCertificate=True;Connect Timeout=30;"
}
```

Update API URL (for Kestrel development):
```json
"Api": "http://localhost:5218/",
// "Api": "http://localhost/{ProjectName}/api/", // <-- Use this for IIS
```

Update email settings:
```json
"EmailSettings": {
  "NoReplyAddress": "{EmailAddress}",
  "UseSmtpPickup": true,
  "SmtpPickupDirectory": "C:/Temp/{ProjectName}/EmailPickup/",
  ...
}
```

Update audit logging:
```json
"AuditLogging": {
  "Enabled": true,
  "LogFolder": "C:/Temp/{ProjectName}/AuditLogs",
  ...
}
```

Update OTP issuer name:
```json
"OtpIssuerName": "{DisplayName}",
```

### 8. Fix Angular Configuration

**File: `ng-app/src/main.ts`**

Change the default to use Kestrel instead of IIS:

```typescript
// Toggle this manually depending on IIS vs Kestrel
const useIIS = false;  // Change from true to false

return useIIS
  ? 'http://localhost/{ProjectName}/api/AppConfig'  // Update from SimpleAuthNet
  : 'http://localhost:5218/AppConfig';
```

### 9. Create Database Setup Documentation

Create `docs/database-setup.md`:

```markdown
# Database Setup Instructions

## Step 1: Create Database and Login (Run as SA/Admin)

Connect to SQL Server as an administrator and run:

\`\`\`sql
-- Create the database
CREATE DATABASE {DatabaseName};
GO

USE master;
GO

-- Create SQL Server login
CREATE LOGIN {DatabaseUsername} WITH PASSWORD = '{DatabasePassword}';
GO

USE {DatabaseName};
GO

-- Create user in the database
CREATE USER {DatabaseUsername} FOR LOGIN {DatabaseUsername};
GO

-- Grant permissions
ALTER ROLE db_owner ADD MEMBER {DatabaseUsername};
GO
\`\`\`

## Step 2: Create SimpleAuth Tables

Run the CreateDb.sql script:

\`\`\`bash
sqlcmd -S {DatabaseServer} -d {DatabaseName} -U {DatabaseUsername} -P '{DatabasePassword}' -i CreateDb.sql
\`\`\`

This creates the SimpleAuth authentication tables.

## Step 3: Verify Connection

\`\`\`bash
sqlcmd -S {DatabaseServer} -d {DatabaseName} -U {DatabaseUsername} -P '{DatabasePassword}' -Q "SELECT COUNT(*) as TableCount FROM INFORMATION_SCHEMA.TABLES"
\`\`\`

You should see at least 5 tables created.
```

### 10. Update CLAUDE.md (if needed)

If the user's project already has a `CLAUDE.md`, leave it as is. If using the SimpleAuth `CLAUDE.md`, consider updating the project overview section with the new project name and description.

### 11. Completion Summary

After completing all steps, provide a summary:

```
✅ SimpleAuth4Net project initialized successfully!

Project: {ProjectName}
Display Name: {DisplayName}
Solution: WebApi/{ProjectName}.sln
Database: {DatabaseName} on {DatabaseServer}

Configuration completed:
- Backend: .NET 9 WebAPI configured
- Frontend: Angular configured for Kestrel development
- Database: Connection string configured
- Branding: {DisplayName} applied throughout

IMPORTANT - Database Setup Required:
Before running the application, you must provision the database:

1. As SQL Server admin, run the SQL commands from docs/database-setup.md (Step 1)
2. Run CreateDb.sql to create SimpleAuth tables (Step 2)
3. Verify connection (Step 3)

Once database is ready:
1. Build backend: cd WebApi/WebApi && dotnet build
2. Run backend: dotnet run (API at http://localhost:5218/)
3. Run frontend: cd ng-app && npm start (App at http://localhost:4200/)

See docs/database-setup.md for detailed database provisioning instructions.
```

## Important Notes

- Leave `WebApi/` and `ng-app/` folder names unchanged
- Only rename the `.sln` file to the project name
- Preserve any existing `CLAUDE.md` or `README.md` in the target directory
- The skill assumes you're running from an empty or new project directory
- Git history from SimpleAuth is removed (no nested repo)
- **Database must be provisioned by SQL Server admin before app will run**
- Angular is configured to use Kestrel by default (`useIIS = false` in main.ts)
- Use Angular Material for UI components (included in SimpleAuth)

## Error Handling

If git clone fails:
- Try SSH first: `git@github.com:lymestack/SimpleAuth4Net.git`
- Fall back to HTTPS: `https://github.com/lymestack/SimpleAuth4Net.git`
- If both fail, ask the user to manually clone the repo
