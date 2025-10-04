---
layout: default
title: Don't React. Center.
h1_mark: Center.
h1_hr: true
css_id: program
---
{% assign program = site.data.program %}
{% assign context = program.context %}

<section>
  <h2>{{ program.rally }}</h2>
  <br>
  {% for item in program.mission %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section>
  <h2>Principles</h2>
  <br>
  <ul>
    {% for item in program.principles %}
      <li>{{ item.label }}</li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>Forms</h2>
  <br>
  <ul>
    {% for item in program.forms %}
      <li><a href="{{ item.url }}" target="_blank">{{ item.label }}</a></li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>Levels</h2>
  {% for level in program.levels %}
      <br>
      <br>
      <h3>
      {% include icons/belt.svg
      class="md-belt-svg"
      color=level.color
      title=level.label %}
      </h3>
      <p><strong>Intention</strong></p> <p>{{ level.intention }}</p>
      <p><strong>Edge</strong></p> <p>{{ level.edge }}</p>
      <ul>
        <p><strong>Flows</strong></p>
        {% for item in level.flows %}
          <li><a href="{{ item.url }}" target="_blank">{{ item.label }}</a></li>
        {% endfor %}
      </ul>
  {% endfor %}
</section>

<section>
  <h2>Designations</h2>
  {% for designation in program.designations %}
  <br>
  <br>
  <h3>{{ designation.label }}</h3>
  <p><strong>Intention</strong></p> <p>{{ designation.intention }}</p>
  <p><strong>Aspects</strong></p>
    {% for item in designation.aspects %}
  <p>{{ item.label }}</p>
    {% endfor %}
  {% endfor %}
</section>

<div class="md-cta-group">
    <a href="{{'/' | relative_url }}">{{ context.mission_call_to_action }}</a>
</div>
