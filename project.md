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

{% include mission-core.html mission=mission context=context %}

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

{% include designations.html designations=project.designations context=context %}

{% include authors-grid.html leadership_flow=context.leadership_flow designation_type="project" %}

{% include cta-group.html ctas=context.calls_to_action %}