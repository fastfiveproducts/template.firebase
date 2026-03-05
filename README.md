# template.firebase

> **Branches:** [`main`](https://github.com/fastfiveproducts/template.firebase/tree/main) contains the latest stable release.
> [`develop`](https://github.com/fastfiveproducts/template.firebase/tree/develop) is the working branch.
> GitHub may show these branches as "behind" or "ahead" of each other — this is expected due to the squash-merge release process described [below](#branch-structure--change-approach).

## License
- Licensed under **AGPL-3.0 — with an author exception**
- See [LICENSE](./LICENSE) and [LICENSE-EXCEPTIONS.md](./LICENSE-EXCEPTIONS.md) for full terms
- For file-level authorship, licensing, and reuse details, see [CONTRIBUTING.md](./CONTRIBUTING.md)

## Dependencies
- install Visual Studio Code via your preferred method (e.g. Homebrew)
- note that deploying changes, or even running locally, will require a google identity with access to the associated Firebase project (alternatively, you can create a new project)

## Clone project
- open a terminal and cd to your root Programs folder or directory
- clone project from GitHub via your preferred method
- change directory into the project with `cd template.firebase`

## Setup
- setup development environment (assumes Visual Studio Code is installed)
  - on a Mac, use `brew install firebase-cli` (requires Homebrew), and install the Firebase Data Connect studio extension for VS Code (Cmd+Shift+X → search “Firebase Data Connect”)
  - for Windows or for additional support see [Firebase quickstart](https://firebase.google.com/docs/data-connect/quickstart)
- in VS Code, click the Firebase Data Connect icon on the left navigation bar to open the Firebase Data Connect studio
- click “Sign in with Google”; typically you would use your organization google identity with access to the associated Firebase project
- click “Run firebase init”
- if you signed-in with your organization google identity you would likely “Use an Existing Project” and select the template project (alternatively, you can create a new project)
- this will create a `.firebaserc` file that includes the Firebase project ID

## Generate SDK
1. Complete the Setup steps above (Firebase CLI installed, signed in, project initialized)
2. In VS Code, click the Firebase Data Connect icon on the left navigation bar
3. Click **”Add SDK to app”**
4. Choose the `../dataconnect-generated/` directory as the “App Folder”. This will generate the `DefaultConnector` Swift package at `../dataconnect-generated/swift/` (relative to the template.firebase directory)
   - The output path is configured in `dataconnect/connector/connector.yaml`
5. Verify the directory exists: `ls ../dataconnect-generated/swift/DefaultConnector/`

You only need to do this once after cloning. If the Data Connect schema or queries change, re-run “Add SDK to app” to regenerate.

## Look Around
- in VS Code, click the Explorer icon on the left navigation bar and navigate to the `dataconnect` directory
- the schema is defined by `schema.gql`
- mutations and queries are defined by the gql files in the `connector` directory

## Run on Firebase Emulator
- use the Terminal to start the emulator:
    - `firebase emulators:start --only dataconnect` (standard — sufficient for schema work and running queries directly)
- the Terminal should indicate success and report:
    - the Postgres server, e.g. {“address”:”127.0.0.1”,”family”:”IPv4”,”port”:5432}
    - the Data Connect Host:Port, e.g. 127.0.0.1:9399
- once running you can access this emulated project via:
    - the VS Code Firebase environment to execute queries and mutations from the gql files directly (run LOCALLY!)
    - GQL can be run directly from the “Data Connect Execution” tab in the VS Code Firebase environment
    - db can be accessed with typical db access tools like DBeaver
- once loaded your local emulator db should persist the data through emulator restarts
    - typically stored in `dataconnect/.dataconnect/pgliteData`
- queries and mutations can be run through Firebase Data Connect studio
    - click “Run (local)” to run in the emulator

## Authenticate
If you skipped the sign-in during Setup, or need to re-authenticate:
- in VS Code, click the Firebase Data Connect icon on the left navigation bar
- click “Sign in with Google”; typically you would use your organization google identity with access to the associated Firebase project

## template Changes

### Branch Structure & Change Approach
- `develop` is the working/integration branch, where multiple feature branches get squash-merged
- `main` is the release/production branch, containing a clean linear history with one commit per release
- see your `OPERATE Developer Pipeline` document for detailed instructions

### Make Changes
- in VS Code, click the Explorer icon on the left navigation bar and navigate to the `dataconnect` directory
- the schema is defined by `schema.gql`
- mutations and queries are defined by the gql files in the `connector` directory

### Deploy to Firebase
- in VS Code, click the Firebase Data Connect icon on the left navigation bar
- Click “Deploy to Production”