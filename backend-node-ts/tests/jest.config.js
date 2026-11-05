/** @type {import("jest").Config} */
module.exports = {
  preset: "ts-jest",
  testEnvironment: "node",
  rootDir: "..",
  testMatch: ["**/tests/**/*.spec.ts"],
  moduleNameMapper: {
    "^@common/(.*)$":  "<rootDir>/src/Common/$1",
    "^@modules/(.*)$": "<rootDir>/src/Modules/$1"
  }
};
