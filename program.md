---
layout: default
title: Conversational Leadership Program
description: Conversational Leadership Program
css_id: program
---
{% assign program = site.data.program %}

<section>
  <h1>Program <hr> </h1>
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
      {% if level.level > -7 %}
      <hr>
      {% endif %}
      <h3> {% if level.level %}
			<svg class="md-belt-svg {{ level.color }}" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 500 200"><path class="st3" d="M202.6,53.8s-1.5,5,.2,7.4,24.9,1.8,24.9,1.8l-11.3-10.2-13.8,1.1h0Z"/><path class="st4" d="M20.4,30.9s119.2,32.1,233.8,32.1S468.9,11.8,472.7,9.5c3.8-2.3,13,39,.8,48.1-12.2,9.2-81,48.9-216.2,48.9S24.3,85.1,17.4,77.5s-6.9-38.2,3.1-46.6h-.1Z"/><path class="st0" d="M262.6,134s-22.2-6.1-28.3-21.4,58.8-29.8,58.8-29.8l-6.1,31.3-24.4,19.9h0Z"/><path class="st4" d="M206.1,110.4s30.6,21.4,35.1,19.1c4.6-2.3,58.8-36.7,58.8-36.7l-45.8-33.6-50.4,38.2,2.3,13h0Z"/><path class="st4" d="M33.4,160s125.3-76.4,200.9-107c75.6-30.6,30.6,29,30.6,29,0,0-78.7,38.2-110.8,57.3-32.1,19.1-81.7,50.4-87.9,51.2-6.1.8-32.9-30.6-32.9-30.6h.1Z"/><path class="st3" d="M266.6,35s-5.3-1.9-14.1,8.5c-8.9,10.3,15.1,8.2,15.1,8.2l-.9-16.7h-.1Z"/><path class="st1" d="M242.8,36.2s94.7,49.7,127.6,60.4c32.9,10.7,113.8,46.6,116.9,55.8s-27.5,30.6-27.5,30.6c0,0-23.7-21.4-54.2-34.4-30.6-13-83.3-34.4-112.3-48.1-29-13.8-89.4-47.4-89.4-47.4l39-16.8h0Z"/><path class="st2" d="M266.4,35.5s-2.3,92.4-4.6,97c-2.3,4.6,42.8-13,43.5-18.3.8-5.3,6.9-50.4,2.3-55s-36.7-26-41.3-23.7h.1Z"/></svg>
			{% endif %} {{ level.label }} </h3>
      <p><strong>Focus:</strong> {{ level.focus }}</p>
      <p><strong>Challenge:</strong> {{ level.challenge }}</p>
      <ul>
        {% for exercise in level.exercises %}
          <li><a href="{{ exercise.url }}" target="_blank">{{ exercise.label }}</a></li>
        {% endfor %}
      </ul>
  {% endfor %}
</section>

