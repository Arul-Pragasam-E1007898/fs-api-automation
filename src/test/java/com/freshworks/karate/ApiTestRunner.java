package com.freshworks.karate;

import com.intuit.karate.junit5.Karate;

/**
 * Main test runner for Karate API tests
 * This class uses JUnit 5 to execute Karate feature files
 */
public class ApiTestRunner {

    /**
     * Run all feature files in the freshworks/features package
     */
    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:com/freshworks/features").tags("test")
                .relativeTo(getClass());
    }

    /**
     * Run a specific feature file
     * Uncomment and modify to run a specific feature
     */
    // @Karate.Test
    // Karate testSpecific() {
    //     return Karate.run("classpath:com/example/karate/api/sample.feature").relativeTo(getClass());
    // }

    /**
     * Run tests with tags
     * Example: Run only tests tagged with @smoke
     */
    // @Karate.Test
    // Karate testSmoke() {
    //     return Karate.run("classpath:com/example/karate/api")
    //             .tags("@smoke")
    //             .relativeTo(getClass());
    // }
}

