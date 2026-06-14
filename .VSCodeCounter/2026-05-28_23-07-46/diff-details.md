# Diff Details

Date : 2026-05-28 23:07:46

Directory /Users/aboubacarsogoba/Desktop/LSFramework

Total : 255 files,  14651 codes, 935 comments, 2034 blanks, all 17620 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [.dockerignore](/.dockerignore) | Ignore | 25 | 0 | 1 | 26 |
| [.github/workflows/ls-framework-appointment-api.yml](/.github/workflows/ls-framework-appointment-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-audit-api.yml](/.github/workflows/ls-framework-audit-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-auth-api.yml](/.github/workflows/ls-framework-auth-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-billing-api.yml](/.github/workflows/ls-framework-billing-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-doctor-api.yml](/.github/workflows/ls-framework-doctor-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-file-service.yml](/.github/workflows/ls-framework-file-service.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-gateway-api.yml](/.github/workflows/ls-framework-gateway-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-notification-api.yml](/.github/workflows/ls-framework-notification-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-patient-api.yml](/.github/workflows/ls-framework-patient-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-tenant-api.yml](/.github/workflows/ls-framework-tenant-api.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls-framework-worker-service.yml](/.github/workflows/ls-framework-worker-service.yml) | YAML | 73 | 11 | 20 | 104 |
| [.github/workflows/ls\_framework\_frontend.yml](/.github/workflows/ls_framework_frontend.yml) | YAML | 69 | 6 | 13 | 88 |
| [.github/workflows/ls\_framework\_terraform\_pipeline.yml](/.github/workflows/ls_framework_terraform_pipeline.yml) | YAML | 69 | 10 | 14 | 93 |
| [LS.Docker/Appointment.Dockerfile](/LS.Docker/Appointment.Dockerfile) | Docker | 20 | 1 | 5 | 26 |
| [LS.Docker/Audit.Dockerfile](/LS.Docker/Audit.Dockerfile) | Docker | 20 | 1 | 5 | 26 |
| [LS.Docker/Auth.Dockerfile](/LS.Docker/Auth.Dockerfile) | Docker | 20 | 1 | 8 | 29 |
| [LS.Docker/Billing.Dockerfile](/LS.Docker/Billing.Dockerfile) | Docker | 20 | 1 | 5 | 26 |
| [LS.Docker/Doctor.Dockerfile](/LS.Docker/Doctor.Dockerfile) | Docker | 20 | 1 | 5 | 26 |
| [LS.Docker/FileService.Dockerfile](/LS.Docker/FileService.Dockerfile) | Docker | 20 | 1 | 5 | 26 |
| [LS.Docker/Gateway.Dockerfile](/LS.Docker/Gateway.Dockerfile) | Docker | 19 | 1 | 5 | 25 |
| [LS.Docker/Notification.Dockerfile](/LS.Docker/Notification.Dockerfile) | Docker | 20 | 1 | 5 | 26 |
| [LS.Docker/Patient.Dockerfile](/LS.Docker/Patient.Dockerfile) | Docker | 20 | 1 | 5 | 26 |
| [LS.Docker/Tenant.Dockerfile](/LS.Docker/Tenant.Dockerfile) | Docker | 20 | 1 | 4 | 25 |
| [LS.Docker/WorkerService.Dockerfile](/LS.Docker/WorkerService.Dockerfile) | Docker | 17 | 1 | 4 | 22 |
| [README.md](/README.md) | Markdown | 0 | 0 | 1 | 1 |
| [docker-compose.yml](/docker-compose.yml) | YAML | 73 | 9 | 10 | 92 |
| [ls-front-end/README.md](/ls-front-end/README.md) | Markdown | 60 | 0 | 14 | 74 |
| [ls-front-end/eslint.config.js](/ls-front-end/eslint.config.js) | JavaScript | 22 | 0 | 2 | 24 |
| [ls-front-end/index.html](/ls-front-end/index.html) | HTML | 13 | 1 | 1 | 15 |
| [ls-front-end/package-lock.json](/ls-front-end/package-lock.json) | JSON | 4,743 | 0 | 1 | 4,744 |
| [ls-front-end/package.json](/ls-front-end/package.json) | JSON | 46 | 0 | 1 | 47 |
| [ls-front-end/public/vite.svg](/ls-front-end/public/vite.svg) | XML | 1 | 0 | 0 | 1 |
| [ls-front-end/src/App.css](/ls-front-end/src/App.css) | PostCSS | 0 | 0 | 1 | 1 |
| [ls-front-end/src/App.tsx](/ls-front-end/src/App.tsx) | TypeScript JSX | 14 | 1 | 5 | 20 |
| [ls-front-end/src/AuthLoader.tsx](/ls-front-end/src/AuthLoader.tsx) | TypeScript JSX | 13 | 3 | 4 | 20 |
| [ls-front-end/src/DoctorManagement/pages/DoctorPage.tsx](/ls-front-end/src/DoctorManagement/pages/DoctorPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/LandingManagement/pages/AboutPage.tsx](/ls-front-end/src/LandingManagement/pages/AboutPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/LandingManagement/pages/ContactPage.tsx](/ls-front-end/src/LandingManagement/pages/ContactPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/LandingManagement/pages/FeaturesPage.tsx](/ls-front-end/src/LandingManagement/pages/FeaturesPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/LandingManagement/pages/LandingNav.tsx](/ls-front-end/src/LandingManagement/pages/LandingNav.tsx) | TypeScript JSX | 158 | 6 | 11 | 175 |
| [ls-front-end/src/LandingManagement/pages/LandingPage.tsx](/ls-front-end/src/LandingManagement/pages/LandingPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/LandingManagement/pages/LandingRootLayout.tsx](/ls-front-end/src/LandingManagement/pages/LandingRootLayout.tsx) | TypeScript JSX | 10 | 0 | 1 | 11 |
| [ls-front-end/src/LandingManagement/pages/PricingPage.tsx](/ls-front-end/src/LandingManagement/pages/PricingPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/LandingManagement/pages/RegistrationPage.tsx](/ls-front-end/src/LandingManagement/pages/RegistrationPage.tsx) | TypeScript JSX | 219 | 14 | 23 | 256 |
| [ls-front-end/src/PublicLayout.tsx](/ls-front-end/src/PublicLayout.tsx) | TypeScript JSX | 12 | 0 | 1 | 13 |
| [ls-front-end/src/RootLayout.tsx](/ls-front-end/src/RootLayout.tsx) | TypeScript JSX | 8 | 0 | 1 | 9 |
| [ls-front-end/src/TenantPublicLayout.tsx](/ls-front-end/src/TenantPublicLayout.tsx) | TypeScript JSX | 10 | 5 | 4 | 19 |
| [ls-front-end/src/appointmentManagement/pages/AppointmentPage.tsx](/ls-front-end/src/appointmentManagement/pages/AppointmentPage.tsx) | TypeScript JSX | 82 | 6 | 8 | 96 |
| [ls-front-end/src/auth/PrivateRoute.tsx](/ls-front-end/src/auth/PrivateRoute.tsx) | TypeScript JSX | 12 | 4 | 5 | 21 |
| [ls-front-end/src/auth/api/useAuthUserApi.tsx](/ls-front-end/src/auth/api/useAuthUserApi.tsx) | TypeScript JSX | 38 | 23 | 16 | 77 |
| [ls-front-end/src/auth/hooks/AuthContext.tsx](/ls-front-end/src/auth/hooks/AuthContext.tsx) | TypeScript JSX | 66 | 3 | 11 | 80 |
| [ls-front-end/src/auth/hooks/LoginButton.tsx](/ls-front-end/src/auth/hooks/LoginButton.tsx) | TypeScript JSX | 17 | 1 | 2 | 20 |
| [ls-front-end/src/auth/hooks/LogoutButton.tsx](/ls-front-end/src/auth/hooks/LogoutButton.tsx) | TypeScript JSX | 25 | 9 | 9 | 43 |
| [ls-front-end/src/auth/pages/AuthLayout.tsx](/ls-front-end/src/auth/pages/AuthLayout.tsx) | TypeScript JSX | 23 | 0 | 2 | 25 |
| [ls-front-end/src/auth/pages/LoginPage.tsx](/ls-front-end/src/auth/pages/LoginPage.tsx) | TypeScript JSX | 98 | 8 | 17 | 123 |
| [ls-front-end/src/auth/pages/SignupPage.tsx](/ls-front-end/src/auth/pages/SignupPage.tsx) | TypeScript JSX | 195 | 6 | 22 | 223 |
| [ls-front-end/src/billingManagement/pages/BillingPage.tsx](/ls-front-end/src/billingManagement/pages/BillingPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/commonApiConfig/apiClient.ts](/ls-front-end/src/commonApiConfig/apiClient.ts) | TypeScript | 5 | 0 | 1 | 6 |
| [ls-front-end/src/commonApiConfig/config.ts](/ls-front-end/src/commonApiConfig/config.ts) | TypeScript | 1 | 0 | 2 | 3 |
| [ls-front-end/src/home/pages/DashboardPage.tsx](/ls-front-end/src/home/pages/DashboardPage.tsx) | TypeScript JSX | 148 | 11 | 2 | 161 |
| [ls-front-end/src/home/pages/HomePage.tsx](/ls-front-end/src/home/pages/HomePage.tsx) | TypeScript JSX | 148 | 16 | 8 | 172 |
| [ls-front-end/src/home/pages/UserProfile.tsx](/ls-front-end/src/home/pages/UserProfile.tsx) | TypeScript JSX | 222 | 109 | 37 | 368 |
| [ls-front-end/src/home/sidenav.tsx](/ls-front-end/src/home/sidenav.tsx) | TypeScript JSX | 553 | 26 | 30 | 609 |
| [ls-front-end/src/index.css](/ls-front-end/src/index.css) | PostCSS | 3 | 0 | 0 | 3 |
| [ls-front-end/src/main.tsx](/ls-front-end/src/main.tsx) | TypeScript JSX | 15 | 1 | 2 | 18 |
| [ls-front-end/src/notificationManagement/pages/NotificationPage.tsx](/ls-front-end/src/notificationManagement/pages/NotificationPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/patientManagement/pages/PatientPage.tsx](/ls-front-end/src/patientManagement/pages/PatientPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/routes-manager/LafiyaSiraRouters.tsx](/ls-front-end/src/routes-manager/LafiyaSiraRouters.tsx) | TypeScript JSX | 71 | 13 | 5 | 89 |
| [ls-front-end/src/tenantManagement/api/useTenantApi.tsx](/ls-front-end/src/tenantManagement/api/useTenantApi.tsx) | TypeScript JSX | 30 | 5 | 10 | 45 |
| [ls-front-end/src/tenantManagement/pages/TenantPage.tsx](/ls-front-end/src/tenantManagement/pages/TenantPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/theme/ThemeConfig.ts](/ls-front-end/src/theme/ThemeConfig.ts) | TypeScript | 115 | 1 | 5 | 121 |
| [ls-front-end/src/theme/ThemeContext.tsx](/ls-front-end/src/theme/ThemeContext.tsx) | TypeScript JSX | 33 | 1 | 9 | 43 |
| [ls-front-end/src/theme/ThemeToggle.tsx](/ls-front-end/src/theme/ThemeToggle.tsx) | TypeScript JSX | 41 | 0 | 4 | 45 |
| [ls-front-end/src/userManagement/api/useAuthUserApi.tsx](/ls-front-end/src/userManagement/api/useAuthUserApi.tsx) | TypeScript JSX | 0 | 13 | 4 | 17 |
| [ls-front-end/src/userManagement/pages/UserPage.tsx](/ls-front-end/src/userManagement/pages/UserPage.tsx) | TypeScript JSX | 9 | 0 | 1 | 10 |
| [ls-front-end/src/vite-env.d.ts](/ls-front-end/src/vite-env.d.ts) | TypeScript | 0 | 1 | 1 | 2 |
| [ls-front-end/tsconfig.app.json](/ls-front-end/tsconfig.app.json) | JSON | 24 | 2 | 3 | 29 |
| [ls-front-end/tsconfig.json](/ls-front-end/tsconfig.json) | JSON with Comments | 7 | 0 | 1 | 8 |
| [ls-front-end/tsconfig.node.json](/ls-front-end/tsconfig.node.json) | JSON | 22 | 2 | 3 | 27 |
| [ls-front-end/vite.config.ts](/ls-front-end/vite.config.ts) | TypeScript | 9 | 1 | 2 | 12 |
| [src/LS.AppointmentApi/Controllers/AppointmentController.cs](/src/LS.AppointmentApi/Controllers/AppointmentController.cs) | C# | 37 | 0 | 5 | 42 |
| [src/LS.AppointmentApi/Controllers/Errors/AppointmentApiControllerError.cs](/src/LS.AppointmentApi/Controllers/Errors/AppointmentApiControllerError.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.AppointmentApi/Contstants/AppointmentConstant.cs](/src/LS.AppointmentApi/Contstants/AppointmentConstant.cs) | C# | 17 | 2 | 5 | 24 |
| [src/LS.AppointmentApi/Data/AppointmentDBContext.cs](/src/LS.AppointmentApi/Data/AppointmentDBContext.cs) | C# | 15 | 0 | 6 | 21 |
| [src/LS.AppointmentApi/LS.AppointmentApi.csproj](/src/LS.AppointmentApi/LS.AppointmentApi.csproj) | XML | 34 | 0 | 8 | 42 |
| [src/LS.AppointmentApi/Mapping/MappingConfig.cs](/src/LS.AppointmentApi/Mapping/MappingConfig.cs) | C# | 12 | 0 | 3 | 15 |
| [src/LS.AppointmentApi/Migrations/20251029030734\_Initialization\_LS.AppointmentApi.Designer.cs](/src/LS.AppointmentApi/Migrations/20251029030734_Initialization_LS.AppointmentApi.Designer.cs) | C# | 48 | 2 | 14 | 64 |
| [src/LS.AppointmentApi/Migrations/20251029030734\_Initialization\_LS.AppointmentApi.cs](/src/LS.AppointmentApi/Migrations/20251029030734_Initialization_LS.AppointmentApi.cs) | C# | 34 | 3 | 4 | 41 |
| [src/LS.AppointmentApi/Migrations/AppointmentDBContextModelSnapshot.cs](/src/LS.AppointmentApi/Migrations/AppointmentDBContextModelSnapshot.cs) | C# | 46 | 1 | 14 | 61 |
| [src/LS.AppointmentApi/Model/Dtos/AppointmentDto.cs](/src/LS.AppointmentApi/Model/Dtos/AppointmentDto.cs) | C# | 11 | 0 | 4 | 15 |
| [src/LS.AppointmentApi/Model/Entities/Appointment.cs](/src/LS.AppointmentApi/Model/Entities/Appointment.cs) | C# | 48 | 0 | 13 | 61 |
| [src/LS.AppointmentApi/Program.cs](/src/LS.AppointmentApi/Program.cs) | C# | 76 | 24 | 21 | 121 |
| [src/LS.AppointmentApi/Properties/launchSettings.json](/src/LS.AppointmentApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.AppointmentApi/Services/AppointmentRepository.cs](/src/LS.AppointmentApi/Services/AppointmentRepository.cs) | C# | 20 | 0 | 4 | 24 |
| [src/LS.AppointmentApi/Services/IServices/IAppointmentRepository.cs](/src/LS.AppointmentApi/Services/IServices/IAppointmentRepository.cs) | C# | 7 | 0 | 4 | 11 |
| [src/LS.AuditApi/Controllers/AuditLogController.cs](/src/LS.AuditApi/Controllers/AuditLogController.cs) | C# | 81 | 18 | 19 | 118 |
| [src/LS.AuditApi/Controllers/Errors/AuditLogApiControllerError.cs](/src/LS.AuditApi/Controllers/Errors/AuditLogApiControllerError.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.AuditApi/Data/AuditLogDbContext.cs](/src/LS.AuditApi/Data/AuditLogDbContext.cs) | C# | 16 | 0 | 6 | 22 |
| [src/LS.AuditApi/Events/Publisher/AuditLogPublisher.cs](/src/LS.AuditApi/Events/Publisher/AuditLogPublisher.cs) | C# | 5 | 0 | 4 | 9 |
| [src/LS.AuditApi/Events/Publisher/IAuditLogPublisher.cs](/src/LS.AuditApi/Events/Publisher/IAuditLogPublisher.cs) | C# | 5 | 0 | 4 | 9 |
| [src/LS.AuditApi/LS.AuditApi.csproj](/src/LS.AuditApi/LS.AuditApi.csproj) | XML | 33 | 0 | 6 | 39 |
| [src/LS.AuditApi/Model/Entities/AuditLog.cs](/src/LS.AuditApi/Model/Entities/AuditLog.cs) | C# | 38 | 0 | 4 | 42 |
| [src/LS.AuditApi/Program.cs](/src/LS.AuditApi/Program.cs) | C# | 65 | 30 | 20 | 115 |
| [src/LS.AuditApi/Properties/launchSettings.json](/src/LS.AuditApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.AuditApi/Services/AuditLogRepository.cs](/src/LS.AuditApi/Services/AuditLogRepository.cs) | C# | 28 | 0 | 5 | 33 |
| [src/LS.AuditApi/Services/IServices/IAuditLogRepository.cs](/src/LS.AuditApi/Services/IServices/IAuditLogRepository.cs) | C# | 8 | 0 | 3 | 11 |
| [src/LS.AuthUserApi/Constants/AuthUserConstant.cs](/src/LS.AuthUserApi/Constants/AuthUserConstant.cs) | C# | 16 | 3 | 6 | 25 |
| [src/LS.AuthUserApi/Controllers/AuthUserController.cs](/src/LS.AuthUserApi/Controllers/AuthUserController.cs) | C# | 245 | 26 | 36 | 307 |
| [src/LS.AuthUserApi/Controllers/Errors/AuthUserApiControllerError.cs](/src/LS.AuthUserApi/Controllers/Errors/AuthUserApiControllerError.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.AuthUserApi/Data/AuthUserDbContext.cs](/src/LS.AuthUserApi/Data/AuthUserDbContext.cs) | C# | 16 | 0 | 8 | 24 |
| [src/LS.AuthUserApi/Events/Publisher/AuthUserEventPublisher.cs](/src/LS.AuthUserApi/Events/Publisher/AuthUserEventPublisher.cs) | C# | 5 | 0 | 4 | 9 |
| [src/LS.AuthUserApi/LS.AuthUserApi.csproj](/src/LS.AuthUserApi/LS.AuthUserApi.csproj) | XML | 31 | 0 | 5 | 36 |
| [src/LS.AuthUserApi/Mapping/MappingConfig.cs](/src/LS.AuthUserApi/Mapping/MappingConfig.cs) | C# | 13 | 9 | 4 | 26 |
| [src/LS.AuthUserApi/Migrations/20251029030332\_Initialization\_LS.AuthApi.Designer.cs](/src/LS.AuthUserApi/Migrations/20251029030332_Initialization_LS.AuthApi.Designer.cs) | C# | 109 | 2 | 34 | 145 |
| [src/LS.AuthUserApi/Migrations/20251029030332\_Initialization\_LS.AuthApi.cs](/src/LS.AuthUserApi/Migrations/20251029030332_Initialization_LS.AuthApi.cs) | C# | 63 | 3 | 6 | 72 |
| [src/LS.AuthUserApi/Migrations/AuthUserDbContextModelSnapshot.cs](/src/LS.AuthUserApi/Migrations/AuthUserDbContextModelSnapshot.cs) | C# | 107 | 1 | 34 | 142 |
| [src/LS.AuthUserApi/Model/Dtos/LafiyaSiraGuestDto.cs](/src/LS.AuthUserApi/Model/Dtos/LafiyaSiraGuestDto.cs) | C# | 11 | 0 | 3 | 14 |
| [src/LS.AuthUserApi/Model/Dtos/LafiyaSiraStaffDto.cs](/src/LS.AuthUserApi/Model/Dtos/LafiyaSiraStaffDto.cs) | C# | 8 | 0 | 3 | 11 |
| [src/LS.AuthUserApi/Model/Dtos/LafiyaSiraUserDto.cs](/src/LS.AuthUserApi/Model/Dtos/LafiyaSiraUserDto.cs) | C# | 12 | 1 | 3 | 16 |
| [src/LS.AuthUserApi/Model/Dtos/LafiyaSiraUserLoginDto.cs](/src/LS.AuthUserApi/Model/Dtos/LafiyaSiraUserLoginDto.cs) | C# | 8 | 0 | 3 | 11 |
| [src/LS.AuthUserApi/Model/Dtos/LafiyaSiraUserSignupDto.cs](/src/LS.AuthUserApi/Model/Dtos/LafiyaSiraUserSignupDto.cs) | C# | 14 | 0 | 3 | 17 |
| [src/LS.AuthUserApi/Model/Entities/LafiyaSiraGuest.cs](/src/LS.AuthUserApi/Model/Entities/LafiyaSiraGuest.cs) | C# | 28 | 0 | 3 | 31 |
| [src/LS.AuthUserApi/Model/Entities/LafiyaSiraUser.cs](/src/LS.AuthUserApi/Model/Entities/LafiyaSiraUser.cs) | C# | 87 | 1 | 21 | 109 |
| [src/LS.AuthUserApi/Model/Interfaces/ILafiyaSiraUser.cs](/src/LS.AuthUserApi/Model/Interfaces/ILafiyaSiraUser.cs) | C# | 13 | 0 | 3 | 16 |
| [src/LS.AuthUserApi/Program.cs](/src/LS.AuthUserApi/Program.cs) | C# | 95 | 35 | 25 | 155 |
| [src/LS.AuthUserApi/Properties/launchSettings.json](/src/LS.AuthUserApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.AuthUserApi/Services/AuthUserRepository.cs](/src/LS.AuthUserApi/Services/AuthUserRepository.cs) | C# | 25 | 9 | 8 | 42 |
| [src/LS.AuthUserApi/Services/IServices/IAuthUserRepository.cs](/src/LS.AuthUserApi/Services/IServices/IAuthUserRepository.cs) | C# | 8 | 0 | 3 | 11 |
| [src/LS.BillingApi/Constant/BillingConstant.cs](/src/LS.BillingApi/Constant/BillingConstant.cs) | C# | 6 | 0 | 4 | 10 |
| [src/LS.BillingApi/Controllers/BillingController.cs](/src/LS.BillingApi/Controllers/BillingController.cs) | C# | 37 | 0 | 5 | 42 |
| [src/LS.BillingApi/Controllers/Errors/BillingApiControllerError.cs](/src/LS.BillingApi/Controllers/Errors/BillingApiControllerError.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.BillingApi/Data/BillingDbContext.cs](/src/LS.BillingApi/Data/BillingDbContext.cs) | C# | 16 | 0 | 7 | 23 |
| [src/LS.BillingApi/LS.BillingApi.csproj](/src/LS.BillingApi/LS.BillingApi.csproj) | XML | 34 | 0 | 7 | 41 |
| [src/LS.BillingApi/Mapping/MappingConfig.cs](/src/LS.BillingApi/Mapping/MappingConfig.cs) | C# | 13 | 0 | 3 | 16 |
| [src/LS.BillingApi/Migrations/20251029030825\_Initialization\_LS.BillingApi.Designer.cs](/src/LS.BillingApi/Migrations/20251029030825_Initialization_LS.BillingApi.Designer.cs) | C# | 77 | 2 | 25 | 104 |
| [src/LS.BillingApi/Migrations/20251029030825\_Initialization\_LS.BillingApi.cs](/src/LS.BillingApi/Migrations/20251029030825_Initialization_LS.BillingApi.cs) | C# | 60 | 3 | 7 | 70 |
| [src/LS.BillingApi/Migrations/BillingDbContextModelSnapshot.cs](/src/LS.BillingApi/Migrations/BillingDbContextModelSnapshot.cs) | C# | 75 | 1 | 25 | 101 |
| [src/LS.BillingApi/Model/Dtos/BillDto.cs](/src/LS.BillingApi/Model/Dtos/BillDto.cs) | C# | 11 | 0 | 3 | 14 |
| [src/LS.BillingApi/Model/Dtos/PaymentDto.cs](/src/LS.BillingApi/Model/Dtos/PaymentDto.cs) | C# | 11 | 0 | 3 | 14 |
| [src/LS.BillingApi/Model/Entities/Bill.cs](/src/LS.BillingApi/Model/Entities/Bill.cs) | C# | 30 | 3 | 4 | 37 |
| [src/LS.BillingApi/Model/Entities/Payment.cs](/src/LS.BillingApi/Model/Entities/Payment.cs) | C# | 32 | 0 | 3 | 35 |
| [src/LS.BillingApi/Program.cs](/src/LS.BillingApi/Program.cs) | C# | 76 | 25 | 20 | 121 |
| [src/LS.BillingApi/Properties/launchSettings.json](/src/LS.BillingApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.BillingApi/Services/BillingRepository.cs](/src/LS.BillingApi/Services/BillingRepository.cs) | C# | 20 | 0 | 4 | 24 |
| [src/LS.BillingApi/Services/IServices/IBillingRepository.cs](/src/LS.BillingApi/Services/IServices/IBillingRepository.cs) | C# | 7 | 0 | 4 | 11 |
| [src/LS.DoctorApi/Constants/DoctorConstant.cs](/src/LS.DoctorApi/Constants/DoctorConstant.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.DoctorApi/Controllers/DoctorController.cs](/src/LS.DoctorApi/Controllers/DoctorController.cs) | C# | 37 | 0 | 6 | 43 |
| [src/LS.DoctorApi/Controllers/Errors/DoctorApiControllerError.cs](/src/LS.DoctorApi/Controllers/Errors/DoctorApiControllerError.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.DoctorApi/Data/DoctorDbContext.cs](/src/LS.DoctorApi/Data/DoctorDbContext.cs) | C# | 15 | 0 | 7 | 22 |
| [src/LS.DoctorApi/LS.DoctorApi.csproj](/src/LS.DoctorApi/LS.DoctorApi.csproj) | XML | 34 | 0 | 7 | 41 |
| [src/LS.DoctorApi/Mapping/MappingConfig.cs](/src/LS.DoctorApi/Mapping/MappingConfig.cs) | C# | 12 | 0 | 3 | 15 |
| [src/LS.DoctorApi/Migrations/20251029030907\_Initialization\_LS.DoctorApi.Designer.cs](/src/LS.DoctorApi/Migrations/20251029030907_Initialization_LS.DoctorApi.Designer.cs) | C# | 48 | 2 | 14 | 64 |
| [src/LS.DoctorApi/Migrations/20251029030907\_Initialization\_LS.DoctorApi.cs](/src/LS.DoctorApi/Migrations/20251029030907_Initialization_LS.DoctorApi.cs) | C# | 33 | 3 | 4 | 40 |
| [src/LS.DoctorApi/Migrations/DoctorDbContextModelSnapshot.cs](/src/LS.DoctorApi/Migrations/DoctorDbContextModelSnapshot.cs) | C# | 46 | 1 | 14 | 61 |
| [src/LS.DoctorApi/Model/Dtos/DoctorDto.cs](/src/LS.DoctorApi/Model/Dtos/DoctorDto.cs) | C# | 11 | 0 | 3 | 14 |
| [src/LS.DoctorApi/Model/Entities/Doctor.cs](/src/LS.DoctorApi/Model/Entities/Doctor.cs) | C# | 79 | 3 | 5 | 87 |
| [src/LS.DoctorApi/Program.cs](/src/LS.DoctorApi/Program.cs) | C# | 76 | 25 | 19 | 120 |
| [src/LS.DoctorApi/Properties/launchSettings.json](/src/LS.DoctorApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.DoctorApi/Services/DoctorRepository.cs](/src/LS.DoctorApi/Services/DoctorRepository.cs) | C# | 20 | 0 | 4 | 24 |
| [src/LS.DoctorApi/Services/IServices/IDoctorRepository.cs](/src/LS.DoctorApi/Services/IServices/IDoctorRepository.cs) | C# | 7 | 0 | 4 | 11 |
| [src/LS.FileServiceApi/Constants/FileConstant.cs](/src/LS.FileServiceApi/Constants/FileConstant.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.FileServiceApi/Controllers/FileMetadataController.cs](/src/LS.FileServiceApi/Controllers/FileMetadataController.cs) | C# | 94 | 16 | 22 | 132 |
| [src/LS.FileServiceApi/Data/FileMetadataDbContext.cs](/src/LS.FileServiceApi/Data/FileMetadataDbContext.cs) | C# | 15 | 0 | 8 | 23 |
| [src/LS.FileServiceApi/LS.FileServiceApi.csproj](/src/LS.FileServiceApi/LS.FileServiceApi.csproj) | XML | 36 | 0 | 6 | 42 |
| [src/LS.FileServiceApi/Mapping/MappingConfig.cs](/src/LS.FileServiceApi/Mapping/MappingConfig.cs) | C# | 12 | 0 | 3 | 15 |
| [src/LS.FileServiceApi/Models/Dtos/FileMetadataDto.cs](/src/LS.FileServiceApi/Models/Dtos/FileMetadataDto.cs) | C# | 11 | 0 | 4 | 15 |
| [src/LS.FileServiceApi/Models/Dtos/SaveFileMetadataDto.cs](/src/LS.FileServiceApi/Models/Dtos/SaveFileMetadataDto.cs) | C# | 8 | 0 | 3 | 11 |
| [src/LS.FileServiceApi/Models/Entities/FileMetadata.cs](/src/LS.FileServiceApi/Models/Entities/FileMetadata.cs) | C# | 20 | 0 | 3 | 23 |
| [src/LS.FileServiceApi/Program.cs](/src/LS.FileServiceApi/Program.cs) | C# | 79 | 26 | 22 | 127 |
| [src/LS.FileServiceApi/Properties/launchSettings.json](/src/LS.FileServiceApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.FileServiceApi/Services/FileMetadataRepository.cs](/src/LS.FileServiceApi/Services/FileMetadataRepository.cs) | C# | 19 | 0 | 6 | 25 |
| [src/LS.FileServiceApi/Services/IServices/IFileMetadataRepository.cs](/src/LS.FileServiceApi/Services/IServices/IFileMetadataRepository.cs) | C# | 7 | 0 | 4 | 11 |
| [src/LS.Gateway/LS.Gateway.csproj](/src/LS.Gateway/LS.Gateway.csproj) | XML | 13 | 0 | 5 | 18 |
| [src/LS.Gateway/Program.cs](/src/LS.Gateway/Program.cs) | C# | 16 | 14 | 6 | 36 |
| [src/LS.Gateway/Properties/launchSettings.json](/src/LS.Gateway/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.NotificationApi/Constants/NotificationConstant.cs](/src/LS.NotificationApi/Constants/NotificationConstant.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.NotificationApi/Controllers/Errors/NotificationApiControllerError.cs](/src/LS.NotificationApi/Controllers/Errors/NotificationApiControllerError.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.NotificationApi/Controllers/NotificationController.cs](/src/LS.NotificationApi/Controllers/NotificationController.cs) | C# | 37 | 0 | 5 | 42 |
| [src/LS.NotificationApi/Data/NotificationDbContext.cs](/src/LS.NotificationApi/Data/NotificationDbContext.cs) | C# | 15 | 0 | 7 | 22 |
| [src/LS.NotificationApi/LS.NotificationApi.csproj](/src/LS.NotificationApi/LS.NotificationApi.csproj) | XML | 34 | 0 | 7 | 41 |
| [src/LS.NotificationApi/Mapping/MappingConfig.cs](/src/LS.NotificationApi/Mapping/MappingConfig.cs) | C# | 12 | 0 | 3 | 15 |
| [src/LS.NotificationApi/Migrations/20251029031014\_Initialization\_LS.NotificationApi.Designer.cs](/src/LS.NotificationApi/Migrations/20251029031014_Initialization_LS.NotificationApi.Designer.cs) | C# | 46 | 2 | 13 | 61 |
| [src/LS.NotificationApi/Migrations/20251029031014\_Initialization\_LS.NotificationApi.cs](/src/LS.NotificationApi/Migrations/20251029031014_Initialization_LS.NotificationApi.cs) | C# | 33 | 3 | 4 | 40 |
| [src/LS.NotificationApi/Migrations/NotificationDbContextModelSnapshot.cs](/src/LS.NotificationApi/Migrations/NotificationDbContextModelSnapshot.cs) | C# | 44 | 1 | 13 | 58 |
| [src/LS.NotificationApi/Model/Dtos/NotificationDto.cs](/src/LS.NotificationApi/Model/Dtos/NotificationDto.cs) | C# | 11 | 0 | 3 | 14 |
| [src/LS.NotificationApi/Model/Entities/Notification.cs](/src/LS.NotificationApi/Model/Entities/Notification.cs) | C# | 20 | 0 | 3 | 23 |
| [src/LS.NotificationApi/Program.cs](/src/LS.NotificationApi/Program.cs) | C# | 76 | 24 | 20 | 120 |
| [src/LS.NotificationApi/Properties/launchSettings.json](/src/LS.NotificationApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.NotificationApi/Services/IServices/INotificationRepository.cs](/src/LS.NotificationApi/Services/IServices/INotificationRepository.cs) | C# | 8 | 0 | 3 | 11 |
| [src/LS.NotificationApi/Services/NotificationRepository.cs](/src/LS.NotificationApi/Services/NotificationRepository.cs) | C# | 28 | 0 | 5 | 33 |
| [src/LS.PatientApi/Controllers/Errors/PatientApiControllerError.cs](/src/LS.PatientApi/Controllers/Errors/PatientApiControllerError.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.PatientApi/Controllers/PatientController.cs](/src/LS.PatientApi/Controllers/PatientController.cs) | C# | 37 | 1 | 6 | 44 |
| [src/LS.PatientApi/Contstants/PatientConstant.cs](/src/LS.PatientApi/Contstants/PatientConstant.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.PatientApi/Data/PatientDbContext.cs](/src/LS.PatientApi/Data/PatientDbContext.cs) | C# | 19 | 0 | 7 | 26 |
| [src/LS.PatientApi/LS.PatientApi.csproj](/src/LS.PatientApi/LS.PatientApi.csproj) | XML | 34 | 0 | 7 | 41 |
| [src/LS.PatientApi/Mapping/MappingConfig.cs](/src/LS.PatientApi/Mapping/MappingConfig.cs) | C# | 16 | 0 | 3 | 19 |
| [src/LS.PatientApi/Migrations/20251029031106\_Initialization\_LS.PatientApi.Designer.cs](/src/LS.PatientApi/Migrations/20251029031106_Initialization_LS.PatientApi.Designer.cs) | C# | 213 | 2 | 82 | 297 |
| [src/LS.PatientApi/Migrations/20251029031106\_Initialization\_LS.PatientApi.cs](/src/LS.PatientApi/Migrations/20251029031106_Initialization_LS.PatientApi.cs) | C# | 170 | 3 | 17 | 190 |
| [src/LS.PatientApi/Migrations/PatientDbContextModelSnapshot.cs](/src/LS.PatientApi/Migrations/PatientDbContextModelSnapshot.cs) | C# | 211 | 1 | 82 | 294 |
| [src/LS.PatientApi/Model/Dtos/ContactInformationDto.cs](/src/LS.PatientApi/Model/Dtos/ContactInformationDto.cs) | C# | 11 | 0 | 4 | 15 |
| [src/LS.PatientApi/Model/Dtos/LabResultDto.cs](/src/LS.PatientApi/Model/Dtos/LabResultDto.cs) | C# | 11 | 0 | 5 | 16 |
| [src/LS.PatientApi/Model/Dtos/MedicalRecordDto.cs](/src/LS.PatientApi/Model/Dtos/MedicalRecordDto.cs) | C# | 11 | 0 | 4 | 15 |
| [src/LS.PatientApi/Model/Dtos/PasswordGeneratorDto.cs](/src/LS.PatientApi/Model/Dtos/PasswordGeneratorDto.cs) | C# | 42 | 3 | 11 | 56 |
| [src/LS.PatientApi/Model/Dtos/PatientDto.cs](/src/LS.PatientApi/Model/Dtos/PatientDto.cs) | C# | 12 | 0 | 4 | 16 |
| [src/LS.PatientApi/Model/Dtos/PrescriptionDto.cs](/src/LS.PatientApi/Model/Dtos/PrescriptionDto.cs) | C# | 11 | 0 | 3 | 14 |
| [src/LS.PatientApi/Model/Entities/ContactInformation.cs](/src/LS.PatientApi/Model/Entities/ContactInformation.cs) | C# | 26 | 2 | 7 | 35 |
| [src/LS.PatientApi/Model/Entities/LabResult.cs](/src/LS.PatientApi/Model/Entities/LabResult.cs) | C# | 20 | 1 | 4 | 25 |
| [src/LS.PatientApi/Model/Entities/MedicalRecord.cs](/src/LS.PatientApi/Model/Entities/MedicalRecord.cs) | C# | 21 | 1 | 3 | 25 |
| [src/LS.PatientApi/Model/Entities/Patient.cs](/src/LS.PatientApi/Model/Entities/Patient.cs) | C# | 39 | 4 | 7 | 50 |
| [src/LS.PatientApi/Model/Entities/Prescription.cs](/src/LS.PatientApi/Model/Entities/Prescription.cs) | C# | 17 | 0 | 4 | 21 |
| [src/LS.PatientApi/Program.cs](/src/LS.PatientApi/Program.cs) | C# | 76 | 25 | 20 | 121 |
| [src/LS.PatientApi/Properties/launchSettings.json](/src/LS.PatientApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.PatientApi/Services/IServices/IPatientRepository.cs](/src/LS.PatientApi/Services/IServices/IPatientRepository.cs) | C# | 7 | 0 | 4 | 11 |
| [src/LS.PatientApi/Services/PatientRepository.cs](/src/LS.PatientApi/Services/PatientRepository.cs) | C# | 20 | 0 | 4 | 24 |
| [src/LS.Shared/CommonContstant.cs](/src/LS.Shared/CommonContstant.cs) | C# | 26 | 0 | 3 | 29 |
| [src/LS.Shared/CommonRepository/BaseRepository.cs](/src/LS.Shared/CommonRepository/BaseRepository.cs) | C# | 69 | 5 | 19 | 93 |
| [src/LS.Shared/CommonRepository/IBaseRepository.cs](/src/LS.Shared/CommonRepository/IBaseRepository.cs) | C# | 12 | 5 | 8 | 25 |
| [src/LS.Shared/Configuration/AwsSettings.cs](/src/LS.Shared/Configuration/AwsSettings.cs) | C# | 24 | 1 | 8 | 33 |
| [src/LS.Shared/Events/AuditLogPublisher.cs](/src/LS.Shared/Events/AuditLogPublisher.cs) | C# | 44 | 4 | 7 | 55 |
| [src/LS.Shared/Interfaces/IAuditLogPublisher.cs](/src/LS.Shared/Interfaces/IAuditLogPublisher.cs) | C# | 7 | 0 | 3 | 10 |
| [src/LS.Shared/Interfaces/ITenantProvider.cs](/src/LS.Shared/Interfaces/ITenantProvider.cs) | C# | 8 | 0 | 3 | 11 |
| [src/LS.Shared/LS.Shared.csproj](/src/LS.Shared/LS.Shared.csproj) | XML | 14 | 0 | 4 | 18 |
| [src/LS.Shared/Middleware/TenantMiddleware.cs](/src/LS.Shared/Middleware/TenantMiddleware.cs) | C# | 46 | 26 | 15 | 87 |
| [src/LS.Shared/Model/Dtos/AuditLogEventDto.cs](/src/LS.Shared/Model/Dtos/AuditLogEventDto.cs) | C# | 18 | 0 | 3 | 21 |
| [src/LS.Shared/Model/Dtos/PasswordGeneratorDto.cs](/src/LS.Shared/Model/Dtos/PasswordGeneratorDto.cs) | C# | 42 | 3 | 11 | 56 |
| [src/LS.Shared/Model/Dtos/TenantDto.cs](/src/LS.Shared/Model/Dtos/TenantDto.cs) | C# | 10 | 0 | 3 | 13 |
| [src/LS.Shared/Model/Entities/MultiTenantEntity.cs](/src/LS.Shared/Model/Entities/MultiTenantEntity.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.Shared/ResultDto.cs](/src/LS.Shared/ResultDto.cs) | C# | 12 | 0 | 4 | 16 |
| [src/LS.Shared/Services/TenantProvider.cs](/src/LS.Shared/Services/TenantProvider.cs) | C# | 46 | 0 | 11 | 57 |
| [src/LS.Shared/Services/WorkerTenantProvider.cs](/src/LS.Shared/Services/WorkerTenantProvider.cs) | C# | 16 | 4 | 9 | 29 |
| [src/LS.TenantApi/Constants/TenantConstant.cs](/src/LS.TenantApi/Constants/TenantConstant.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.TenantApi/Controllers/Errors/TenantApiControllerError.cs](/src/LS.TenantApi/Controllers/Errors/TenantApiControllerError.cs) | C# | 6 | 0 | 3 | 9 |
| [src/LS.TenantApi/Controllers/TenantController.cs](/src/LS.TenantApi/Controllers/TenantController.cs) | C# | 146 | 20 | 27 | 193 |
| [src/LS.TenantApi/Data/TenantDbContext.cs](/src/LS.TenantApi/Data/TenantDbContext.cs) | C# | 9 | 0 | 4 | 13 |
| [src/LS.TenantApi/Events/Publisher/TenantEventPublisher.cs](/src/LS.TenantApi/Events/Publisher/TenantEventPublisher.cs) | C# | 37 | 2 | 6 | 45 |
| [src/LS.TenantApi/LS.TenantApi.csproj](/src/LS.TenantApi/LS.TenantApi.csproj) | XML | 30 | 0 | 5 | 35 |
| [src/LS.TenantApi/Mapping/MappingConfig.cs](/src/LS.TenantApi/Mapping/MappingConfig.cs) | C# | 12 | 0 | 3 | 15 |
| [src/LS.TenantApi/Migrations/20251029031154\_Initialization\_LS.TenantApi.Designer.cs](/src/LS.TenantApi/Migrations/20251029031154_Initialization_LS.TenantApi.Designer.cs) | C# | 48 | 2 | 13 | 63 |
| [src/LS.TenantApi/Migrations/20251029031154\_Initialization\_LS.TenantApi.cs](/src/LS.TenantApi/Migrations/20251029031154_Initialization_LS.TenantApi.cs) | C# | 33 | 3 | 4 | 40 |
| [src/LS.TenantApi/Migrations/TenantDbContextModelSnapshot.cs](/src/LS.TenantApi/Migrations/TenantDbContextModelSnapshot.cs) | C# | 46 | 1 | 13 | 60 |
| [src/LS.TenantApi/Model/Dtos/TenantAdminSignupDto.cs](/src/LS.TenantApi/Model/Dtos/TenantAdminSignupDto.cs) | C# | 14 | 0 | 3 | 17 |
| [src/LS.TenantApi/Model/Dtos/TenantDto.cs](/src/LS.TenantApi/Model/Dtos/TenantDto.cs) | C# | 11 | 0 | 3 | 14 |
| [src/LS.TenantApi/Model/Entities/Tenant.cs](/src/LS.TenantApi/Model/Entities/Tenant.cs) | C# | 18 | 0 | 4 | 22 |
| [src/LS.TenantApi/Program.cs](/src/LS.TenantApi/Program.cs) | C# | 78 | 24 | 20 | 122 |
| [src/LS.TenantApi/Properties/launchSettings.json](/src/LS.TenantApi/Properties/launchSettings.json) | JSON | 41 | 0 | 1 | 42 |
| [src/LS.TenantApi/Services/IServices/ITenantRepository.cs](/src/LS.TenantApi/Services/IServices/ITenantRepository.cs) | C# | 12 | 0 | 4 | 16 |
| [src/LS.TenantApi/Services/TenantRepository.cs](/src/LS.TenantApi/Services/TenantRepository.cs) | C# | 49 | 1 | 9 | 59 |
| [src/LS.WorkerService/Events/TenantSubscriber.cs](/src/LS.WorkerService/Events/TenantSubscriber.cs) | C# | 112 | 11 | 20 | 143 |
| [src/LS.WorkerService/EventsDto/AuditLogEventsDto/AuditLogEventDto.cs](/src/LS.WorkerService/EventsDto/AuditLogEventsDto/AuditLogEventDto.cs) | C# | 18 | 0 | 3 | 21 |
| [src/LS.WorkerService/EventsDto/AuthEventsDto/TenantAdminSignUpEventDto.cs](/src/LS.WorkerService/EventsDto/AuthEventsDto/TenantAdminSignUpEventDto.cs) | C# | 15 | 0 | 3 | 18 |
| [src/LS.WorkerService/LS.WorkerService.csproj](/src/LS.WorkerService/LS.WorkerService.csproj) | XML | 50 | 0 | 15 | 65 |
| [src/LS.WorkerService/Program.cs](/src/LS.WorkerService/Program.cs) | C# | 68 | 7 | 19 | 94 |
| [src/LS.WorkerService/Properties/launchSettings.json](/src/LS.WorkerService/Properties/launchSettings.json) | JSON | 12 | 0 | 1 | 13 |
| [src/LS.WorkerService/Worker.cs](/src/LS.WorkerService/Worker.cs) | C# | 20 | 0 | 4 | 24 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details