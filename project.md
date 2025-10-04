---
layout: default
title: Don't Hoard. Share.
h1_mark: Share
h1_hr: true
css_id: project
---
{% assign context = site.data.project.context %}
{% assign program = site.data.program %}
{% assign project = site.data.project %}

<p>
  {{ context.intro_lines | join: '<br>' }}
</p>

<p>
  {{ context.scenario_lines | join: '<br>' }}
</p>

{% if context.pullquote %}
<blockquote><strong>{{ context.pullquote }}</strong></blockquote>
{% endif %}

<h2>Why We Contribute</h2>
<ul>
  {% for item in context.why_we_contribute %}
    <li>{{ item }}</li>
  {% endfor %}
</ul>

<h2>{{ program.rally }} starts here</h2>
{% for item in program.mission %}
<p>{{ item }}</p>
{% endfor %}

<hr/>

<h2>Leadership Designations</h2>
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

<div class="md-cta-group">
  <a href="{{ site.repo_url }}">{{ context.project_cta }}</a>
</div>
