## 🥋 Mindset Dojo

Mindset Dojo is an open-source research lab advancing AI-integrated technology leadership and next-generation engineering practices.

Ensure you read through the homepage for context and initial guidance. ⛩️ <https://mindset.dojo.center>

If you want a gentle first exploratory step, fork this repository, light up a GitHub Pages site, and publish your first author card and Insight article.

### Quickstart: run your fork on GitHub Pages

1. **Fork** this repository.
2. In your fork, open **Settings → Pages** and set **Source** to the `main` branch and the `/` (root) directory.
3. Wait for the Pages build to finish, then visit `https://<username>.github.io/dojo` to confirm it is live.
4. Prefer an in-browser workspace? Use **GitHub Codespaces** from the repository header to edit without installing anything locally.

#### Troubleshooting

| Symptom | Fix |
| --- | --- |
| Build fails with CNAME error | Remove or update `CNAME` if you do not use a custom domain. |
| Custom domain not resolving | Allow DNS to propagate; keep `CNAME` aligned with your domain. |
| Jekyll/front matter error | Ensure front matter blocks start/end with `---` and use valid YAML keys. |

### Become an author: card + first Insight

Share who you are and what you are practicing by shipping both an author card and a first Insight.

1. Add your author card under `_authors/` with your slug, e.g., `_authors/jane-doe.md`:

   ```yaml
   ---
   layout: threshold
   sections_key: author
   name: Alex Doe
   description: Short bio sentence.
   title: "What you repeat, you become"
   title_mark: Repeat
   active: true
   join_date: 2025-01-01
   program_level: -8
   program_level_date: 2025-06-01
   leadership_designations: []
   emoji_signature: "✍️"
   custom_url: https://optional.custom.url.com
   about: |
     ### Summary

     A short paragraph on who you are and what you are practicing.

     ### Connect

     - [Email](mailto:jane@example.com)
     - [LinkedIn](https://linkedin.com/in/janedoe)
   ---

   ```

   - Mirror any additional optional fields you see in existing author cards to stay consistent.
2. Create your first Insight under `_insights/<year>/<your-slug>/`, e.g., `_insights/2025/jane-doe/2025-06-15-beginner-mind.md`:

   ```yaml
   ---
   layout: insight
   title: Your Insight Title
   title_mark: Optional short marker
   published_date: 2025-06-15
   refactored_date: 2025-06-15
   authors:
     - jane-doe
   forms:
     - threshold
   excerpt: |
     One or two sentences that invite the reader in.
   ---

   ```

   - Keep the tone reflective, practice-oriented, and Markdown-first.
3. Commit and push; GitHub Pages will render your author card and publish your Insight on the next build.

### Preview in Codespaces

Run the site directly in your Codespace:

```bash
bundle install
bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload
```

- Forward port 4000 in the Ports tab and open it in the browser to view the site.

### Local preview (optional)

If you prefer to preview locally:

```bash
bundle install
bundle exec jekyll serve
```

- Requires Ruby and Bundler. If you use `rbenv` or `asdf`, align with the version pinned in `Gemfile.lock`.
- Preview is served at <http://localhost:4000>.

### Project anatomy

- `_authors/` author cards
- `_insights/` Insight articles by year/author
- `_layouts/` page templates and `_includes/` shared components
- `_data/` structured site data
- `mission.md` front matter for the home (mission) landing page

### Community norms

- Small, focused pull requests make review easy.
- Be direct, respectful, and mission-aligned: reflective, practice-ready, and action-oriented.
- See [LICENSE](LICENSE.md) for reuse expectations.

### Engage

- ⛩️ <https://mindset.dojo.center>
