$root = "React"

$folders = @(
    "01-javascript-for-react",
    "02-react-fundamentals",
    "03-rendering-and-events",
    "04-state-and-data-flow",
    "05-hooks",
    "06-forms",
    "07-api-and-server-communication",
    "08-routing",
    "09-authentication-and-authorization",
    "10-global-state-management",
    "11-server-state-and-data-fetching",
    "12-component-architecture",
    "13-styling-and-ui",
    "14-typescript-with-react",
    "15-real-world-patterns",
    "16-performance",
    "17-error-handling-and-debugging",
    "18-testing",
    "19-production-react",
    "20-react-ecosystem",
    "21-react-with-spring-boot",
    "22-projects",
    "23-interview-preparation",
    "24-quick-reference"
)

$files = @{
    "01-javascript-for-react" = @(
        "01-variables-and-data-types.md",
        "02-functions.md",
        "03-arrow-functions.md",
        "04-destructuring.md",
        "05-spread-and-rest.md",
        "06-template-literals.md",
        "07-objects.md",
        "08-array-methods.md",
        "09-map-filter-reduce.md",
        "10-optional-chaining.md",
        "11-nullish-coalescing.md",
        "12-modules-import-export.md",
        "13-promises.md",
        "14-async-await.md",
        "15-error-handling.md",
        "16-immutability.md",
        "17-closures.md",
        "18-event-loop.md"
    )

    "02-react-fundamentals" = @(
        "01-what-is-react.md",
        "02-react-vs-javascript.md",
        "03-react-vs-traditional-dom.md",
        "04-spa-and-component-based-ui.md",
        "05-vite-and-project-setup.md",
        "06-project-structure.md",
        "07-jsx.md",
        "08-components.md",
        "09-functional-components.md",
        "10-props.md",
        "11-children.md",
        "12-component-composition.md"
    )

    "03-rendering-and-events" = @(
        "01-how-react-renders.md",
        "02-render-and-commit.md",
        "03-conditional-rendering.md",
        "04-rendering-lists.md",
        "05-keys.md",
        "06-event-handling.md",
        "07-event-object.md",
        "08-common-rendering-mistakes.md"
    )

    "04-state-and-data-flow" = @(
        "01-what-is-state.md",
        "02-useState.md",
        "03-state-updates.md",
        "04-functional-state-updates.md",
        "05-state-immutability.md",
        "06-derived-state.md",
        "07-lifting-state-up.md",
        "08-state-sharing.md",
        "09-prop-drilling.md",
        "10-state-design.md"
    )

    "05-hooks" = @(
        "01-what-are-hooks.md",
        "02-rules-of-hooks.md",
        "03-useState.md",
        "04-useEffect.md",
        "05-useRef.md",
        "06-useContext.md",
        "07-useReducer.md",
        "08-useMemo.md",
        "09-useCallback.md",
        "10-custom-hooks.md",
        "11-hook-selection.md",
        "12-common-hook-mistakes.md"
    )

    "06-forms" = @(
        "01-form-basics.md",
        "02-controlled-components.md",
        "03-uncontrolled-components.md",
        "04-input-handling.md",
        "05-form-state.md",
        "06-validation.md",
        "07-error-messages.md",
        "08-react-hook-form.md",
        "09-form-submission.md"
    )

    "07-api-and-server-communication" = @(
        "01-http-basics.md",
        "02-rest-api.md",
        "03-fetch.md",
        "04-axios.md",
        "05-get-request.md",
        "06-post-request.md",
        "07-put-patch-delete.md",
        "08-request-headers.md",
        "09-loading-state.md",
        "10-error-state.md",
        "11-api-service-layer.md",
        "12-api-interceptors.md",
        "13-environment-variables.md",
        "14-api-folder-structure.md"
    )

    "08-routing" = @(
        "01-react-router.md",
        "02-browser-router.md",
        "03-routes.md",
        "04-navigation.md",
        "05-route-parameters.md",
        "06-query-parameters.md",
        "07-nested-routes.md",
        "08-layout-routes.md",
        "09-protected-routes.md",
        "10-not-found-route.md"
    )

    "09-authentication-and-authorization" = @(
        "01-authentication-vs-authorization.md",
        "02-login-flow.md",
        "03-registration-flow.md",
        "04-jwt.md",
        "05-access-token.md",
        "06-refresh-token.md",
        "07-token-storage.md",
        "08-auth-context.md",
        "09-protected-routes.md",
        "10-logout.md",
        "11-role-based-access.md"
    )

    "10-global-state-management" = @(
        "01-local-vs-global-state.md",
        "02-context-api.md",
        "03-useReducer.md",
        "04-redux-concepts.md",
        "05-redux-toolkit.md",
        "06-slices.md",
        "07-actions-and-reducers.md",
        "08-store.md",
        "09-async-thunks.md",
        "10-redux-persist.md",
        "11-when-to-use-redux.md"
    )

    "11-server-state-and-data-fetching" = @(
        "01-client-state-vs-server-state.md",
        "02-tanstack-query.md",
        "03-queries.md",
        "04-query-keys.md",
        "05-mutations.md",
        "06-caching.md",
        "07-refetching.md",
        "08-pagination.md",
        "09-infinite-queries.md",
        "10-optimistic-updates.md"
    )

    "12-component-architecture" = @(
        "01-component-design.md",
        "02-single-responsibility.md",
        "03-reusable-components.md",
        "04-component-composition.md",
        "05-container-and-presentational.md",
        "06-feature-based-architecture.md",
        "07-separation-of-concerns.md",
        "08-component-dependencies.md",
        "09-folder-structure.md",
        "10-scaling-react-applications.md"
    )

    "13-styling-and-ui" = @(
        "01-css-in-react.md",
        "02-css-modules.md",
        "03-tailwind-css.md",
        "04-responsive-design.md",
        "05-design-systems.md",
        "06-component-libraries.md",
        "07-accessibility.md"
    )

    "14-typescript-with-react" = @(
        "01-typescript-for-react.md",
        "02-types.md",
        "03-interfaces.md",
        "04-props-types.md",
        "05-state-types.md",
        "06-event-types.md",
        "07-ref-types.md",
        "08-api-response-types.md",
        "09-union-and-intersection-types.md",
        "10-generics.md",
        "11-reusable-types.md"
    )

    "15-real-world-patterns" = @(
        "01-search.md",
        "02-debounce.md",
        "03-pagination.md",
        "04-infinite-scroll.md",
        "05-modal.md",
        "06-toast-notifications.md",
        "07-dropdown.md",
        "08-file-upload.md",
        "09-image-preview.md",
        "10-shopping-cart.md",
        "11-dashboard.md",
        "12-filtering-and-sorting.md",
        "13-multi-step-form.md"
    )

    "16-performance" = @(
        "01-react-rendering.md",
        "02-re-renders.md",
        "03-re-render-causes.md",
        "04-react-memo.md",
        "05-useMemo.md",
        "06-useCallback.md",
        "07-code-splitting.md",
        "08-lazy-loading.md",
        "09-bundle-size.md",
        "10-image-optimization.md",
        "11-performance-debugging.md"
    )

    "17-error-handling-and-debugging" = @(
        "01-react-devtools.md",
        "02-browser-devtools.md",
        "03-error-boundaries.md",
        "04-api-errors.md",
        "05-network-debugging.md",
        "06-cors-debugging.md",
        "07-infinite-useEffect.md",
        "08-state-not-updating.md",
        "09-component-not-rendering.md",
        "10-memory-leaks.md",
        "11-common-react-errors.md"
    )

    "18-testing" = @(
        "01-testing-fundamentals.md",
        "02-unit-testing.md",
        "03-react-testing-library.md",
        "04-component-testing.md",
        "05-user-interaction-testing.md",
        "06-testing-forms.md",
        "07-testing-hooks.md",
        "08-mocking-api.md",
        "09-integration-testing.md"
    )

    "19-production-react" = @(
        "01-development-vs-production.md",
        "02-environment-configuration.md",
        "03-production-build.md",
        "04-security.md",
        "05-xss.md",
        "06-cors.md",
        "07-accessibility.md",
        "08-logging.md",
        "09-monitoring.md",
        "10-performance-monitoring.md",
        "11-deployment.md"
    )

    "20-react-ecosystem" = @(
        "01-npm.md",
        "02-package-json.md",
        "03-vite.md",
        "04-eslint.md",
        "05-prettier.md",
        "06-git-with-react.md",
        "07-react-devtools.md",
        "08-browser-devtools.md",
        "09-environment-variables.md",
        "10-common-react-libraries.md"
    )

    "21-react-with-spring-boot" = @(
        "01-fullstack-architecture.md",
        "02-frontend-backend-communication.md",
        "03-api-contract.md",
        "04-cors.md",
        "05-login-flow.md",
        "06-jwt-authentication.md",
        "07-crud-flow.md",
        "08-error-handling.md",
        "09-file-upload.md",
        "10-role-based-access.md",
        "11-production-architecture.md"
    )

    "23-interview-preparation" = @(
        "01-fundamentals.md",
        "02-jsx-and-components.md",
        "03-props-and-state.md",
        "04-hooks.md",
        "05-useEffect.md",
        "06-forms.md",
        "07-api-integration.md",
        "08-routing.md",
        "09-authentication.md",
        "10-state-management.md",
        "11-performance.md",
        "12-typescript.md",
        "13-testing.md",
        "14-debugging-scenarios.md",
        "15-system-design-scenarios.md",
        "16-project-explanation.md"
    )

    "24-quick-reference" = @(
        "01-react-syntax.md",
        "02-hooks-cheatsheet.md",
        "03-array-methods.md",
        "04-fetch-axios.md",
        "05-react-router.md",
        "06-redux-toolkit.md",
        "07-tanstack-query.md",
        "08-typescript.md",
        "09-debugging.md",
        "10-common-patterns.md"
    )
}

# Create root
New-Item -ItemType Directory -Path $root -Force | Out-Null

# Create folders
foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path "$root\$folder" -Force | Out-Null
}

# Create markdown files
foreach ($folder in $files.Keys) {
    foreach ($file in $files[$folder]) {
        $path = "$root\$folder\$file"

        if (!(Test-Path $path)) {
            New-Item -ItemType File -Path $path -Force | Out-Null
        }
    }
}

# Create project folders
$projectFolders = @(
    "$root\22-projects\01-todo-app",
    "$root\22-projects\02-weather-app",
    "$root\22-projects\03-ecommerce",
    "$root\22-projects\04-admin-dashboard",
    "$root\22-projects\05-react-springboot-fullstack"
)

foreach ($folder in $projectFolders) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
    New-Item -ItemType File -Path "$folder\README.md" -Force | Out-Null
}

# Root files
New-Item -ItemType File -Path "$root\README.md" -Force | Out-Null
New-Item -ItemType File -Path "$root\ROADMAP.md" -Force | Out-Null
New-Item -ItemType File -Path "$root\CHEATSHEET.md" -Force | Out-Null

Write-Host ""
Write-Host "React documentation structure created successfully!" -ForegroundColor Green
Write-Host "Location: $root"