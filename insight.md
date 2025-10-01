---
layout: default
title: Insight
h1_mark: Insight Stream
h1_hr: true
css_id: insight
---

<section id="insights-phonebook">
  <h2>Insights — Index (Phonebook)</h2>
  {% assign phonebook = site.data.insight.insights | sort: 'full_name' %}
  <ul class="insights-phonebook-list">
    {% for item in phonebook %}
      {% assign post_match = site.posts | where: "slug", item.slug | first %}

      {%- comment -%}
      Resolve image and alt by preferring post front-matter, otherwise falling back to data file.
      {%- endcomment -%}
      {% if post_match %}
        {% assign resolved_image = post_match.image | default: item.image %}
        {% assign resolved_alt   = post_match.image_alt | default: item.image_alt %}
      {% else %}
        {% assign resolved_image = item.image %}
        {% assign resolved_alt   = item.image_alt %}
      {% endif %}

      <li class="insights-phonebook-item">
        {% if resolved_image %}
          <a href="{{ '/insight/' | post_match.url | default: item.permalink | relative_url }}">
            <img
              src="{{ resolved_image | relative_url }}"
              alt="{{ resolved_alt | default: item.title | escape }}"
              loading="lazy"
              class="insight-thumb"
              aria-hidden="false"
            >
          </a>
        {% endif %}

        <div class="insight-phonebook-meta">
          <a href="{{ post_match.url | default: item.permalink | relative_url }}">
            {{ item.full_name | default: item.title }}
          </a>
          {% if item.author %} — {{ item.author }}{% endif %}
          {% if item.date %}<small> ({{ item.date }})</small>{% endif %}
        </div>
      </li>
    {% endfor %}
  </ul>
</section>

<hr>

<section id="insights-stream">
  <h2>Insight Stream (Newest → Oldest)</h2>

  {%- comment -%}
  Recommended workflow:
  - Tag posts intended to appear in the Insight Stream with `insight` in front matter.
  - If no posts have that tag, the fallback below will render all site.posts (newest → oldest).
  {%- endcomment -%}

  {% assign insight_posts = site.posts | where_exp: "post", "post.tags contains 'insight'" %}

  {% if insight_posts == empty %}
    {% assign insight_posts = site.posts %}
  {% endif %}

  {% for post in insight_posts %}
    {%- comment -%}
    Try to find a matching phonebook entry for additional metadata (e.g., image_alt) if post front-matter is missing.
    {%- endcomment -%}
    {% assign phonebook_entry = site.data.insight.insights | where: "slug", post.slug | first %}

    {% assign img_src = post.image | default: phonebook_entry.image %}
    {% assign img_alt = post.image_alt | default: phonebook_entry.image_alt | default: post.title %}

    <article class="insight-item">
      {% if img_src %}
        <a href="{{ post.url | relative_url }}">
          <img
            src="{{ img_src | relative_url }}"
            alt="{{ img_alt | escape }}"
            loading="lazy"
            class="insight-hero"
            aria-hidden="false"
          >
        </a>
      {% endif %}

      <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      <p class="meta">By {{ post.author | default: site.author }} — {{ post.date | date: "%b %-d, %Y" }}</p>
      <div class="excerpt">
        {{ post.excerpt | default: post.content | strip_html | truncate: 220 }}
      </div>
      <p class="tags">
        {% for tag in post.tags %}
          <a href="{{ '/tag/' | append: tag | slugify | append: '/' | relative_url }}" class="tag">{{ tag }}</a>{% unless forloop.last %}, {% endunless %}
        {% endfor %}
      </p>
    </article>
    <hr>
  {% endfor %}
</section>
