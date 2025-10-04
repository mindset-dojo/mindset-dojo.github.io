---
layout: default
title: Don't Hoard. Share.
h1_mark: Project
h1_hr: true
css_id: project
---
{% assign project = site.data.project %}
{% assign program = site.data.program %}

<section>
  <h2>{{ project.mantra }}</h2>
  <br>
  <p>
    {{ project.context.intro_lines | join: '<br>' }}
  </p>
  <p>
    {{ project.context.scenario_lines | join: '<br>' }}
  </p>
  <ul>
    {% for item in project.context.why_we_build %}
      <li>{{ item }}</li>
    {% endfor %}
  </ul>
</section>

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
  <ul class="md-pill-list">
    {% for p in project.principles %}
      <li>{{ p.label }}</li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>Leadership Designations</h2>
  <br>
  {% for designation in project.designations %}
    <div class="md-designation">
      <h3>{{ designation.label }}</h3>
      <ul>
        <p><strong>Intention</strong></p>
        <li>{{ designation.intention }}</li>
        <br>
        <p><strong>Aspects</strong></p>
        {% for item in designation.aspects %}
          <li>{{ item.label }}</li>
        {% endfor %}
      </ul>
    </div>
  {% endfor %}
</section>

<div class="md-cta-group">
  <a href="{{ site.repo_url }}">GitHub Project</a>
</div>
