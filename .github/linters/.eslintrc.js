// .eslintrc.js
module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true,
    node: true
  },
  parserOptions: {
    ecmaVersion: 12,
    sourceType: "module"
  },
  plugins: [
    "md",
    "jsonc"
  ],
  extends: [
    "eslint:recommended",
    "plugin:prettier/recommended",           // runs Prettier as an ESLint rule
    "plugin:jsonc/recommended-with-jsonc",    // JSONC core rules
    "plugin:jsonc/prettier"                  // turn off JSON rules conflicting with Prettier
  ],
  overrides: [
    // Markdown code-block linting
    {
      files: ["*.md"],
      plugins: ["md"],
      extends: ["plugin:md/recommended"],
      rules: {
        // you can add or tweak markdown-specific rules here
      }
    },

    // JSON / JSONC linting
    {
      files: ["*.json", "*.jsonc"],
      parser: "jsonc-eslint-parser",
      rules: {
        "jsonc/auto": "error",         // catch structural problems
        "jsonc/no-comment": "off"      // allow comments in JSONC
      }
    }
  ],
  rules: {
    // JavaScript quality rules
    "no-unused-vars": ["warn", { argsIgnorePattern: "^_" }],
    "no-console": ["warn", { allow: ["warn", "error"] }],

    // Prettier formatting enforcement
    "prettier/prettier": "error"
  }
};
