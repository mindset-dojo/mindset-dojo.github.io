---
layout: default
title: Don't Hoard.  Share.
h1_mark: Share.
h1_hr: true
css_id: project
---

{% assign project = site.data.project %}
{% assign context = project.context %}
{% assign program = site.data.program %}

<section>
  <h2>Our Core Motivations </h2>
  <ul>
    {% for item in context.core_motivations %}
      <li>{{ item }}</li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>Why We Contribute</h2>
  <ul>
    {% for item in context.contribution_motivations %}
      <li>{{ item }}</li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>Contribution Invitations</h2>
  <ul>
    {% for item in context.contribution_invitations %}
      <li>{{ item }}</li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>{{ program.rally }} starts here</h2>
  {% for item in program.mission %}
    <p>{{ item }}</p>
  {% endfor %}
</section>

<section>
  <h2>Designations</h2>
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
  <a href="{{ site.repo_url }}">{{ context.repo_call_to_action }}</a>
</div>
