module.exports = {
  root: true,
  env: { browser: true, es2021: true, node: true },
  extends: [
    "eslint:recommended",
    "plugin:prettier/recommended"
  ],
  parserOptions: { ecmaVersion: 12, sourceType: "module" },
  plugins: ["md"],
  overrides: [
    {
      files: ["*.md"],
      plugins: ["md"],
      extends: ["plugin:md/recommended"]
    }
  ],
  rules: {
    "no-unused-vars": ["warn", { argsIgnorePattern: "^_" }],
    "no-console": ["warn", { allow: ["warn", "error"] }],
    "prettier/prettier": "error"
  }
};
