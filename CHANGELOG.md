[1.0.0] - 2026-03-05
Initial Production Release

🚀 Features
Unified Authentication: Secure login system using JWT (JSON Web Tokens) with robust Refresh Token logic to keep users logged in safely.

Dual Role Management: Distinct interfaces and permissions for Students and Teachers/Administrators, managed via a PostgreSQL-backed role system.

Interactive Learning: Full support for course navigation, lesson tracking, and multimedia content delivery.

Localization (l10n): Complete English and French translation support, enabling a broader reach for educational content.

Responsive UI Engine: Implementation of SizeUtils for a consistent experience across various physical Android and iOS devices, regardless of screen density.

🛠 Technical Improvements
Architecture: Migrated to Clean Architecture patterns to separate Data, Domain, and Presentation layers, ensuring long-term maintainability.

State Management: Optimized app performance using Bloc/Cubit for reactive UI updates and global user state tracking.

Backend Sync: Established a versioned REST API (/api/v1) using Node.js and Express, optimized for high-concurrency database queries.

Connectivity Handling: Integrated a global errorHandler to gracefully manage network timeouts and server connection issues.

🩹 Bug Fixes
Type Safety: Resolved critical crashes related to String vs int mapping for User IDs and Status codes.

Layout Stability: Fixed LateInitializationError by ensuring SizeUtils initializes before the first frame of the LoadingScreen.

Secure Storage: Fixed token persistence logic to prevent unauthorized access after app restarts.


[1.0.0+4] — 2026-03-07
Official Internal Release
Production Stability & UI Enhancement

🚀 New Features
Enhanced Password Security: Integrated a visibility toggle (eye icon) in the CustomTextField component to improve user experience during authentication.

Production Build Success: Successfully generated and verified the signed Android App Bundle (.aab) after resolving keystore conflicts.

Account Protection: Verified account identity and successfully published to the Internal Testing track, successfully bypassing the March 9 dormancy deadline.

🛠 Technical Updates
Input Validation Logic: Centralized form validation using codeKey patterns for names, emails, and passwords with full localization support.

UI Layout Robustness: Refactored CustomTextField to use minHeight constraints instead of fixed heights, preventing layout overflows when validation errors are displayed.

Package Name Rollback: Fully restored the project identity to com.bsm.mbschool to ensure continuity with existing Play Store credentials.

Gradle Optimization: Cleaned the plugins block in build.gradle.kts to resolve build-time dependency injection errors.

🩹 Fixes
Network Connectivity: Resolved the "No internet connection" error in release builds by correctly configuring INTERNET permissions and HTTPS traffic requirements in the Android Manifest.

Keystore Pathing: Eliminated trailing space issues in key.properties that prevented Gradle from locating the .jks file.

State Management: Optimized CustomTextFieldState to handle internal visibility states independently of parent widget rebuilds.


[1.0.0+5] — 2026-03-10
Authentication Recovery Fix

Fix: Resolved AUTH_RESEND_ERROR by implementing a TLS bypass for unauthorized certificates in production.

Update: Forced a cache-cleared redeploy on Render to ensure new EMAIL_PASS credentials are active.

Security: Successfully whitelisted the production server IP via Google's DisplayUnlockCaptcha.