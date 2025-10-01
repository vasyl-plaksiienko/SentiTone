package com.sentitone.authservice.security;

import org.jooq.DSLContext;
import org.jooq.Record;
import org.jooq.impl.DSL;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class JooqUserDetailsService implements UserDetailsService {

    private final DSLContext dsl;

    public JooqUserDetailsService(DSLContext dsl) {
        this.dsl = dsl;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        var USERS = DSL.table(DSL.unquotedName("users"));
        var AUTHORITIES = DSL.table(DSL.unquotedName("authorities"));

        Record userRecord = dsl.select(
                        DSL.field(DSL.unquotedName("username")),
                        DSL.field(DSL.unquotedName("password")),
                        DSL.field(DSL.unquotedName("enabled"))
                )
                .from(USERS)
                .where(DSL.field(DSL.unquotedName("username")).eq(username))
                .fetchOne();

        if (userRecord == null) {
            throw new UsernameNotFoundException("User not found: " + username);
        }

        boolean enabled = userRecord.get("enabled", Boolean.class);
        String password = userRecord.get("password", String.class);

        List<String> authorityValues = dsl.select(DSL.field("authority", String.class))
                .from(AUTHORITIES)
                .where(DSL.field("username").eq(username))
                .fetchInto(String.class);

        List<GrantedAuthority> authorities = authorityValues.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());

        return User.withUsername(userRecord.get("username", String.class))
                .password(password)
                .authorities(authorities)
                .accountExpired(false)
                .accountLocked(false)
                .credentialsExpired(false)
                .disabled(!enabled)
                .build();
    }
}
