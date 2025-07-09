// .eslintrc.js
module.exports = {
  root: true,
  env: { browser: true, es2021: true, node: true },
  parserOptions: { ecmaVersion: 12, sourceType: "module" },
  plugins: ["react", "jsonc"],
  extends: [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:jsonc/recommended-with-jsonc",
  ],
  overrides: [
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
    // default for JS files
    "max-len": ["warn", {
      code: 100,
      tabWidth: 2,
      ignoreUrls: true,
      ignoreStrings: true,
      ignoreTemplateLiterals: true,
      ignoreRegExpLiterals: true,
      ignoreComments: true
    }],
    "no-unused-vars": ["warn", { argsIgnorePattern: "^_" }],
    "no-console": ["warn", { allow: ["warn", "error"] }]
  }
};
