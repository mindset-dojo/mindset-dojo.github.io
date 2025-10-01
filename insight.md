---
layout: default
title: Insight
permalink: /insight/
---

<section id="insights-phonebook">
  <h2>Insights — Index (Phonebook)</h2>
  {% assign phonebook = site.data.insight.insights | sort: 'full_name' %}
  <ul>
    {% for item in phonebook %}
      {% assign post_match = site.posts | where: "slug", item.slug | first %}
      <li>
        <a href="{{ post_match.url | default: item.permalink | relative_url }}">
          {{ item.full_name | default: item.title }}
        </a>
        {% if item.author %} — {{ item.author }}{% endif %}
        {% if item.date %}<small> ({{ item.date }})</small>{% endif %}
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
    <article class="insight-item">
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
