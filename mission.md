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

<section class="md-flow">
  {% for item in context.scenario_lines %}
  <p>{{ item }}</p>
  {% endfor %}

  <br/>

  <blockquote><strong>{{ context.pullquote }}</strong></blockquote>
</section>

<section class="md-flow">
  <h2>{{ context.why_we_train_label }}</h2>
  <br>
  {% for item in context.why_we_train %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>{{ mission.rally }}{{ context.mission_rally_suffix_label }}</h2>
  <br>
  {% for item in mission.statement %}
  <p>{{ item }}</p>
  {% endfor %}

  <hr/>

  {% for item in context.practice_bullets %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>{{ context.energy.label }}</h2>
  <br>
  {% for line in context.energy.items %}
  <p>{{ line }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>{{ context.leadership_flow.label }}</h2>
</section>

{% include authors-grid.html %}

{% include cta-group.html ctas=context.calls_to_action %}