/*
  Warnings:

  - You are about to drop the column `fullname` on the `notes` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `notes` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `notes` table. All the data in the column will be lost.
  - Added the required column `description` to the `Notes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Notes` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `notes` DROP COLUMN `fullname`,
    DROP COLUMN `password`,
    DROP COLUMN `username`,
    ADD COLUMN `description` VARCHAR(191) NOT NULL,
    ADD COLUMN `name` VARCHAR(191) NOT NULL;
