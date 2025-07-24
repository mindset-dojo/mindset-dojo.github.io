---
layout: default
title: Don’t Complain. Train.
description: Mindset Dojo is a global training ground for the inner game of presence, leadership, and emotional clarity. For conversations that matter—across all life arenas.
css_id: home
---

<h1>Don’t Complain. <mark>Train.</mark></h1>
<hr>

<p>When the pressure hits, you don’t rise to the level of your best intentions.<br>
You fall to the level of your practice.</p>

<p>In the middle of a hard conversation…<br>
When trust is on the line…<br>
In that flash between stimulus and response…</p>

<blockquote><strong>Your body leads, not your bullet points.</strong></blockquote>

<p>That’s why we train.</p>

<p>Not to collect more insight—<br>
But to move differently, when it counts.</p>

<blockquote><strong>Transitions call not for insight, but for training the emerging new self.</strong></blockquote>

<h2>How We Train</h2>
<ul>
  <li>🥋 We <strong>role play in dynamic conversations</strong>—live and online via <strong>Jitsi Meet</strong>—where pressure, emotion, and timing are real.</li>
  <li>🔁 We <strong>reflect and recalibrate asynchronously</strong> through <strong>Signal</strong> voice notes.</li>
  <li>🌀 We <strong>stay in rhythm</strong>—through practice, not performance.</li>
  <li>🧭 We <strong>train with static flips and dynamic moves</strong>, using simple, powerful perception tools that reveal what’s usually unconscious.</li>
  <li>🎯 We commit to a <strong>belt-leveled program</strong> inspired by <strong>Zen and Aikido</strong>, with embodied thresholds and meaningful progression.</li>
</ul>

<p>This isn’t theory.<br>
It’s not therapy.<br>
It’s not just coaching.</p>

<blockquote><strong>It’s training for any and all life arenas—through conversations that matter.</strong></blockquote>

<p><strong>⛩️ Get on the Mat.</strong></p>

<div class="md-members">

  {% assign profiles = site.data.members.profiles %}
  {% assign slugs = profiles | keys %}
  {% assign sorted_levels = site.data.program.levels | sort: "level" | reverse %}

  {% for level in sorted_levels %}
    {% assign level_members = "" | split: "|" %}

    {% for slug in slugs %}
      {% assign member = profiles[slug] %}
      {% if member.active and member.belt_level | plus:0 == level.level | plus:0 %}
        {% capture entry %}{{ member.join_date }}|{{ slug }}{% endcapture %}
        {% assign level_members = level_members | push: entry %}
      {% endif %}
    {% endfor %}

    {% assign level_members = level_members | sort %}

    {% if level_members != empty %}
      <h2>{{ level.label }}</h2>
      {% for entry in level_members %}
        {% assign parts = entry | split: "|" %}
        {% assign slug = parts[1] %}
        {% assign member = profiles[slug] %}
        {% include member.html member=member slug=slug %}
      {% endfor %}
    {% endif %}
  {% endfor %}
</div>






<div class="md-cta-group">
    <a href="./program">Open Source Program</a>
</div>
