package com.freshworks.util.fake;

import com.github.javafaker.Faker;

public class FakeFactory {
    private static final Faker faker = new Faker();

    public static String newEmail() {
        return faker.internet().emailAddress();
    }
}
