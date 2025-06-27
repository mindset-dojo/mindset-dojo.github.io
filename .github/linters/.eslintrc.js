// .eslintrc.js
module.exports = {
  root: true,
  env: { browser: true, es2021: true, node: true },
  parserOptions: { ecmaVersion: 12, sourceType: "module" },
  plugins: ["md", "jsonc"],
  extends: [
    "eslint:recommended",
    "plugin:jsonc/recommended-with-jsonc",
    "plugin:markdown/recommended-legacy"
  ],
  overrides: [
    {
      files: ["*.md"],
      processor: "markdown/markdown"
    },
    {
      files: ["*.json", "*.jsonc"],
      parser: "jsonc-eslint-parser",
      rules: {
        "jsonc/auto": "error",
        "jsonc/no-comment": "off"
      }
    }
  ],
  rules: {
    "indent": ["error", 2],
    "quotes": ["error", "double"],
    "semi": ["error", "always"],
    "max-len": ["error", { code: 80, ignoreUrls: true }],
    "no-unused-vars": ["warn", { argsIgnorePattern: "^_" }],
    "no-console": ["warn", { allow: ["warn", "error"] }]
  }
};
