# template
the FastFive Products LLC Firebase template
(https://github.com/fastfiveproducts/template.firebase)

##  Dependencies
- install Visual Studio Code via your preferred method
- note that deploying changes, or even running locally, will require a google identity with access to the associated Firebase project (alternatively, you can create a new project)

##  Clone project
- cd to your root programming directory
- clone project from GitHub via your preferred method

##  Setup
- setup development environment per https://firebase.google.com/docs/data-connect/quickstart, e.g. on MacOS:
`curl -sL https://firebase.tools/dataconnect | bash`
- in VS Code, click the Firebase Data Connect icon on the left navigation bar
- click "Sign in with Google"; typically you would use your organization google identity with access to the associated Firebase project 
- click "Run firebase init"
- if you signed-in with your organization google identity you would likley "Use an Existing Project" and select the project (alternatively, you can create a new project)

## Make Changes
- in VS Code, click the Explorer icon on the left navigation bar and navigate to the `dataconnect` directory
- the schema is defined by `schema.gql`
- mutations and queries are defined by the gql files in the `connector` directory

## Run on Firebase Emulator
- in VS Code, click the Firebase Data Connect icon on the left navigation bar
- Click “Start Emulators”

## Deploy to Firebase
- in VS Code, click the Firebase Data Connect icon on the left navigation bar
- Click "Deploy to Production"
