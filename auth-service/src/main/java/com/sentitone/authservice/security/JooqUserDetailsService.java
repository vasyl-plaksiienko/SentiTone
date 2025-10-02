package com.sentitone.authservice.security;

import org.jooq.DSLContext;
import org.jooq.Record;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import static com.sentitone.database.security.security.tables.Authorities.AUTHORITIES;
import static com.sentitone.database.security.security.tables.Users.USERS;

@Service
public class JooqUserDetailsService implements UserDetailsService {

    private final DSLContext dsl;

    public JooqUserDetailsService(DSLContext dsl) {
        this.dsl = dsl;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Record userRecord = dsl.select(
                        USERS.USERNAME,
                        USERS.PASSWORD,
                        USERS.ENABLED
                )
                .from(USERS)
                .where(USERS.USERNAME.eq(username))
                .fetchOne();

        if (userRecord == null) {
            throw new UsernameNotFoundException("User not found: " + username);
        }

        boolean enabled = userRecord.get(USERS.ENABLED);
        String password = userRecord.get(USERS.PASSWORD);

        List<String> authorityValues = dsl.select(AUTHORITIES.AUTHORITY)
                .from(AUTHORITIES)
                .where(AUTHORITIES.USERNAME.eq(username))
                .fetchInto(String.class);

        List<GrantedAuthority> authorities = authorityValues.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());

        return User.withUsername(userRecord.get(USERS.USERNAME))
                .password(password)
                .authorities(authorities)
                .accountExpired(false)
                .accountLocked(false)
                .credentialsExpired(false)
                .disabled(!enabled)
                .build();
    }
}
