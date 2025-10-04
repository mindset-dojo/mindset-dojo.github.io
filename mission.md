---
layout: default
title: Don’t Complain. Train.
h1_mark: Train.
h1_hr: true
description: A dojo for Fearless Leadership—bringing the gift of fearlessness (se-mu-i) into homes, classrooms, dojos, and boardrooms. We train mind, body, tone, and timing to cultivate presence under pressure.
permalink: /
css_id: home
---

{% assign mission = site.data.mission %}
{% assign context = mission.context %}

<p>
  {{ context.intro_lines | join: '<br>' }}
</p>

<p>
  {{ context.scenario_lines | join: '<br>' }}
</p>

<blockquote><strong>{{ context.pullquote }}</strong></blockquote>

<h2>{{ context.why_we_train_label }}</h2>
<ul>
  {% for item in context.why_we_train %}
    <li>{{ item }}</li>
  {% endfor %}
</ul>

<h2>{{ mission.rally }} {{ context.mission_rally_suffix_label }}</h2>

  {% for item in mission.statement %}
  <p>{{ item }}</p>
  {% endfor %}

<hr/>

<ul>
  {% for item in context.practice_bullets %}
    <li>{{ item }}</li>
  {% endfor %}
</ul>

<p><strong>{{ context.investor_bridge }}</strong></p>

<div class="md-investors">
  {%- assign profiles = site.data.investors.profiles -%}
  {%- assign avatars  = site.data.investors.avatars -%}
  {%- assign entries  = "" | split: "|" -%}

  {%- comment -%}
    1) Build sortable list of active investors
       Format: [padded -belt]|[join_date]|[key]
  {%- endcomment -%}
  {% for pair in profiles %}
    {% assign key = pair[0] %}
    {% assign member = pair[1] %}
    {% if member.active %}
      {%- assign neg_belt = member.belt_level | times: -1 | plus: 1000 | prepend: "0000" | slice: -4, 4 -%}
      {% capture entry %}{{ neg_belt }}|{{ member.join_date }}|{{ key }}{% endcapture %}
      {% assign entries = entries | push: entry %}
    {% endif %}
  {% endfor %}

  {%- comment -%} 2) Sort by belt_level DESC, then join_date ASC {%- endcomment -%}
  {% assign sorted_entries = entries | sort %}

  {%- comment -%} 3) Render each profile card {%- endcomment -%}
  {% for entry in sorted_entries %}
    {% assign parts  = entry | split: "|" %}
    {% assign key    = parts[2] %}
    {% assign member = profiles[key] %}
    {% assign avatar = avatars[key] %}
    {% include member.html member=member avatar=avatar %}
  {% endfor %}
</div>

<div class="md-cta-group">
  <a href="{{ '/program' | relative_url }}">{{ context.program_call_to_action }}</a>
</div>
