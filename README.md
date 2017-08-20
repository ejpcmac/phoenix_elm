# Phoenix + Elm

To add Elm to a Phoenix application:

1. Install `elm` and `elm-brunch` as static dependencies:

        $ cd assets
        $ npm install elm elm-brunch --save-dev

2. Install the Elm package `elm-lang/html`, used in the application —this will
    create the `elm-package.json` for us:

        $ elm package install elm-lang/html

3. Add `elm` as a source directory in `elm-package.json`:

    ```json
    {
        "version": "1.0.0",
        "summary": "helpful summary of your project, less than 80 characters",
        "repository": "https://github.com/user/project.git",
        "license": "BSD3",
        "source-directories": [
            "elm"
        ],
        "exposed-modules": [],
        "dependencies": {
            "elm-lang/core": "5.1.1 <= v < 6.0.0",
            "elm-lang/html": "2.0.0 <= v < 3.0.0"
        },
        "elm-version": "0.18.0 <= v < 0.19.0"
    }
    ```

4. Configure Brunch:

    ```js
    ...

    paths: {
      // Add "elm" to the list
      watched: ["static", "css", "elm", "js", "vendor"],
      public: "../priv/static"
    },

    plugins: {
      // Configure elm-brunch
      elmBrunch: {
        mainModules: ['elm/App.elm'],
        outputFolder: 'vendor',
        outputFile: 'elm.js',   // The Elm app is generated in assets/vendor/elm.js
        executablePath: 'node_modules/elm/binwrappers',
      },

      ...
    }
    ```

5. Create a simple Elm application in `assets/elm/App.elm`:

    ```elm
    module App exposing (..)

    import Html exposing (text)

    main : Html.Html msg
    main =
        text "Hello from Elm!"
    ```

6. Create a container for the Elm application, for example in `index.html.eex`:

    ```html
    <div id="elm-container"></div>
    ```

7. In `assets/js/app.js`, load the Elm application:

    ```js
    // Set up the Elm application
    const elmDiv = document.querySelector('#elm-container')
    const elmApp = Elm.App.embed(elmDiv)
    ```

8. Ignore Elm artifacts in the `.gitignore`:

        /assets/elm-stuff
        /assets/vendor/elm.js

**Note :** There is currently an issue with the order Brunch compiles the
assets, resulting in `priv/static/js/app.js` not including the generated
`elm.js` on the first compilation. When watching for changes in development mode
this is not an issue, but we must run `npm run deploy` twice for the assets to
compile correctly before packaging a release.
