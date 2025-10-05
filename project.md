---
layout: default
title: Don't Hoard. Share.
h1_mark: Share.
h1_hr: true
permalink: /project/
css_id: project
---

{% assign mission = site.data.mission %}
{% assign project = site.data.project %}
{% assign context = project.context %}

<section class="md-flow">
  <h2>{{ mission.rally }}{{ context.mission_rally_suffix_label }}</h2>
  {% for item in mission.statement %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>{{ context.project_motivations_label }} </h2>
  {% for item in context.project_motivations %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>{{ context.contribution_motivations_label }}</h2>
  {% for item in context.contribution_motivations %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <h2>{{ context.contribution_invitations_label }}</h2>
  {% for item in context.contribution_invitations %}
  <p>{{ item }}</p>
  {% endfor %}
</section>

<section class="md-flow">
  <blockquote><strong>{{ context.pullquote }}</strong></blockquote>
</section>

<section class="md-flow">
  <h2>{{ context.designations_label }}</h2>
  {% for designation in project.designations %}
  <br>
  <br>
  <h3>{{ designation.label }}</h3>
  <p><strong>{{ context.designations_intention_label }}</strong></p> <p>{{ designation.intention }}</p>
  <p><strong>{{ context.designations_aspects_label }}</strong></p>
    {% for item in designation.aspects %}
  <p>{{ item.label }}</p>
    {% endfor %}
  {% endfor %}
</section>

<section class="md-flow">
  <h2>{{ context.leadership_flow.label }}</h2>
</section>

{% include authors-grid.html %}

{% include cta-group.html ctas=context.calls_to_action %}