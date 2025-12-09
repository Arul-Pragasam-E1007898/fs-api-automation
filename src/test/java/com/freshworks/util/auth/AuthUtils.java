package com.freshworks.util.auth;

import java.util.Base64;

/**
 * Utility class for authentication helpers
 */
public class AuthUtils {

    /**
     * Generates Base64 encoded string for Basic Authentication
     * 
     * @param username The username
     * @param password The password
     * @return Base64 encoded string in format "Basic {base64(username:password)}"
     */
    public static String generateBasicAuth(String username, String password) {
        String credentials = username + ":" + password;
        String encoded = Base64.getEncoder().encodeToString(credentials.getBytes());
        return "Basic " + encoded;
    }
}

