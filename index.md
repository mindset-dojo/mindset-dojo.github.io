---
layout: default
title: Don’t Complain. Train.
description: Mindset Dojo is a global training ground for the inner game of presence, leadership, and emotional clarity. For conversations that matter—across all life arenas.
css_id: home
---

<h1>Don’t Complain. <mark>Train.</mark></h1>
<hr>

<p>When the pressure hits, you don’t rise to the level of your best intentions.<br>
You fall to the level of your practice.</p>

<p>In the middle of a hard conversation…<br>
When trust is on the line…<br>
In that flash between stimulus and response…</p>

<blockquote><strong>Your body leads, not your bullet points.</strong></blockquote>

<p>That’s why we train.</p>

<p>Not to collect more insight—<br>
But to move differently, when it counts.</p>

<blockquote><strong>Transitions call not for insight, but for training the emerging new self.</strong></blockquote>

<p>We call this base practice <strong>Self-distillation</strong>: a practice of tuning in and refining how you show up—especially under pressure—by trusting what’s already alive inside you.</p>

<h2>How We Train</h2>
<ul>
  <li>🥋 We <strong>role play in dynamic conversations</strong>—live and online via <strong>Jitsi Meet</strong>—where pressure, emotion, and timing are real.</li>
  <li>🔁 We <strong>reflect and recalibrate asynchronously</strong> through <strong>Signal</strong> voice notes.</li>
  <li>🌀 We <strong>stay in rhythm</strong>—through practice, not performance.</li>
  <li>🧭 We <strong>train with static flips and dynamic moves</strong>, using simple, powerful perception tools that reveal what’s usually unconscious.</li>
  <li>🎯 We commit to a <strong>belt-leveled program</strong> inspired by <strong>Zen and Aikido</strong>, with embodied thresholds and meaningful progression.</li>
</ul>

<p>This isn’t theory.<br>
It’s not therapy.<br>
It’s not just coaching.</p>

<blockquote><strong>It’s training for any and all life arenas—through conversations that matter.</strong></blockquote>

<p><strong>⛩️ Get on the Mat.</strong></p>

<div class="md-members">
{% assign members = "" | split: "" %}
{% for member in site.data.members %}
	{% unless member[1].active %}{% continue %}{% endunless %}
	{% assign members = members | push: member[1] %}
{% endfor %}
{% assign sorted_levels = site.data.program.levels | sort: "level" | reverse %}
{% for level in sorted_levels %}
	{% assign level_members = members | where: "belt_level", level.level" %}
	{% assign level_members = level_members | sort: "join_date" %}
	{% for member in level_members %}
	<section>
		<img src="{{member.profile_picture}}" width="100" height="100" alt="{{ member.name }}" />
		<h2>{{ member.name }}</h2>
		{% if member.linkedin or member.belt_level %}
		<div class="md-group">
			{% if member.linkedin %}
			<a href="{{ member.linkedin }}" target="_blank" aria-label="LinkedIn">
				<svg class="md-icon-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 40 40"><path d="M20,1.5c10.2,0,18.5,8.3,18.5,18.5s-8.3,18.5-18.5,18.5S1.5,30.2,1.5,20,9.8,1.5,20,1.5ZM20,0C9,0,0,9,0,20s9,20,20,20,20-9,20-20S31,0,20,0ZM16.7,13.3c0,.9-.7,1.7-1.7,1.7s-1.7-.7-1.7-1.7.7-1.7,1.7-1.7,1.7.8,1.7,1.7ZM16.7,16.7h-3.3v10h3.3v-10ZM21.7,16.7h-3.3v10h3.3v-4.8c0-2.9,3.3-3.1,3.3,0v4.8h3.3v-5.6c0-5.5-5.2-5.3-6.7-2.6,0,0,0-1.8,0-1.8Z"/></svg>
			</a>
			{% endif %}
			{% if member.belt_level %}
			<svg class="md-belt-svg {{ level.color }}" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 500 200"><title>{{ level.label }}</title><path class="st3" d="M202.6,53.8s-1.5,5,.2,7.4,24.9,1.8,24.9,1.8l-11.3-10.2-13.8,1.1h0Z"/><path class="st4" d="M20.4,30.9s119.2,32.1,233.8,32.1S468.9,11.8,472.7,9.5c3.8-2.3,13,39,.8,48.1-12.2,9.2-81,48.9-216.2,48.9S24.3,85.1,17.4,77.5s-6.9-38.2,3.1-46.6h-.1Z"/><path class="st0" d="M262.6,134s-22.2-6.1-28.3-21.4,58.8-29.8,58.8-29.8l-6.1,31.3-24.4,19.9h0Z"/><path class="st4" d="M206.1,110.4s30.6,21.4,35.1,19.1c4.6-2.3,58.8-36.7,58.8-36.7l-45.8-33.6-50.4,38.2,2.3,13h0Z"/><path class="st4" d="M33.4,160s125.3-76.4,200.9-107c75.6-30.6,30.6,29,30.6,29,0,0-78.7,38.2-110.8,57.3-32.1,19.1-81.7,50.4-87.9,51.2-6.1.8-32.9-30.6-32.9-30.6h.1Z"/><path class="st3" d="M266.6,35s-5.3-1.9-14.1,8.5c-8.9,10.3,15.1,8.2,15.1,8.2l-.9-16.7h-.1Z"/><path class="st1" d="M242.8,36.2s94.7,49.7,127.6,60.4c32.9,10.7,113.8,46.6,116.9,55.8s-27.5,30.6-27.5,30.6c0,0-23.7-21.4-54.2-34.4-30.6-13-83.3-34.4-112.3-48.1-29-13.8-89.4-47.4-89.4-47.4l39-16.8h0Z"/><path class="st2" d="M266.4,35.5s-2.3,92.4-4.6,97c-2.3,4.6,42.8-13,43.5-18.3.8-5.3,6.9-50.4,2.3-55s-36.7-26-41.3-23.7h.1Z"/></svg>
			{% endif %}
		</div>
		{% endif %}
		{% if member.links %}
		<ul>
			{% for link in member.links %}
			<li><a href="{{ link.url }}">{{ link.label }}</a></li>
			{% endfor %}
		</ul>
		{% endif %}
	</section>
	{% endfor %}
{% endfor %}
</div>

<div class="md-cta-group">
    <a href="./program">Open Source Program</a>
</div>
