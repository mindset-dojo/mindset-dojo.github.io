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
  - Lists all docs from the `insight` collection, newest first.
  - Author names resolved from the `authors` collection by slug in post.front-matter:
      authors: ["michael-basil", "kyle-ingersoll"]
  {%- endcomment -%}

  {% assign insight_posts = site.insight | sort: "date" | reverse %}
  {% if insight_posts == empty %}
    {% assign insight_posts = site.insight %}
  {% endif %}

  {% for post in insight_posts %}
    {%- comment -%} Resolve a safe slug (defensive) {%- endcomment -%}
    {% assign post_slug = post.slug %}
    {% if post_slug == nil or post_slug == "" %}
      {% assign segments = post.url | split: '/' %}
      {% assign last = segments | last %}
      {% if last == "" %}
        {% assign post_slug = segments[segments.size | minus: 2] %}
      {% else %}
        {% assign post_slug = last %}
      {% endif %}
    {% endif %}
    {% if post_slug == nil or post_slug == "" %}
      {% assign post_slug = post.title | slugify %}
    {% endif %}

    {%- comment -%} Build author display string from collection {%- endcomment -%}
    {% assign authors_names = "" | split: "," %}
    {% assign author_slugs = post.authors %}
    {% if author_slugs %}
      {% for slug in author_slugs %}
        {% assign doc = site.authors | where: "slug", slug | first %}
        {% if doc and doc.name %}
          {% assign authors_names = authors_names | push: doc.name %}
        {% endif %}
      {% endfor %}
    {% endif %}

    {% assign author_name_string = "" %}
    {% if authors_names.size == 0 %}
      {% assign author_name_string = site.author %}
    {% elsif authors_names.size == 1 %}
      {% assign author_name_string = authors_names[0] %}
    {% else %}
      {% assign last_index = authors_names.size | minus: 1 %}
      {% for name in authors_names %}
        {% assign author_name_string = author_name_string | append: name %}
        {% unless forloop.index0 == last_index %}
          {% assign author_name_string = author_name_string | append: " and " %}
        {% endunless %}
      {% endfor %}
    {% endif %}

    <article>
      <h3 class="title"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      <p class="meta">
        By {{ author_name_string | default: site.author }} — {{ post.date | date: "%b %-d, %Y" }}
      </p>
      <p class="excerpt">
        {{ post.excerpt | default: post.content | strip_html | truncate: 220 }}
      </p>
      <hr>
    </article>
  {% endfor %}
</section>
