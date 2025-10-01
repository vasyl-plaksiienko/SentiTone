package com.sentitone.authservice;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class AuthServiceApplicationTests {

    @Autowired
    UserDetailsService userDetailsService;

    @Test
    void contextLoads() {
        assertThat(userDetailsService).isNotNull();
    }

    @Test
    void loadsAdminUserFromJooq() {
        UserDetails user = userDetailsService.loadUserByUsername("admin");
        assertThat(user).isNotNull();
        assertThat(user.getUsername()).isEqualTo("admin");
        assertThat(user.getAuthorities()).extracting("authority").contains("ROLE_USER", "ROLE_ADMIN");
    }
}
