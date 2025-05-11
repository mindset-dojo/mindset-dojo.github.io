---
layout: default
title: Join the Mindset Dojo Community for Intentional Conversations
description: Explore the practice of intentional conversations in the Mindset Dojo community. Develop Mindset Intelligence to see clearly, act decisively, and build trust. Join leaders and individuals who value personal growth, relational excellence, and systems thinking.
css_id: community
---

<h1>Community</h1>
<hr>
<p>Our community is dedicated to the practice of intentional conversations. Here, we explore and develop <strong>Mindset Intelligence</strong>—the art of seeing clearly, acting decisively, and building trust. Our conversations dive into deeply interesting, often charged topics in a way that not only avoids eroding trust but actively strengthens it. Through mindful dialogue, we transcend the need for agreement, thus transforming contrast, and even conflict, into insight and connection.</p>
<p>This group is a space for leaders, professionals, and individuals committed to <strong>personal growth</strong>, <strong>relational excellence</strong>, and <strong>systems thinking</strong>. It’s designed for those who value confidentiality, connection, and thoughtful engagement as we practice navigating complexity and building trust through intentional conversation.</p>
<a href="{{site.connect_url}}" target="_blank">Schedule an Exploratory Call</a>
<div class="md-members">
	{% assign members = "" | split: "" %}
	{% for member in site.data.members %}
		{% assign members = members | push: member[1] %}
	{% endfor %}
	{% assign members = members | sort: "join_date" | reverse %}
	{% assign members = members | sort: "belt_level" %}
	{% assign members = members | reverse %}
	{% for member in members %}
	{% unless member.active %}{% continue %}{% endunless %}
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
			  {% assign level_info = site.data.program.levels | where: "level", member.belt_level | first %}
			<svg class="md-belt-svg {{ level_info.color }}" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 500 200"><path class="st3" d="M202.6,53.8s-1.5,5,.2,7.4,24.9,1.8,24.9,1.8l-11.3-10.2-13.8,1.1h0Z"/><path class="st4" d="M20.4,30.9s119.2,32.1,233.8,32.1S468.9,11.8,472.7,9.5c3.8-2.3,13,39,.8,48.1-12.2,9.2-81,48.9-216.2,48.9S24.3,85.1,17.4,77.5s-6.9-38.2,3.1-46.6h-.1Z"/><path class="st0" d="M262.6,134s-22.2-6.1-28.3-21.4,58.8-29.8,58.8-29.8l-6.1,31.3-24.4,19.9h0Z"/><path class="st4" d="M206.1,110.4s30.6,21.4,35.1,19.1c4.6-2.3,58.8-36.7,58.8-36.7l-45.8-33.6-50.4,38.2,2.3,13h0Z"/><path class="st4" d="M33.4,160s125.3-76.4,200.9-107c75.6-30.6,30.6,29,30.6,29,0,0-78.7,38.2-110.8,57.3-32.1,19.1-81.7,50.4-87.9,51.2-6.1.8-32.9-30.6-32.9-30.6h.1Z"/><path class="st3" d="M266.6,35s-5.3-1.9-14.1,8.5c-8.9,10.3,15.1,8.2,15.1,8.2l-.9-16.7h-.1Z"/><path class="st1" d="M242.8,36.2s94.7,49.7,127.6,60.4c32.9,10.7,113.8,46.6,116.9,55.8s-27.5,30.6-27.5,30.6c0,0-23.7-21.4-54.2-34.4-30.6-13-83.3-34.4-112.3-48.1-29-13.8-89.4-47.4-89.4-47.4l39-16.8h0Z"/><path class="st2" d="M266.4,35.5s-2.3,92.4-4.6,97c-2.3,4.6,42.8-13,43.5-18.3.8-5.3,6.9-50.4,2.3-55s-36.7-26-41.3-23.7h.1Z"/></svg>
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
</div>