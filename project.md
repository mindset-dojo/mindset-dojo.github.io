---
layout: default
title: Don't Hoard.  Share.
h1_mark: Share.
h1_hr: true
permalink: /project/
css_id: project
---

{% assign project = site.data.project %}
{% assign context = project.context %}
{% assign program = site.data.program %}

<section class="md-flow">
  <h2>Core Motivations </h2>
  {% for item in context.core_motivations %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>Why We Contribute</h2>
  {% for item in context.contribution_motivations %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>Contribution Invitations</h2>
  {% for item in context.contribution_invitations %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <blockquote><strong>{{ context.pullquote }}</strong></blockquote>
</section>

<section class="md-flow">
  <h2>{{ program.rally }} starts here</h2>
  {% for item in program.mission %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>Designations</h2>
  {% for designation in project.designations %}
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
  <a href="{{ site.repo_url }}">{{ context.repo_call_to_action }}</a>
</div>
