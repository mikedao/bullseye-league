# NRA Bullseye League App Implementation Checklist

## Phase 0: Project Setup and Foundation

### 0.1: Initial Rails Project Setup
- [ ] Generate new Rails 7 project with PostgreSQL
- [ ] Configure development environment
- [ ] Create Git repository and initial commit
- [ ] Set up RSpec testing framework
- [ ] Add Factory Bot Rails gem
- [ ] Add Faker gem for test data
- [ ] Add Shoulda Matchers gem
- [ ] Add Database Cleaner gem
- [ ] Configure CI with GitHub Actions (.github/workflows/ci.yml)
- [ ] Configure database.yml for all environments
- [ ] Set up test environment in config/environments/test.rb
- [ ] Create Home controller with index action
- [ ] Write RSpec tests for Home controller
- [ ] Set root route to home#index
- [ ] Add Bootstrap 5 for basic styling
- [ ] Create basic layout template with responsive design
- [ ] Test that the homepage renders correctly

### 0.2: User Authentication Foundation
- [ ] Add Devise gem to Gemfile
- [ ] Run Devise installation
- [ ] Configure Devise initializer
- [ ] Generate User model with Devise
- [ ] Add username field to User model
- [ ] Configure email confirmation
- [ ] Configure account lockout after failed attempts
- [ ] Implement password complexity validation
- [ ] Configure trackable login statistics
- [ ] Write model tests for User validations
- [ ] Customize Devise views with Bootstrap styling
- [ ] Create login/logout and registration forms
- [ ] Style authentication pages
- [ ] Create basic user profile page with username, email, join date
- [ ] Write feature tests for profile page
- [ ] Implement navigation bar with login/logout links
- [ ] Test authentication workflow

### 0.3: User Roles and Authorization System
- [ ] Add Pundit gem for authorization
- [ ] Add role field to User model (enum: system_admin, league_admin, shooter)
- [ ] Write migration for adding role to users
- [ ] Set default role as 'shooter' for new registrations
- [ ] Create UserPolicy with Pundit
- [ ] Define permissions for each role
- [ ] Write comprehensive tests for different authorization scenarios
- [ ] Create user management controller for system admins
- [ ] Build user index view with role information
- [ ] Implement user role editing for system admins
- [ ] Add account enable/disable functionality
- [ ] Write controller tests for user management
- [ ] Write feature tests for role management
- [ ] Add authorization checks to all existing controllers
- [ ] Update navigation to show role-specific links
- [ ] Test all permission scenarios

## Phase 1: Core Data Models and Relationships

### 1.1: League Model Foundation
- [ ] Create League model with required attributes
  - [ ] name (required, unique)
  - [ ] description (optional)
  - [ ] start_date (required)
  - [ ] end_date (required)
  - [ ] active (boolean, default true)
- [ ] Write migration for leagues table
- [ ] Create model validations for League
- [ ] Create LeaguePolicy with Pundit
- [ ] Define permissions for each role
- [ ] Create LeagueMembership join model
  - [ ] user_id (foreign key)
  - [ ] league_id (foreign key)
  - [ ] status (enum: pending, active, inactive)
  - [ ] role (enum: admin, competitor)
- [ ] Write migration for league_memberships table
- [ ] Set up associations between User, League, and LeagueMembership
- [ ] Create factories for League and LeagueMembership models
- [ ] Write comprehensive model specs for validations and associations
- [ ] Create leagues controller with CRUD actions
- [ ] Implement league index view
- [ ] Create league show view
- [ ] Build league creation form (system admins only)
- [ ] Implement league editing (system and league admins)
- [ ] Add league join request functionality
- [ ] Create interface for managing join requests
- [ ] Write controller specs for all league actions
- [ ] Create feature specs for league management workflows
- [ ] Test league membership management

### 1.2: Match and Relay Structure
- [ ] Create Match model
  - [ ] league_id (foreign key)
  - [ ] date (required)
  - [ ] name/description
  - [ ] status (enum: scheduled, in_progress, completed, cancelled)
  - [ ] notes (optional)
- [ ] Write migration for matches table
- [ ] Create Relay model
  - [ ] match_id (foreign key)
  - [ ] relay_number or name
- [ ] Write migration for relays table
- [ ] Set up associations between League, Match, and Relay
- [ ] Implement validations for Match and Relay models
- [ ] Create factories for Match and Relay
- [ ] Write model specs for all validations and associations
- [ ] Create MatchPolicy and RelayPolicy with Pundit
- [ ] Create matches controller with CRUD actions
- [ ] Create relays controller with CRUD actions
- [ ] Implement match index view (filtered by league)
- [ ] Build match show view with relays listing
- [ ] Create match creation/editing forms for league admins
- [ ] Implement relay management within matches
- [ ] Add calendar view option for matches
- [ ] Write controller specs for match and relay actions
- [ ] Create feature specs for match management workflows
- [ ] Ensure proper nesting of resources in routes
- [ ] Test all match and relay functionality

### 1.3: Gun Types and Classifications
- [ ] Create GunType model or enum
  - [ ] Rimfire
  - [ ] Centerfire
  - [ ] .45 ACP
- [ ] Create Classification model or enum
  - [ ] Unclassified
  - [ ] Marksman
  - [ ] Sharpshooter
  - [ ] Expert
  - [ ] Master
  - [ ] High Master
- [ ] Add current_classification field to User model
- [ ] Create migration for adding classification to users
- [ ] Create ClassificationHistory model
  - [ ] user_id (foreign key)
  - [ ] previous_classification
  - [ ] new_classification
  - [ ] change_date
  - [ ] approving_admin_id (foreign key to users)
  - [ ] notes
- [ ] Write migration for classification_histories table
- [ ] Create factories for all new models
- [ ] Write model tests for new models/enums
- [ ] Create controller for managing classifications
- [ ] Build interface for viewing/updating a user's classification
- [ ] Create view for classification change approval
- [ ] Update user profile to display classification
- [ ] Create policy for classification management
- [ ] Add classification filter to league show page
- [ ] Write controller tests for classification management
- [ ] Create feature specs for classification workflows
- [ ] Test classification change approval process

### 1.4: Score Data Structure
- [ ] Create Score model
  - [ ] user_id (shooter, foreign key)
  - [ ] match_id (foreign key)
  - [ ] relay_id (foreign key)
  - [ ] gun_type_id (or enum value)
  - [ ] Fields for Slow Fire scores (10 individual shots)
  - [ ] Fields for Timed Fire scores (10 individual shots)
  - [ ] Fields for Rapid Fire scores (10 individual shots)
  - [ ] x_count_slow
  - [ ] x_count_timed
  - [ ] x_count_rapid
  - [ ] aggregate_score (computed)
  - [ ] entry_user_id (admin who entered the score)
  - [ ] entry_timestamp
- [ ] Write migration for scores table
- [ ] Set up associations with User, Match, Relay, GunType
- [ ] Implement score validations
  - [ ] Slow Fire: nil, 0, or 4-10 points
  - [ ] Timed/Rapid Fire: nil, 0, or 6-10 points
  - [ ] X-count validations
- [ ] Create factory for Score model
- [ ] Write comprehensive model specs for Score
- [ ] Implement score calculation methods
  - [ ] Slow Fire total
  - [ ] Timed Fire total
  - [ ] Rapid Fire total
  - [ ] Overall aggregate
  - [ ] Total X-count
- [ ] Create ScorePolicy with Pundit
- [ ] Test all score calculations and validations

## Phase 2: Core Functionality Implementation

### 2.1: Basic Score Entry and Display
- [ ] Create scores controller with CRUD actions
- [ ] Build score entry form for league admins
  - [ ] Shooter selection
  - [ ] Gun type selection
  - [ ] Input fields for all shots
  - [ ] X-count tracking
- [ ] Implement JavaScript for real-time total calculation
- [ ] Create score listing view (filtered by match)
- [ ] Build score detail view
- [ ] Implement score editing with audit trail
- [ ] Create score export functionality (CSV/PDF)
- [ ] Write controller specs for score management
- [ ] Create feature specs for score entry workflows
- [ ] Add proper authorization checks
- [ ] Test score validation in the UI
- [ ] Ensure score calculations work correctly

### 2.2: Shooter Profiles
- [ ] Enhance user profile controller
- [ ] Create ShooterStatsService for calculating statistics
- [ ] Extend user profile view with shooting statistics
- [ ] Implement score history display on profile
- [ ] Add performance trends visualization with Chart.js
- [ ] Create classification progress indicator
- [ ] Add gun type preference management
- [ ] Implement filtering options for statistics
- [ ] Write tests for ShooterStatsService
- [ ] Create feature specs for enhanced profile pages
- [ ] Ensure proper authorization with Pundit
- [ ] Test all profile statistics calculations

### 2.3: Basic League Management
- [ ] Enhance league membership management
- [ ] Create shooter approval workflow
- [ ] Build league settings configuration interface
- [ ] Implement league season management
- [ ] Add basic league statistics dashboard
- [ ] Create league administrator assignment interface
- [ ] Implement league archiving functionality
- [ ] Write tests for enhanced league management
- [ ] Create feature specs for league administration
- [ ] Test league membership workflows
- [ ] Ensure proper authorization for all actions

### 2.4: Rankings and Leaderboards
- [ ] Create RankingService class
- [ ] Implement ranking calculation logic
  - [ ] Aggregate scores across matches
  - [ ] Tie-breaking by X-count
  - [ ] Filtering by classification and gun type
- [ ] Write tests for RankingService
- [ ] Create LeaderboardController
- [ ] Build overall standings view
- [ ] Implement classification-based leaderboards
- [ ] Create gun type filtered leaderboards
- [ ] Add sorting and filtering options
- [ ] Implement pagination for large leaderboards
- [ ] Add historical rankings view
- [ ] Write controller specs for leaderboard
- [ ] Create feature specs for leaderboard functionality
- [ ] Test all ranking calculations
- [ ] Ensure proper authorization with Pundit

## Phase 3: Advanced Features

### 3.1: Reporting System
- [ ] Create ReportService for generating reports
  - [ ] Match results reports
  - [ ] Season standings reports
  - [ ] Shooter progression reports
  - [ ] Classification status reports
- [ ] Write tests for ReportService
- [ ] Create ReportsController
- [ ] Build report configuration interface
- [ ] Implement tabular data display for reports
- [ ] Add filtering options for reports
- [ ] Create PDF export functionality
- [ ] Implement CSV export functionality
- [ ] Build reports dashboard for administrators
- [ ] Create policy for report access
- [ ] Write controller specs for reporting
- [ ] Create feature specs for report generation
- [ ] Implement caching for report data
- [ ] Set up background processing for large reports (Sidekiq)
- [ ] Test all report generation options

### 3.2: Notification System
- [ ] Create Notification model
  - [ ] user_id (recipient)
  - [ ] notification_type (enum)
  - [ ] content
  - [ ] read_status
  - [ ] reference polymorphic association
  - [ ] created_at timestamp
- [ ] Write migration for notifications table
- [ ] Create NotificationService
  - [ ] Methods for creating different notification types
  - [ ] Delivery logic
- [ ] Implement notification triggers for:
  - [ ] New match results
  - [ ] Classification changes
  - [ ] League join request updates
  - [ ] Comments on match results
- [ ] Create notification badge in navigation
- [ ] Build dropdown for recent notifications
- [ ] Implement notifications index page
- [ ] Add email delivery for notifications (ActionMailer)
- [ ] Create user preferences for notification settings
- [ ] Write tests for notification model and service
- [ ] Create controller specs for notification management
- [ ] Implement feature specs for notification workflow
- [ ] Test email delivery
- [ ] Add real-time notifications with ActionCable (optional)

### 3.3: Social Features
- [ ] Create Comment model
  - [ ] user_id (author)
  - [ ] commentable polymorphic association
  - [ ] content
  - [ ] created_at timestamp
- [ ] Write migration for comments table
- [ ] Create Message model
  - [ ] sender_id (foreign key to users)
  - [ ] recipient_id (foreign key to users)
  - [ ] subject
  - [ ] content
  - [ ] read_status
  - [ ] created_at timestamp
- [ ] Write migration for messages table
- [ ] Create Announcement model
  - [ ] league_id (foreign key)
  - [ ] author_id (foreign key to users)
  - [ ] title
  - [ ] content
  - [ ] pinned (boolean)
  - [ ] expiration_date
  - [ ] created_at timestamp
- [ ] Write migration for announcements table
- [ ] Create factories for all social models
- [ ] Write model specs for social features
- [ ] Create CommentsController
- [ ] Implement comment functionality on match results
- [ ] Build MessagesController
- [ ] Create message inbox and composition interface
- [ ] Implement AnnouncementsController
- [ ] Build announcement creation and display
- [ ] Create policies for all social features
- [ ] Integrate notifications with social interactions
- [ ] Write controller specs for all social controllers
- [ ] Create feature specs for social interactions
- [ ] Test all social feature workflows

### 3.4: Custom League Configuration
- [ ] Enhance League model with:
  - [ ] scoring_system (JSON field)
  - [ ] ranking_method (enum)
  - [ ] classification_thresholds (JSON field)
  - [ ] match_format_settings (JSON field)
- [ ] Write migration to add configuration fields to leagues
- [ ] Create LeagueConfigService
  - [ ] Configuration validation methods
  - [ ] Custom scoring rule application
  - [ ] Custom ranking implementation
- [ ] Update score entry to respect league-specific rules
- [ ] Modify ranking calculations for league-specific methods
- [ ] Build league configuration interface for admins
- [ ] Create configuration templates/presets
- [ ] Write tests for LeagueConfigService
- [ ] Update existing score and ranking tests
- [ ] Create feature specs for league configuration
- [ ] Test configuration changes affect scoring/ranking
- [ ] Ensure backward compatibility for existing leagues

## Phase 4: Refinement and Optimization

### 4.1: Advanced Data Visualization
- [ ] Add Chart.js or D3.js to the project
- [ ] Create StatsVisualizationService
- [ ] Implement data preparation for various chart types
- [ ] Build score trend line charts
- [ ] Create performance comparison bar charts
- [ ] Implement classification distribution pie charts
- [ ] Add shooting performance visualizations
- [ ] Create league participation statistics
- [ ] Build dashboard interface for visualizations
- [ ] Implement responsive design for visualizations
- [ ] Add interactive features (tooltips, zooming, filtering)
- [ ] Write JavaScript tests for visualization components
- [ ] Create feature specs for visualization pages
- [ ] Implement caching for visualization data
- [ ] Test visualizations across devices

### 4.2: Performance Optimization
- [ ] Add database indexes to frequently queried columns
- [ ] Optimize complex queries using explain/analyze
- [ ] Implement database-level caching strategies
- [ ] Set up application-level caching for expensive calculations
- [ ] Add fragment caching for view components
- [ ] Configure Redis for cache storage
- [ ] Move report generation to background jobs
- [ ] Implement background email sending
- [ ] Add progress tracking for long-running tasks
- [ ] Optimize frontend assets (JavaScript, CSS)
- [ ] Implement lazy loading for page components
- [ ] Add pagination for large data sets
- [ ] Set up database query monitoring
- [ ] Write performance benchmarks
- [ ] Create performance test suite
- [ ] Configure monitoring for performance metrics
- [ ] Test application under load

### 4.3: Mobile Responsiveness and UI Refinement
- [ ] Audit all pages for mobile responsiveness
- [ ] Create mobile-specific layouts for complex views
- [ ] Implement touch-friendly controls
- [ ] Refine responsive breakpoints
- [ ] Create consistent color scheme
- [ ] Improve typography and readability
- [ ] Add subtle animations and transitions
- [ ] Enhance form usability and feedback
- [ ] Implement proper ARIA attributes
- [ ] Add keyboard navigation support
- [ ] Ensure screen reader compatibility
- [ ] Fix any color contrast issues
- [ ] Add dark mode theme option
- [ ] Implement user preference saving
- [ ] Create style guide and component library
- [ ] Write tests for responsive behavior
- [ ] Add accessibility tests
- [ ] Optimize mobile page load performance

### 4.4: Final Integration and Deployment
- [ ] Complete comprehensive test suite
  - [ ] Model unit tests
  - [ ] Controller tests
  - [ ] Integration tests
  - [ ] System tests
  - [ ] Performance tests
- [ ] Implement security headers
- [ ] Verify CSRF protection
- [ ] Configure SSL
- [ ] Add rate limiting for sensitive endpoints
- [ ] Create production environment configuration
- [ ] Set up database backup procedures
- [ ] Configure logging and monitoring
- [ ] Set up error reporting service
- [ ] Create API documentation
- [ ] Write user guides for different roles
- [ ] Document database schema and relationships
- [ ] Add developer onboarding instructions
- [ ] Set up continuous integration pipeline
- [ ] Configure automated testing
- [ ] Create staging environment deployment process
- [ ] Document production deployment process
- [ ] Implement feature flags for phased rollout
- [ ] Plan database migration strategy for production
- [ ] Conduct final code review
- [ ] Perform security audit
- [ ] Create deployment checklist
- [ ] Set up monitoring alerts
- [ ] Prepare launch plan

## Phase 5: Post-Launch Maintenance

### 5.1: Bug Fixing and Monitoring
- [ ] Set up error tracking service
- [ ] Configure performance monitoring
- [ ] Implement user feedback collection
- [ ] Create bug reporting process
- [ ] Establish bug fix prioritization system
- [ ] Set up monitoring alerts
- [ ] Create process for security updates
- [ ] Document maintenance procedures

### 5.2: Feature Enhancements
- [ ] Create roadmap for future features
- [ ] Set up feature request tracking
- [ ] Implement usage analytics to identify improvement areas
- [ ] Plan for regular database optimization
- [ ] Document enhancement prioritization process
- [ ] Create process for backwards compatibility assessment
- [ ] Set up beta testing procedures for new features
