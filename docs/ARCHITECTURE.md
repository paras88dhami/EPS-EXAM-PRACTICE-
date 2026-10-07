# Architecture

## app
Application bootstrap concerns: router, theme, and app-level configuration.

## core
Shared infrastructure such as environment configuration, constants, errors, networking, storage and services.

## features
Business capabilities. A feature may contain:
- data: DTOs, data sources and repository implementations
- domain: entities, repository contracts and use cases
- presentation: pages, widgets and Riverpod state

## shared
Reusable presentation components and models used by multiple features.

## Dependency direction
Presentation -> Domain <- Data

Feature code may use core/shared. Core must not depend on feature code.

## Phase boundaries
Phase 1 intentionally contains no Supabase, ads, exam content, or payment code. These integrations are introduced behind abstractions in later phases.
