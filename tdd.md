# TDD Implementation Prompts for NRA Bullseye League App

This document contains a series of prompts designed for a code-generation LLM to implement the NRA Bullseye League application in a test-driven manner. Each prompt builds incrementally on previous work, focusing on small, manageable steps that can be safely implemented and tested.

## Part 1: Project Setup and Foundation

### Prompt 1.1: Initial Rails Project Setup

```
I'm building an NRA Bullseye League score tracking application in Ruby on Rails. Let's start with setting up the basic project.

1. Generate a new Rails 7 project with PostgreSQL as the database
2. Set up RSpec as the testing framework
3. Add essential gems for testing: factory_bot_rails, faker, shoulda-matchers, and database_cleaner
4. Set up a basic CI configuration file (.github/workflows/ci.yml)
5. Configure the test environment correctly
6. Create a simple home controller with index action as the root page
7. Write basic tests for the home controller
8. Add Bootstrap 5 for basic styling

For each step, show the exact commands to run and the code to write. Include the contents of any configuration files that need to be created or modified.
```

### Prompt 1.2: User Model and Basic Authentication

```
Let's implement user authentication for our NRA Bullseye League app using Devise.

Building on our Rails 7 project with RSpec, implement:

1. Add the Devise gem to the project
2. Generate a User model with Devise and configure it with:
   - Email, password, and username fields
   - Email confirmation
   - Account lockout after failed attempts
   - Password complexity validation
   - Trackable login statistics
3. Create RSpec tests for the User model validations
4. Customize Devise views with Bootstrap styling
5. Create a basic user profile page that shows username, email, and join date
6. Add RSpec tests for the profile page
7. Implement a basic navigation bar with login/logout links

Please write tests first, then the implementation code for each component. Show the full test file content and implementation.
```

### Prompt 1.3: User Roles and Authorization System

```
Let's implement role-based authorization for our NRA Bullseye League application.

Based on our existing Rails 7 project with Devise authentication, implement:

1. Add the Pundit gem for authorization
2. Extend the User model to include a role field with three possible values:
   - system_admin (can manage everything)
   - league_admin (can manage assigned leagues)
   - shooter (regular user)
3. Create a UserPolicy using Pundit with proper permissions for each role
4. Write comprehensive RSpec tests for the different authorization scenarios
5. Update the user registration to default to shooter role
6. Create a user management page for system admins to:
   - View all users
   - Change user roles
   - Disable/enable accounts
7. Add appropriate tests for the user management functionality
8. Ensure all controllers check authorization for actions

Please provide test-first implementation with complete test files and code. Remember to update any existing views to reflect the role information.
```

### Prompt 1.4: League Model Foundation

```
Now let's implement the League model for our NRA Bullseye League tracking application.

Building on our Rails 7 project with Devise and Pundit, implement:

1. Create a League model with attributes:
   - name (required, unique)
   - description (optional)
   - start_date (required)
   - end_date (required)
   - active (boolean, default true)
2. Create a LeaguePolicy with Pundit:
   - System admins can manage all leagues
   - League admins can manage their assigned leagues
   - All users can view active leagues
3. Create a LeagueMembership join model to track:
   - User-League relationships
   - Membership status (pending, active, inactive)
   - Membership role (admin, competitor)
4. Create factories for League and LeagueMembership models
5. Write comprehensive model specs for validations and associations
6. Create controller and views for:
   - Listing leagues (index)
   - Viewing league details (show)
   - Creating leagues (new/create) - system admins only
   - Editing leagues (edit/update) - system admins and league admins
7. Add league join request functionality:
   - Users can request to join a league
   - League admins can approve/reject requests
8. Write controller and feature specs for all functionality

Please follow TDD approach with tests first, then implementation.
```

## Part 2: Competition Structure Implementation

### Prompt 2.1: Gun Types and Classifications

```
Let's implement gun types and classification levels for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Create a GunType model or enum with types:
   - Rimfire
   - Centerfire
   - .45 ACP
2. Create a Classification model or enum with levels (in ascending order):
   - Unclassified
   - Marksman
   - Sharpshooter
   - Expert
   - Master
   - High Master
3. Add a current_classification field to the User model
4. Create a ClassificationHistory model to track:
   - User association
   - Previous classification
   - New classification
   - Date of change
   - Approving admin (user reference)
   - Notes
5. Write model tests for all new models/enums
6. Create interfaces for administrators to:
   - View and manage a user's classification
   - Review and approve classification changes
7. Add classification display to user profiles
8. Implement appropriate authorization with Pundit
9. Add a section to the league show page displaying shooters by classification

Please follow test-driven development with complete tests and implementation code.
```

### Prompt 2.2: Match and Relay Structure

```
Let's implement the Match and Relay structure for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Create a Match model with:
   - League association
   - Date
   - Name/description
   - Status (scheduled, in_progress, completed, cancelled)
   - Notes field
2. Create a Relay model with:
   - Match association
   - Relay number or name
3. Implement validations and associations for both models
4. Write comprehensive model specs for Match and Relay
5. Create controllers and views for:
   - Listing matches for a league
   - Creating/editing matches (league admins only)
   - Adding relays to a match
   - Viewing match details with its relays
6. Create feature specs for the match management workflows
7. Add appropriate Pundit policies for authorization:
   - League admins can manage matches in their leagues
   - All users can view matches
8. Ensure proper nesting of resources in routes
9. Add a calendar view option for matches

Please follow test-driven development with complete tests and implementation code.
```

### Prompt 2.3: Score Model and Basic Score Entry

```
Let's implement the Score model and basic score entry functionality for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Create a Score model with:
   - User association (shooter)
   - Match association
   - Relay association
   - Gun type reference
   - Fields for Slow Fire scores (10 individual shots)
   - Fields for Timed Fire scores (10 individual shots)
   - Fields for Rapid Fire scores (10 individual shots)
   - X-count for each firing type
   - Aggregate score (computed)
   - Entry timestamp
   - Entry user (admin who entered the score)
2. Implement validations:
   - Slow Fire scores: nil, 0, or 4-10 points per shot
   - Timed/Rapid Fire scores: nil, 0, or 6-10 points per shot
   - X-count cannot exceed number of 10s
3. Create model specs for all validations and calculations
4. Implement score calculation methods:
   - Slow Fire total
   - Timed Fire total
   - Rapid Fire total
   - Overall aggregate
5. Create a score entry form for league admins:
   - Select shooter
   - Select gun type
   - Input individual shot scores
   - Track X-count
   - Calculate totals automatically with JavaScript
6. Create controller and views for:
   - Listing scores for a match
   - Entering new scores
   - Editing existing scores (with audit trail)
7. Implement appropriate Pundit policies

Please follow test-driven development with complete tests and implementation code.
```

## Part 3: Core Features Implementation

### Prompt 3.1: Leaderboard and Rankings

```
Let's implement the leaderboard and rankings functionality for our NRA Bullseye League application.

Building on our existing Rails project with Users, Leagues, Matches, and Scores, implement:

1. Create a RankingService class that:
   - Calculates rankings based on aggregate scores across matches
   - Handles tie-breaking using X-count
   - Can filter by classification and gun type
2. Write comprehensive tests for the RankingService
3. Create a LeaderboardController with actions for:
   - Overall league standings
   - Standings by classification
   - Standings by gun type
4. Implement leaderboard views with:
   - Tabular display of rankings
   - Sortable columns
   - Filtering options
   - Highlighting for top performers
5. Add pagination for large leaderboards
6. Create feature specs for leaderboard functionality
7. Ensure proper authorization with Pundit
8. Add a historical view to see rankings from previous matches

Please follow test-driven development, showing the tests first and then the implementation.
```

### Prompt 3.2: Shooter Statistics and Profiles

```
Let's enhance the shooter profiles with statistics and performance analysis for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Create a ShooterStatsService that calculates:
   - Overall average scores
   - Average scores by string type (Slow/Timed/Rapid)
   - Improvement trends over time
   - Comparison to classification average
   - Distance from next classification level
   - Performance by gun type
2. Write comprehensive tests for the ShooterStatsService
3. Enhance the user profile page with:
   - Score history display
   - Statistical summary
   - Performance charts using Chart.js
   - Classification progress indicator
4. Create partial views for reusable statistics components
5. Add filtering options to view stats by:
   - Date range
   - League
   - Gun type
6. Implement appropriate authorization with Pundit
7. Create feature specs for the enhanced profile pages
8. Ensure mobile-responsive design for statistics display

Please follow test-driven development, showing the tests first and then the implementation.
```

### Prompt 3.3: Basic Reporting System

```
Let's implement a basic reporting system for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Create a ReportService with methods for generating:
   - Match results reports
   - Season standings reports
   - Shooter progression reports
   - Classification status reports
2. Write comprehensive tests for the ReportService
3. Create a ReportsController with actions for different report types
4. Implement report views with:
   - Tabular data display
   - Filtering options
   - Export functionality to CSV and PDF (using appropriate gems)
5. Add a reports dashboard for league administrators
6. Implement appropriate Pundit policies for authorization
7. Create feature specs for the reporting functionality
8. Add caching for report data to improve performance
9. Implement background processing for large reports using Sidekiq

Please follow test-driven development, showing the tests first and then the implementation.
```

## Part 4: Advanced Features

### Prompt 4.1: Notification System

```
Let's implement a notification system for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Create a Notification model with:
   - User association (recipient)
   - Notification type (enum)
   - Content
   - Read status
   - Reference to related object (polymorphic)
   - Creation timestamp
2. Create a NotificationService for creating notifications for events:
   - New match results posted
   - Classification change alerts
   - League join request status updates
   - Comments on match results
3. Implement in-app notification display:
   - Notification badge in navigation
   - Dropdown listing of recent notifications
   - Notification page for viewing all notifications
4. Add email delivery for notifications using ActionMailer
5. Create user preferences for notification settings
6. Write comprehensive tests for model, service, and controllers
7. Implement appropriate Pundit policies
8. Add real-time notifications using ActionCable (optional)

Please follow test-driven development, showing the tests first and then the implementation.
```

### Prompt 4.2: Social Features

```
Let's implement social features for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Create a Comment model with:
   - User association (author)
   - Commentable association (polymorphic for matches, scores, etc.)
   - Content
   - Creation timestamp
2. Create a Message model for direct messaging:
   - Sender association
   - Recipient association
   - Subject
   - Content
   - Read status
   - Creation timestamp
3. Create an Announcement model for league announcements:
   - League association
   - Author association
   - Title
   - Content
   - Pinned status
   - Expiration date
   - Creation timestamp
4. Implement controllers and views for:
   - Adding/viewing comments on match results
   - Sending/receiving direct messages
   - Creating/viewing league announcements
5. Add appropriate Pundit policies for each feature
6. Implement notification integration for social interactions
7. Write comprehensive tests for all new models and controllers
8. Create feature specs for the social interaction workflows

Please follow test-driven development, showing the tests first and then the implementation.
```

### Prompt 4.3: Custom League Configuration

```
Let's implement custom league configuration options for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Enhance the League model with customization fields:
   - scoring_system (JSON field for custom scoring rules)
   - ranking_method (enum for different calculation methods)
   - classification_thresholds (JSON field for custom thresholds)
   - match_format_settings (JSON field for match configuration)
2. Create a LeagueConfigService that handles:
   - Validation of custom configuration options
   - Application of custom scoring rules
   - Implementation of custom ranking methods
3. Modify the score entry and validation to respect league-specific rules
4. Update ranking calculations to use league-specific methods
5. Create an administration interface for league admins to:
   - Configure scoring rules
   - Set ranking calculation method
   - Customize classification thresholds
   - Define match format requirements
6. Write comprehensive tests for the enhanced model and service
7. Update existing controllers and views to respect league configuration
8. Create feature specs for the customization workflow

Please follow test-driven development, showing the tests first and then the implementation.
```

## Part 5: Refinement and Integration

### Prompt 5.1: Advanced Data Visualization

```
Let's implement advanced data visualization for our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Add Chart.js or D3.js for interactive charts
2. Create a StatsVisualizationService that prepares data for:
   - Score trend line charts
   - Performance comparison bar charts
   - Classification distribution pie charts
   - Shot placement heat maps (if data available)
   - League participation statistics
3. Implement visualization components:
   - Shooter performance dashboard
   - League statistics overview
   - Match result visualizations
   - Classification progress charts
4. Create a responsive design for visualizations on different devices
5. Add interactive features like tooltips, zooming, and filtering
6. Write JavaScript tests for visualization components
7. Create feature specs for visualization pages
8. Implement caching for visualization data

Please follow test-driven development, showing the tests first and then the implementation. Include both server-side preparation code and client-side visualization code.
```

### Prompt 5.2: Performance Optimization

```
Let's optimize the performance of our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Database optimization:
   - Add appropriate indexes to frequently queried columns
   - Optimize complex queries using explain/analyze
   - Implement database-level caching strategies
2. Application-level caching:
   - Cache expensive calculations and queries
   - Implement fragment caching for view components
   - Set up Redis for cache storage
3. Background processing:
   - Move report generation to background jobs
   - Implement email sending via background jobs
   - Add progress tracking for long-running tasks
4. Frontend optimization:
   - Implement lazy loading for images and components
   - Optimize JavaScript execution
   - Minify and compress assets
5. Add pagination and infinite scrolling for large data sets
6. Implement database query monitoring and logging
7. Write performance benchmarks and tests
8. Set up monitoring for performance metrics

Please provide complete implementation code with tests, focusing on the most impactful optimizations first.
```

### Prompt 5.3: Mobile Responsiveness and UI Refinement

```
Let's enhance the user interface and mobile responsiveness of our NRA Bullseye League application.

Building on our existing Rails project, implement:

1. Improve responsive design:
   - Ensure all pages work well on mobile devices
   - Implement mobile-specific layouts for complex data views
   - Create touch-friendly controls for common actions
2. UI refinements:
   - Create a consistent color scheme and design language
   - Improve typography and readability
   - Add subtle animations and transitions
   - Enhance form usability and feedback
3. Accessibility improvements:
   - Ensure proper ARIA attributes
   - Implement keyboard navigation
   - Add screen reader support
   - Fix color contrast issues
4. Add dark mode option
5. Implement user preference saving for UI settings
6. Create a style guide and component library
7. Write tests for responsive behavior and accessibility
8. Optimize page load performance for mobile devices

Please provide implementation code with a focus on CSS, HTML, and JavaScript improvements. Include tests for new features and screenshots of before/after if possible.
```

### Prompt 5.4: Final Integration and Deployment

```
Let's finalize our NRA Bullseye League application for deployment to production.

Building on our existing Rails project, implement:

1. Create a comprehensive test suite:
   - Ensure all models have thorough unit tests
   - Add integration tests for critical workflows
   - Implement system tests for end-to-end functionality
   - Add performance tests for critical paths
2. Security enhancements:
   - Implement security headers
   - Add CSRF protection verification
   - Set up proper SSL configuration
   - Add rate limiting for sensitive endpoints
3. Deployment configuration:
   - Create production environment configuration
   - Set up database backup and restore procedures
   - Implement logging and monitoring
   - Configure error reporting
4. Documentation:
   - Create API documentation
   - Write user guides for different roles
   - Document database schema and relationships
   - Add developer onboarding instructions
5. Create a deployment pipeline:
   - Continuous integration setup
   - Automated testing
   - Staging environment deployment
   - Production deployment process
6. Implement feature flags for phased rollout
7. Create database migration strategy for production
8. Final code review and clean up

Please provide the implementation focusing on deployment-specific code, configuration files, and documentation.
```
