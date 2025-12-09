/**
 * Karate Configuration File
 * This file is automatically loaded by Karate before any feature file execution
 * You can define environment-specific configurations here
 */

function fn() {
    // Get environment from system property or default to 'dev'
    var env = karate.properties['env'] || 'dev';
    
    // Determine base URL
    var baseUrl = 'https://lgcinfocity05094701.freshcmdb.com/';
    
    // Base configuration
    var config = {
        env: env,
        baseUrl: baseUrl,
        api: {
            baseUrl: baseUrl,
            timeout: 5000
        }
    };
    
    // Log configuration (optional)
    karate.log('Environment:', env);
    karate.log('API Base URL:', baseUrl);
    karate.configure('logPrettyRequest', false);
    karate.configure('logPrettyResponse', false);
    
    return config;
}

