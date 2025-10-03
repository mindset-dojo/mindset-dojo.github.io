---
layout: default
title: Don’t Complain. Train.
h1_mark: Train
h1_hr: true
description: A dojo for Fearless Leadership—bringing the gift of fearlessness (se-mu-i) into homes, classrooms, dojos, and boardrooms. We train mind, body, tone, and timing to cultivate presence under pressure.
css_id: home
---

{% assign program = site.data.program %}
{% assign homepage = program.homepage %}

<p>
  {{ homepage.intro_lines | join: '<br>' }}
</p>

<p>
  {{ homepage.scenario_lines | join: '<br>' }}
</p>

<blockquote><strong>{{ homepage.pullquote }}</strong></blockquote>

<h2>Why We Train</h2>
<ul>
  {% for item in homepage.why_we_train %}
    <li>{{ item }}</li>
  {% endfor %}
</ul>

<h2>{{ program.rally }} starts here</h2>

<p>{{ program.mission | newline_to_br }}</p>

<ul>
  {% for item in homepage.practice_bullets %}
    <li>{{ item }}</li>
  {% endfor %}
</ul>

<p><strong>{{ homepage.community_bridge }}</strong></p>

<div class="md-members">
  {%- assign profiles = site.data.members.profiles -%}
  {%- assign avatars  = site.data.members.avatars -%}
  {%- assign entries  = "" | split: "|" -%}

  {%- comment -%}
    1) Build sortable list of active members
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
  <a href="{{ '/program' | relative_url }}">{{ homepage.program_cta }}</a>
</div>
