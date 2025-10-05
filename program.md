---
layout: default
title: Don't React. Center.
h1_mark: Center.
h1_hr: true
permalink: /program/
css_id: program
---

{% assign mission = site.data.mission %}
{% assign program = site.data.program %}
{% assign context = program.context %}

<section class="md-flow">
  <h2>{{ mission.rally }}{{ context.mission_rally_suffix_label }}</h2>
  <br>
  {% for item in mission.statement %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>{{ context.principles_label }}</h2>
  <br>
  <ul>
    {% for item in program.principles %}
      <li>{{ item.label }}</li>
    {% endfor %}
  </ul>
</section>

<section class="md-flow">
  <h2>{{ context.forms_label }}</h2>
  <br>
  <ul>
    {% for item in program.forms %}
      <li><a href="{{ item.url }}" target="_blank">{{ item.label }}</a></li>
    {% endfor %}
  </ul>
</section>

<section class="md-flow">
  <h2>{{ context.levels_label }}</h2>
  {% for level in program.levels %}
      <br>
      <br>
      <h3>
      {% include icons/belt.svg
      class="md-belt-svg"
      color=level.color
      title=level.label %}
      </h3>
      <p><strong>{{ context.intention_label }}</strong></p> <p>{{ level.intention }}</p>
      <p><strong>{{ context.edge_label }}</strong></p> <p>{{ level.edge }}</p>
      <ul>
        <p><strong>{{ context.flows_label }}</strong></p>
        {% for item in level.flows %}
          <li><a href="{{ item.url }}" target="_blank">{{ item.label }}</a></li>
        {% endfor %}
      </ul>
  {% endfor %}
</section>

{% include designations.html designations=program.designations context=context %}

{% include authors-grid.html leadership_flow=context.leadership_flow %}

{% include cta-group.html ctas=context.calls_to_action %}