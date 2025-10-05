package com.sentitone.authservice;

import com.sentitone.authservice.service.JooqUserDetailsService;
import org.jooq.ConnectionProvider;
import org.jooq.DSLContext;
import org.jooq.ExecuteListenerProvider;
import org.jooq.TransactionProvider;
import org.jooq.conf.RenderQuotedNames;
import org.jooq.conf.SettingsTools;
import org.jooq.impl.DefaultConfiguration;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.jooq.DefaultConfigurationCustomizer;
import org.springframework.boot.autoconfigure.jooq.JooqProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetailsService;

import javax.sql.DataSource;

@Configuration
public class PersistenceConfig {
    @Bean
    public org.jooq.Configuration jooqConfiguration(JooqProperties properties, ConnectionProvider connectionProvider,
                                                    DataSource dataSource, ObjectProvider<TransactionProvider> transactionProvider,
                                                    ObjectProvider<ExecuteListenerProvider> executeListenerProviders,
                                                    ObjectProvider<DefaultConfigurationCustomizer> configurationCustomizers) {
        var configuration = new DefaultConfiguration();
        configuration.set(properties.determineSqlDialect(dataSource));
        configuration.set(connectionProvider);
        transactionProvider.ifAvailable(configuration::set);
        configuration.set(executeListenerProviders.orderedStream().toArray(ExecuteListenerProvider[]::new));
        configurationCustomizers.orderedStream().forEach((customizer) -> customizer.customize(configuration));
        configuration.set(SettingsTools.defaultSettings().withRenderQuotedNames(RenderQuotedNames.NEVER));
        return configuration;
    }

    @Bean
    public UserDetailsService userDetailsService(DSLContext dsl) {
        return new JooqUserDetailsService(dsl);
    }
}
