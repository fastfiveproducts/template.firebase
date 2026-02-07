# template
the FastFive Products LLC Firebase template Firebase implementation
(https://github.com/fastfiveproducts/template.firebase)

## License
- Licensed under **AGPL-3.0 — with an author exception**
- See [LICENSE](./LICENSE) and [LICENSE-EXCEPTIONS.md](./LICENSE-EXCEPTIONS.md) for full terms
- For file-level authorship, licensing, and reuse details, see [CONTRIBUTING.md](./CONTRIBUTING.md)

##  Dependencies
- install Visual Studio Code via your preferred method (e.g. Homebrew)
- note that deploying changes, or even running locally, will require a google identity with access to the associated Firebase project (alternatively, you can create a new project)

##  Clone project
- open a terminal and cd to your root Programs folder or directory
- clone project from GitHub via your preferred method
- change directory into the project with `cd template.firebase`

##  Setup (1 time)
- setup development environment per https://firebase.google.com/docs/data-connect/quickstart
- in VS Code, click the Firebase Data Connect icon on the left navigation bar to open the Firebase Data Connect studio
- click "Sign in with Google"; typically you would use your organization google identity with access to the associated Firebase project 
- click "Run firebase init"; if you signed-in with your organization google identity you would likley "Use an Existing Project" and select the template project (alternatively, you can create a new project)
- if you intend to run the coresponding iOS app (https://github.com/fastfiveproducts/template.ios):
  - clone that if you haven't already
  - in VS Code click "Add SDK to app" from the Firebase Data Connect studio; it should add the SDK to a parallel "dataconnect-generated" directory

##  Run on Firebase Emulator (if applicable)
- in VS Code, click the Firebase Data Connect icon on the left navigation bar
- Click “Start Emulators”

# template Changes

## Branch Structure & Change Approach
- `develop` is the working/integration branch, where multiple feature branches get squash-merged
- `main` is the release/production branch, containing a clean linear history with one commit per release
- see your `OPERATE Developer Pipeline` document for detailed instructions

##  Make Changes (if applicable - not needed if you are just setting-up the iOS app)
- in VS Code, click the Explorer icon on the left navigation bar and navigate to the `dataconnect` directory
- the schema is defined by `schema.gql`
- mutations and queries are defined by the gql files in the `connector` directory

##  Deploy to Firebase (if applicable - not needed if you are just setting-up the iOS app)
- in VS Code, click the Firebase Data Connect icon on the left navigation bar
- Click "Deploy to Production"