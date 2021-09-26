CREATE DATABASE IF NOT EXISTS `exampledb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `exampledb`;

-- NOTE: Name and Description fields (when present) are intended for use within the Admin Tool.
-- The information entered into these fields should not be used within the App.

-- Next Auth Accounts
-- The Account model is for information about OAuth accounts associated with a User.
-- A single User can have multiple Accounts, each Account can only have one User.
CREATE TABLE `accounts`
(
    `id`                  VARCHAR(191) NOT NULL PRIMARY KEY,
    `user_id`             VARCHAR(191) NOT NULL,
    `provider_type`       VARCHAR(191) NOT NULL,
    `provider_id`         VARCHAR(191) NOT NULL,
    `provider_account_id` VARCHAR(191) NOT NULL,
    `refresh_token`       VARCHAR(191) NULL,
    `access_token`        VARCHAR(191) NULL,
    `access_expires_at`   DATETIME(3)  NULL,
    `created_at`          DATETIME(3)  DEFAULT CURRENT_TIMESTAMP (3) NOT NULL,
    `updated_at`          DATETIME(3)  NOT NULL,
    CONSTRAINT `ux_accounts_provider_id_provider_account_id` UNIQUE (`provider_id`, `provider_account_id`)
);

CREATE INDEX `ix_accounts_user_id` ON `accounts` (`user_id`);

-- Next Auth Sessions
-- The Session model is used for database sessions. It is not used if JSON Web Tokens are enabled.
-- A single User can have multiple Sessions, each Session can only have one User.
CREATE TABLE `sessions`
(
    `id`            VARCHAR(191) NOT NULL PRIMARY KEY,
    `user_id`       VARCHAR(191) NOT NULL,
    `expires_at`    DATETIME(3)  NOT NULL,
    `session_token` VARCHAR(191) NOT NULL,
    `access_token`  VARCHAR(191) NOT NULL,
    `created_at`    DATETIME(3)  DEFAULT CURRENT_TIMESTAMP (3) NOT NULL,
    `updated_at`    DATETIME(3)  NOT NULL,
    CONSTRAINT `ux_sessions_access_token` UNIQUE (`access_token`),
    CONSTRAINT `ux_sessions_session_token` UNIQUE (`session_token`)
);

CREATE INDEX `user_id` ON `sessions` (`user_id`);

-- Next Auth Users
-- The User model is for information such as the users name and email address.
-- Email address are optional, but if one is specified for a User then it must be unique.
CREATE TABLE `users`
(
    `id`             VARCHAR(191) NOT NULL PRIMARY KEY,
    `name`           VARCHAR(191) NULL,
    `email`          VARCHAR(191) NULL,
    `email_verified` DATETIME(3)  NULL,
    `image`          VARCHAR(191) NULL,
    `access_code`    VARCHAR(191) NULL,
    `created_at`     DATETIME(3)  DEFAULT CURRENT_TIMESTAMP (3) NOT NULL,
    `updated_at`     DATETIME(3)  NOT NULL,
    CONSTRAINT `ux_users_email` UNIQUE (`email`)
);

-- Next Auth Verification Requests
-- The Verification Request model is used to store tokens for passwordless sign in emails.
-- A single User can have multiple open Verification Requests (e.g. to sign in to different devices).
-- It has been designed to be extendable for other verification purposes in future (e.g. 2FA / short codes).
CREATE TABLE `verification_requests`
(
    `id`         VARCHAR(191) NOT NULL PRIMARY KEY,
    `identifier` VARCHAR(191) NOT NULL,
    `token`      VARCHAR(191) NOT NULL,
    `expires_at` DATETIME(3)  NOT NULL,
    `created_at` DATETIME(3)  DEFAULT CURRENT_TIMESTAMP (3) NOT NULL,
    `updated_at` DATETIME(3)  NOT NULL,
    CONSTRAINT `ux_verification_requests_identifier_token` UNIQUE (`identifier`, `token`),
    CONSTRAINT `ux_verification_requests_token` UNIQUE (`token`)
);

-- ---------------------------------------------------------------------------------------------------------------------
-- FOREIGN KEYS
-- ---------------------------------------------------------------------------------------------------------------------
ALTER TABLE `accounts` ADD CONSTRAINT `fk_accounts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `sessions` ADD CONSTRAINT `fk_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;









