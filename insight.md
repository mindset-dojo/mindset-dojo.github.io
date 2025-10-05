---
layout: default
title: Don't Consume. Author.
h1_mark: Author.
h1_hr: true
css_id: insight
---

<section id="insights-stream">
  {%- comment -%}
  Stream behavior:
  - By default shows posts tagged "insight"; falls back to all posts if none.
  - Article URLs resolve to: /insight/<slug>/
  - Tag URLs resolve to: /insight/<tag-slug>/
  - Image handling supports data: URIs, path strings, or raw base64 (with optional page.image_mime).
  {%- endcomment -%}

  {% assign insight_posts = site.posts %}
  {% if insight_posts == empty %}
    {% assign insight_posts = site.posts %}
  {% endif %}

  {% for post in insight_posts %}
    {%- comment -%}
    Build a safe slug for the post:
      1) prefer post.slug
      2) fallback to last segment of post.url (handles /:year/:month/:day/slug/ or /slug/)
      3) final fallback to post.title | slugify
    {%- endcomment -%}
    {% assign post_slug = post.slug %}
    {% if post_slug == nil or post_slug == "" %}
      {% assign segments = post.url | split: '/' %}
      {% assign last = segments | last %}
      {% if last == "" %}
        {% comment %} url ended with a slash; take the second-to-last segment {% endcomment %}
        {% assign post_slug = segments[segments.size | minus: 2] %}
      {% else %}
        {% assign post_slug = last %}
      {% endif %}
    {% endif %}
    {% if post_slug == nil or post_slug == "" %}
      {% assign post_slug = post.title | slugify %}
    {% endif %}

    {%- comment -%}
    Construct final post URL under the /insight/ directory and make it baseurl-safe.
    {%- endcomment -%}
    {% assign post_url = '/insight/' | append: post_slug | append: '/' | relative_url %}

      <h3>
        <a href="{{ post_url }}">{{ post.title }}</a>
      </h3>

      <p class="meta">By {{ post.author | default: site.author }} — {{ post.date | date: "%b %-d, %Y" }}</p>
      
      {%- comment -%}
      Insert image at bottom
      {%- endcomment -%}
      {% assign post_slug = post.slug | default: post.title | slugify %}
      {% assign post_date = post.date | default: "2025-01-01" | date: "%Y-%m-%d" | slugify %}

      {% if post.image_extension %}
        {% assign img_path = "/media/images/" | append: post_date | append: "-" | append: post_slug | append: "." | append: post.image_extension %}
        <img src="{{ img_path | relative_url }}" alt="{{ post.image_alt | default: post.title | escape }}" class="insight-thumb" loading="lazy">
      {% endif %}
      
      <div class="excerpt">
        {{ post.excerpt | default: post.content | strip_html | truncate: 220 }}
      </div>
    <hr>
  {% endfor %}
</section>
