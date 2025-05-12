---
layout: default
title: Mindset Dojo Conversational Leadership Program
description: Conversational Leadership Program
css_id: program
---
{% assign program = site.data.program %}

<section>
  <h1>{{ program.title }}</h1>
  <p><em>{{ program.mission }}</em></p>
</section>

<section>
  <h2>Principles</h2>
  <ul>
    {% for principle in program.principles %}
      <li>{{ principle.label }}</li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>Practices</h2>
  <h3>Reflection</h3>
  <ul>
    {% for item in program.practices[0].reflection %}
      <li>{{ item.label }}</li>
    {% endfor %}
  </ul>

  <h3>Forms</h3>
  <ul>
    {% for item in program.practices[1].forms %}
      <li><a href="{{ item.url }}" target="_blank">{{ item.label }}</a></li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>Awareness Dimensions</h2>
  <ul>
    {% for item in program.awareness %}
      <li>{{ item.label }}</li>
    {% endfor %}
  </ul>
</section>

<section>
  <h2>Community</h2>
  <p><a href="{{ program.community[0].url }}" target="_blank">Join the Community</a></p>
</section>

<section>
  <h2>Levels</h2>
  {% for level in program.levels %}
    <div style="border-left: 5px solid {{ level.color }}; padding-left: 1em; margin-bottom: 2em;">
      <h3>{{ level.label }} (Level {{ level.level }})</h3>
      <p><strong>Focus:</strong> {{ level.focus }}</p>
      <p><strong>Challenge:</strong> {{ level.challenge }}</p>
      <ul>
        {% for exercise in level.exercises %}
          <li><a href="{{ exercise.url }}" target="_blank">{{ exercise.label }}</a></li>
        {% endfor %}
      </ul>
    </div>
  {% endfor %}
</section>

