# =====================================================
# Software Testing Notes Structure Generator
# =====================================================

$root = "Software-Testing"

function New-MdFiles {
    param (
        [string]$Folder,
        [string[]]$Files
    )

    New-Item -ItemType Directory -Path $Folder -Force | Out-Null

    foreach ($file in $Files) {
        New-Item -ItemType File -Path (Join-Path $Folder $file) -Force | Out-Null
    }
}

New-Item -ItemType Directory -Path $root -Force | Out-Null

# =====================================================
# 01 Testing Fundamentals
# =====================================================

New-MdFiles "$root\01-Testing Fundamentals" @(
"01-What is Software Testing.md",
"02-Why Testing Matters.md",
"03-SDLC.md",
"04-STLC.md",
"05-Verification vs Validation.md",
"06-Testing Principles.md",
"07-Test Levels.md",
"08-Types of Testing.md",
"09-Shift Left Testing.md",
"10-Risk Based Testing.md",
"11-Quality Assurance vs Quality Control.md",
"12-Testing Life Cycle in Agile.md"
)

# =====================================================
# 02 Manual Testing
# =====================================================

New-MdFiles "$root\02-Manual Testing" @(
"01-Test Case.md",
"02-Test Scenario.md",
"03-Test Plan.md",
"04-Test Strategy.md",
"05-Test Execution.md",
"06-Bug Life Cycle.md",
"07-Severity vs Priority.md",
"08-Smoke Testing.md",
"09-Sanity Testing.md",
"10-Regression Testing.md",
"11-Exploratory Testing.md",
"12-End to End Testing.md",
"13-Compatibility Testing.md",
"14-Accessibility Testing.md",
"15-UAT.md"
)

# =====================================================
# 03 Test Design Techniques
# =====================================================

New-MdFiles "$root\03-Test Design Techniques" @(
"01-Equivalence Partitioning.md",
"02-Boundary Value Analysis.md",
"03-Decision Tables.md",
"04-State Transition Testing.md",
"05-Pairwise Testing.md",
"06-Error Guessing.md",
"07-Use Case Testing.md",
"08-Risk Based Testing.md",
"09-Requirement Traceability Matrix.md"
)

# =====================================================
# 04 Web Testing
# =====================================================

New-MdFiles "$root\04-Web Testing" @(
"01-Browser Architecture.md",
"02-HTML for QA.md",
"03-DOM.md",
"04-CSS Selectors.md",
"05-XPath Basics.md",
"06-DevTools.md",
"07-Cookies.md",
"08-Session.md",
"09-Cache.md",
"10-Network Tab.md",
"11-WebSocket.md",
"12-CORS.md"
)

# =====================================================
# 05 API Testing
# =====================================================

New-MdFiles "$root\05-API Testing" @(
"01-HTTP Deep Dive.md",
"02-REST API Testing.md",
"03-Postman.md",
"04-Newman.md",
"05-REST Assured.md",
"06-Authentication Testing.md",
"07-JWT Testing.md",
"08-OAuth Testing.md",
"09-GraphQL Testing.md",
"10-Swagger.md",
"11-Contract Testing.md",
"12-API Automation Framework.md"
)

# =====================================================
# 06 Database Testing
# =====================================================

New-MdFiles "$root\06-Database Testing" @(
"01-SQL Validation.md",
"02-Test Data.md",
"03-Data Integrity.md",
"04-Transactions.md",
"05-Database Assertions.md",
"06-Data Migration Testing.md"
)

# =====================================================
# 07 Automation Testing
# =====================================================

$automation = "$root\07-Automation Testing"

New-MdFiles "$automation\01-Automation Fundamentals" @(
"01-What is Automation Testing.md",
"02-When to Automate.md",
"03-Manual vs Automation.md",
"04-Automation Pyramid.md",
"05-Test Automation Strategy.md"
)

New-MdFiles "$automation\02-Selenium" @(
"01-Selenium Architecture.md",
"02-WebDriver.md",
"03-Locators.md",
"04-XPath.md",
"05-CSS Selectors.md",
"06-Waits.md",
"07-Actions Class.md",
"08-Alerts.md",
"09-Frames.md",
"10-Windows.md",
"11-JavaScript Executor.md",
"12-Shadow DOM.md",
"13-Dynamic Elements.md"
)

New-MdFiles "$automation\03-TestNG" @(
"01-Assertions.md",
"02-Annotations.md",
"03-Groups.md",
"04-DataProvider.md",
"05-Parallel Execution.md",
"06-Retry Analyzer.md"
)

New-MdFiles "$automation\04-Framework Design" @(
"01-Page Object Model.md",
"02-Page Factory.md",
"03-Base Test.md",
"04-Utilities.md",
"05-Configuration.md",
"06-Reporting.md",
"07-Logging.md"
)

New-MdFiles "$automation\05-Playwright" @(
"01-Introduction.md",
"02-Installation.md",
"03-Locators.md",
"04-Auto Wait.md",
"05-Assertions.md",
"06-Tracing.md",
"07-Network Interception.md"
)

New-MdFiles "$automation\06-Cucumber" @(
"01-BDD.md",
"02-Feature Files.md",
"03-Step Definitions.md",
"04-Hooks.md",
"05-Tags.md"
)

New-MdFiles "$automation\07-REST Assured" @(
"01-Introduction.md",
"02-GET Requests.md",
"03-POST Requests.md",
"04-PUT Requests.md",
"05-DELETE Requests.md",
"06-Assertions.md",
"07-Schema Validation.md"
)

New-MdFiles "$automation\08-Projects" @(
"01-Swag Labs.md",
"02-OrangeHRM.md",
"03-Banking Application.md"
)

# =====================================================
# 08 AI Testing
# =====================================================

New-MdFiles "$root\08-AI Testing" @(
"01-Introduction to AI Testing.md",
"02-LLM Testing.md",
"03-Prompt Testing.md",
"04-Hallucination Testing.md",
"05-RAG Testing.md",
"06-AI Agent Testing.md",
"07-Bias Testing.md",
"08-Toxicity Testing.md",
"09-Red Teaming.md",
"10-Evaluation Metrics.md",
"11-AI Test Cases.md"
)

# =====================================================
# 09 AI Assisted Testing
# =====================================================

New-MdFiles "$root\09-AI Assisted Testing" @(
"01-ChatGPT for QA.md",
"02-Claude for QA.md",
"03-Cursor.md",
"04-GitHub Copilot.md",
"05-AI Test Case Generation.md",
"06-AI Bug Analysis.md",
"07-AI Automation.md",
"08-AI Exploratory Testing.md",
"09-Prompt Library.md"
)

# =====================================================
# 10 Performance Testing
# =====================================================

New-MdFiles "$root\10-Performance Testing" @(
"01-Performance Testing.md",
"02-JMeter.md",
"03-k6.md",
"04-Load Testing.md",
"05-Stress Testing.md",
"06-Spike Testing.md",
"07-Endurance Testing.md"
)

# =====================================================
# 11 Security Testing
# =====================================================

New-MdFiles "$root\11-Security Testing" @(
"01-OWASP Top 10.md",
"02-SQL Injection.md",
"03-XSS.md",
"04-CSRF.md",
"05-Authentication Testing.md",
"06-Authorization Testing.md"
)

# =====================================================
# 12 CI-CD for QA
# =====================================================

New-MdFiles "$root\12-CI-CD for QA" @(
"01-Git.md",
"02-GitHub.md",
"03-GitHub Actions.md",
"04-Jenkins.md",
"05-Docker.md",
"06-Test Automation Pipeline.md"
)

# =====================================================
# 13 Test Management
# =====================================================

New-MdFiles "$root\13-Test Management" @(
"01-Jira.md",
"02-Confluence.md",
"03-Agile.md",
"04-Scrum.md",
"05-Sprint.md",
"06-User Stories.md",
"07-Acceptance Criteria.md"
)

# =====================================================
# 14 Real Projects
# =====================================================

New-MdFiles "$root\14-Real Projects" @(
"01-Swag Labs.md",
"02-OrangeHRM.md",
"03-Banking Application.md",
"04-Flight Booking.md",
"05-Hospital Management.md",
"06-E-Commerce.md",
"07-AI Chatbot.md",
"08-AI Resume Analyzer.md",
"09-RAG Question Answering.md",
"10-AI Customer Support Bot.md"
)

# =====================================================
# 15 Interview
# =====================================================

New-MdFiles "$root\15-Interview" @(
"01-Manual QA.md",
"02-Automation QA.md",
"03-SDET.md",
"04-API Testing.md",
"05-SQL.md",
"06-AI Testing.md",
"07-HR Questions.md"
)

# =====================================================
# README
# =====================================================

New-Item -ItemType File -Path "$root\README.md" -Force | Out-Null

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "Software Testing Notes Structure Created!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
Write-Host ""