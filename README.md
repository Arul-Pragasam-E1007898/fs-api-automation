# Karate API Automation Framework

A Java-based API automation framework using [Karate](https://github.com/karatelabs/karate) and JUnit 5.

## Prerequisites

- Java 11 or higher
- Maven 3.6 or higher

## Project Structure

```
.
├── pom.xml                                    # Maven configuration
├── src/
│   └── test/
│       ├── java/
│       │   └── com/example/karate/
│       │       ├── ApiTestRunner.java        # Main JUnit test runner
│       │       └── ParallelRunner.java       # Parallel execution runner
│       └── resources/
│           ├── karate-config.js              # Karate configuration
│           ├── logback-test.xml              # Logging configuration
│           └── com/example/karate/api/
│               ├── sample.feature            # Sample API tests
│               └── user.feature              # User API tests
└── README.md
```

## Setup

1. **Clone or navigate to the project directory**

2. **Build the project**
   ```bash
   mvn clean install
   ```

3. **Run tests**
   ```bash
   mvn test
   ```

## Running Tests

### Run all tests
```bash
mvn test
```

### Run a specific test runner
```bash
mvn test -Dtest=ApiTestRunner
```

### Run tests in parallel
```bash
mvn test -Dtest=ParallelRunner
```

### Run tests with specific tags
Modify the `ApiTestRunner.java` to uncomment the tagged test method, or use:
```bash
mvn test -Dkarate.options="--tags @smoke"
```

### Run tests for a specific environment
```bash
mvn test -Denv=staging
```

### Run tests with custom API base URL
```bash
mvn test -Dapi.base.url=https://api.example.com
```

## Configuration

### Environment Configuration
Edit `src/test/resources/karate-config.js` to configure different environments (dev, staging, prod).

### API Base URL
Set the base URL via:
- System property: `-Dapi.base.url=https://api.example.com`
- Environment variable: `KARATE_API_BASE_URL`
- Or modify `karate-config.js` directly

## Writing Tests

### Basic Feature File Structure
```gherkin
Feature: API Test Description

  Background:
    * url baseUrl
    * def baseUrl = karate.properties['api.base.url'] || 'https://api.example.com'

  Scenario: Test description
    Given path 'endpoint'
    When method get
    Then status 200
    And match response.field == '#string'
```

### Common Karate Keywords
- `Given` - Setup/preconditions
- `When` - Action (method get/post/put/delete)
- `Then` - Assertions
- `And` - Additional steps
- `match` - Assertion matching
- `def` - Variable definition
- `*` - Generic step prefix

### Data Validation
```gherkin
And match response.id == '#number'
And match response.name == '#string'
And match response.email == '#present'
And match response.items[*].id == '#number'
```

## Test Reports

Karate generates HTML reports in the `target/karate-reports` directory after test execution.

## Additional Resources

- [Karate Documentation](https://github.com/karatelabs/karate)
- [Karate DSL Syntax](https://github.com/karatelabs/karate#syntax-guide)
- [JUnit 5 Documentation](https://junit.org/junit5/docs/current/user-guide/)

## Example Test Scenarios

The project includes sample feature files:
- `sample.feature` - Basic CRUD operations
- `user.feature` - User API endpoints with smoke tests

## Troubleshooting

### Tests not running
- Ensure Java 11+ is installed: `java -version`
- Check Maven installation: `mvn -version`
- Clean and rebuild: `mvn clean install`

### Connection issues
- Verify the API base URL is correct
- Check network connectivity
- Review `karate-config.js` for environment settings

## License

This project is provided as-is for API automation purposes.

