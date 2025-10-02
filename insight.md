---
layout: default
title: Insight
h1_mark: Insight Stream
h1_hr: true
css_id: insight
---

<section id="insights-stream">
  <h2>Insight Stream (Newest → Oldest)</h2>

  {%- comment -%}
  Stream behavior:
  - By default shows posts tagged "insight"; falls back to all posts if none.
  - Article URLs resolve to: /insight/<slug>/
  - Tag URLs resolve to: /insight/<tag-slug>/
  - Image handling supports data: URIs, path strings, or raw base64 (with optional page.image_mime).
  {%- endcomment -%}

  {% assign insight_posts = site.posts | where_exp: "post", "post.tags contains 'insight'" %}
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

    {%- comment -%}
    Resolve image src (supports:
      - data: URIs (used as-is),
      - strings containing "base64," (used as-is),
      - filesystem/asset paths (passed through relative_url),
      - raw base64 (prepends data:<mime>;base64, using page.image_mime or default image/jpeg)
    ) 
    {%- endcomment -%}
    {% assign raw_img = post.image | default: "" | strip %}
    {% if raw_img != "" %}
      {% if raw_img contains "data:" %}
        {% assign img_src = raw_img %}
      {% elsif raw_img contains "base64," %}
        {% assign img_src = raw_img %}
      {% elsif raw_img contains "/" or raw_img contains "." %}
        {% assign img_src = raw_img | relative_url %}
      {% else %}
        {% assign img_mime = post.image_mime | default: "image/jpeg" %}
        {% assign img_src = "data:" | append: img_mime | append: ";base64," | append: raw_img %}
      {% endif %}
    {% else %}
      {% assign img_src = "" %}
    {% endif %}

    <article class="insight-item">
      {%- if img_src != "" -%}
        <a href="{{ post_url }}">
          <img
            src="{{ img_src }}"
            alt="{{ post.image_alt | default: post.title | escape }}"
            loading="lazy"
            class="insight-hero"
          >
        </a>
      {%- endif -%}

      <h3>
        <a href="{{ post_url }}">
          {{ post.title }}
        </a>
      </h3>

      <p class="meta">By {{ post.author | default: site.author }} — {{ post.date | date: "%b %-d, %Y" }}</p>

      <div class="excerpt">
        {{ post.excerpt | default: post.content | strip_html | truncate: 220 }}
      </div>

      {% if post.tags %}
        <p class="tags">
          {% for tag in post.tags %}
            <a href="{{ '/insight/' | append: tag | slugify | append: '/' | relative_url }}" class="tag">{{ tag }}</a>{% unless forloop.last %}, {% endunless %}
          {% endfor %}
        </p>
      {% endif %}
    </article>

    <hr>
  {% endfor %}
</section>
