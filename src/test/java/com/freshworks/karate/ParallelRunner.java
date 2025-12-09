package com.freshworks.karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Parallel test execution runner
 * Use this for running tests in parallel for faster execution
 */
public class ParallelRunner {

    @Test
    void testParallel() {
        Results results = Karate.run("classpath:com/freshworks/features")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

