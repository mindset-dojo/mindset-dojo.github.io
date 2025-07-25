---
layout: default
title: Don’t Complain. Train.
description: Mindset Dojo is a global training ground for the inner game of presence, leadership, and emotional clarity. For conversations that matter—across all life arenas.
css_id: home
---

<h1>Don’t Complain. <mark>Train.</mark></h1>
<hr>

<p>When the pressure hits, you don’t rise to the level of your best intentions.<br>
You reveal the level of your conditioning.</p>

<p>In the middle of a hard conversation…<br>
When trust is on the line…<br>
In that flash between stimulus and response…</p>

<blockquote><strong>The body speaks, not the polished script.</strong></blockquote>

<h2>Why We Train</h2>
<ul>
  <li>🧠 Because awareness isn’t enough — you can name the pattern and still fall into it.</li>
  <li>⏱️ Because in high-stakes moments, you won’t have time to think — only time to respond.</li>
  <li>🤼 Because pressure doesn’t reveal your potential — it reveals your practice.</li>
</ul>

<h2>How We Train</h2>
<ul>
  <li>🥋 We practice live, in real conversations — where timing, tone, and tension are felt.</li>
  <li>🔁 We reflect between reps — using voice notes to recalibrate and deepen awareness.</li>
  <li>🎯 We progress with purpose — using a belt path that honors embodied thresholds.</li>
</ul>

<p>This isn’t theory.<br>
It’s not therapy.<br>
It’s not just coaching.</p>

<blockquote><strong>It’s training for any and all life arenas—through conversations that matter.</strong></blockquote>

<p><strong>⛩️ Get on the Mat.</strong></p>

<div class="md-members">

  {%- comment -%}
    1. Get all [slug, member] pairs from flattened YAMLs
  {%- endcomment -%}
  {% assign all_profiles = site.data.members.profiles %}
  {% assign active_entries = "" | split: "|" %}

  {%- comment -%}
    2. Filter for active members, capture belt_level & join_date for sorting
       - We negate belt_level and pad so higher ranks appear first (e.g., -1 → 1001)
  {%- endcomment -%}
  {% for pair in all_profiles %}
    {% assign slug = pair[0] %}
    {% assign member = pair[1] %}

    {% if member.active %}
      {%- assign neg_belt = member.belt_level | times: -1 | plus: 1000 | prepend: "0000" | slice: -4, 4 -%}
      {% capture entry %}{{ neg_belt }}|{{ member.join_date }}|{{ slug }}{% endcapture %}
      {% assign active_entries = active_entries | push: entry %}
    {% endif %}
  {% endfor %}

  {%- comment -%}
    3. Sort by belt_level DESC (negated), then join_date ASC
  {%- endcomment -%}
  {% assign sorted_entries = active_entries | sort %}

  {%- comment -%}
    4. Render each member card
  {%- endcomment -%}
  {% for entry in sorted_entries %}
    {% assign parts = entry | split: "|" %}
    {% assign slug = parts[2] %}
    {% assign member = all_profiles[slug] %}
    {% include member.html member=member slug=slug %}
  {% endfor %}

</div>



<div class="md-cta-group">
    <a href="./program">Open Source Program</a>
</div>
