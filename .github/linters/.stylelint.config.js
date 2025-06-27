// .stylelint.config.js
module.exports = {
  extends: ["stylelint-config-standard"],
  plugins: [
    // Ignores YAML front-matter in Jekyll templates so stylelint only sees valid CSS
    "stylelint-processor-ignore-front-matter"
  ],
  processors: [
    "stylelint-processor-ignore-front-matter"
  ],
  rules: {
    // Allow Tailwind/PostCSS/Jekyll-specific at-rules without false positives
    "at-rule-no-unknown": [true, {
      ignoreAtRules: [
        "tailwind",
        "apply",
        "variants",
        "responsive",
        "screen"
      ]
    }],

    "property-no-vendor-prefix": [true, {
      ignoreAtRules: ["text-size-adjust"]
    }],


    // Formatting & style rules (mirroring stylelintrc.json)
    "indentation": [2, { "ignore": ["inside-parens"] }],                // 2-space indent
    "max-line-length": [100, { "ignore": ["comments", "url"] }],        // wrap at 100 chars
    "string-quotes": "double",                                          // use double quotes in strings

    // CSS best practices
    "block-no-empty": true,                                             // no empty blocks
    "color-no-invalid-hex": true,                                       // valid hex codes only
    "declaration-no-important": true,                                   // discourage !important
    "no-descending-specificity": true,                                  // prevent specificity conflicts

    // Reporting
    "reportInvalidScopeDisables": true,
    "reportNeedlessDisables": true
  }
};
