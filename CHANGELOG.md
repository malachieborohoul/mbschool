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


