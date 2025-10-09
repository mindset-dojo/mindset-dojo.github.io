---
layout: default
title: Don't Absorb. Author.
h1_mark: Author.
css_id: insight
permalink: /insight/
---

<section id="insights-stream">
  {%- comment -%}
  Stream behavior:
  - By default shows insight posts tagged "insight"; falls back to all insight posts if none.
  - Article URLs resolve to: /insight/<slug>/
  - Tag URLs resolve to: /insight/<tag-slug>/
  - Image handling supports data: URIs, path strings, or raw base64 (with optional page.image_mime).
  {%- endcomment -%}

  {% assign insight_posts = site.insight | sort: "date" | reverse %}
  {% if insight_posts == empty %}
    {% assign insight_posts = site.insight %}
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
        {% comment %} URL ended with a slash; take the second-to-last segment {% endcomment %}
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

      <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>

      {% assign author_slugs = post.authors %}
      {% assign authors_names = "" | split: "," %}

      {% for slug in author_slugs %}
        {% for key in site.data.authors %}
          {% assign profile = site.data.authors[key] %}
          {% if slug == key %}
            {% assign authors_names = authors_names | push: profile.name %}
            {% break %}
          {% endif %}
        {% endfor %}
      {% endfor %}

      {% assign author_name_string = "" %}

      {% if authors_names.size == 0 %}
        {% assign author_name_string = site.author %}
      {% elsif authors_names.size == 1 %}
        {% assign author_name_string = authors_names[0] %}
      {% else %}
        {% assign author_count = 0 %}
        {% assign last_index = authors_names.size | minus: 1 %}
        {% for name in authors_names %}
          {% assign author_name_string = author_name_string | append: name %}
          {% if author_count < last_index %}
            {% assign author_name_string = author_name_string | append: " and " %}
          {% endif %}
          {% assign author_count = author_count | plus: 1 %}
        {% endfor %}
      {% endif %}

      <p class="meta">
        By {{ author_name_string | default: site.author }} — {{ post.date | date: "%b %-d, %Y" }}
      </p>
      
      {% assign post_slug = post.slug | default: post.title | slugify %}
      {% assign post_date = post.date | default: "2025-01-01" | date: "%Y-%m-%d" | slugify %}
      
      <div class="excerpt">
        {{ post.excerpt | default: post.content | strip_html | truncate: 220 }}
      </div>
    <hr>
  {% endfor %}
</section>
