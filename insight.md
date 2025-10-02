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
  - Stream posts tagged "insight" by default; falls back to all posts if none.
  - Links are generated as: /insight/<slug>/  (use relative_url to respect baseurl)
  - Tag links are generated as: /insight/<tag-slug>/ 
  {%- endcomment -%}

  {% assign insight_posts = site.posts | where_exp: "post", "post.tags contains 'insight'" %}
  {% if insight_posts == empty %}
    {% assign insight_posts = site.posts %}
  {% endif %}

  {% for post in insight_posts %}
    {%- comment -%}
    Build a usable URL.
    {%- endcomment -%}
    {% assign post_url = post.permalink | relative_url %}

    {%- comment -%}
    Resolve image src (supports data: URIs, path strings, or raw base64).
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
        <a href="{{ '/insight/' | append: post_url | append: '/' | relative_url }}">
          <img
            src="{{ img_src }}"
            alt="{{ post.image_alt | default: post.title | escape }}"
            loading="lazy"
            class="insight-hero"
          >
        </a>
      {%- endif -%}

      <h3>
        <a href="{{ '/insight/' | append: post_url | append: '/' | relative_url }}">
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
