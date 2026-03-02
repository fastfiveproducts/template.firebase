## Emulator Setup

### Start the Emulator
From **VS Code** > **Firebase** > **Start Emulators**, or from terminal:
```bash
firebase emulators:start --project template-9960d
```

Data persists between emulator restarts in `dataconnect/.dataconnect/pgliteData/` (configured via `dataDir` in `firebase.json`). You do not need to reseed after restarting the emulator.

### Connect DBeaver (for SQL scripts)
```bash
open -a "DBeaver"
```

1. **Database** > **New Database Connection** > **PostgreSQL**
2. Look for the Postgres port in the emulator output:
   ```
   Started up Postgres server, listening on {"address":"127.0.0.1","family":"IPv4","port":5432}
   ```
   The port (e.g. `5432`) may vary — use whatever the emulator reports.
3. Enter the following connection details:

| Setting        | Value                                   |
|----------------|-----------------------------------------|
| **Host**       | `127.0.0.1`                             |
| **Port**       | The port from the emulator output above |
| **Database**   | `postgres`                              |
| **Username**   | `postgres`                              |
| **Password**   | *(leave empty)*                         |

4. Click **Test Connection** to verify, then **Finish**

**Note:** The "Data Connect" port (e.g. `9399`) shown in the emulator table is the FDC API endpoint, not the PostgreSQL port — use the Postgres port from the log line above.

## Seed Data

Run these in order. GQL files run in **VS Code** (open the file, click the Run button in the Firebase Data Connect panel). SQL files run in **DBeaver** (open a SQL editor against the emulator connection).

### Setup

| File | Tool | Description |
|------|------|-------------|
| `02_systemAccount_insert.gql` | VS Code | System user account — required before all content tables |
| `03_app_client_inserts.gql` | VS Code | App client / tenant registry |
| `04_feature_flag_inserts.gql` | VS Code | Client feature flags |

## Notes
- The emulator uses PGlite (embedded PostgreSQL) — no separate PostgreSQL install required
- The `lsof` warnings about `smbfs` in the emulator output are harmless (Time Machine network volume)
