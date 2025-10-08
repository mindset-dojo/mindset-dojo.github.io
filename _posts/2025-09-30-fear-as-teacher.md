---
layout: post
title: "MetaShift Insight - Fear as Teacher, Shadow as Mirror, Presence as Response"
h1_mark: Presence
h1_hr: true
date: 2025-09-30
author: "Kyle Ingersoll"
excerpt: "How fear becomes a teacher and what its shadow reveals about presence and response."
image_extension: jpg
---

When people talk about Incident Response, they often think of flashing alerts, hackers in hoodies, or sudden technical heroics. In truth, it’s much more human than that. It’s about how people work when systems fail, how calmly we communicate under stress, and how quickly we transform disruption into recovery.

I learned this across two very different scenes — first as an IT Intern at Richmond Community Schools, and later as Infrastructure Cultivator for Mindset Dojo. The first time, I stood on the edge of a crisis expressing my leadership through support, not from the front. The second time, I was the one who detected the problem, spoke up, and helped guide resolution. Together, they shaped how I see Incident Response: as a practice of service, integrity, and growth.

---

## Scene 1 — Richmond Community Schools: After the Ransomware Storm

It was my first close encounter with the aftermath of a ransomware attack. The event itself had already struck, but its shadow still stretched across the school. The attack was [reported publicly](https://www.pal-item.com/story/news/local/2024/09/27/richmond-community-schools-targeted-in-ransomware-attack-student-information-compromised/75345295007/), so what I share here is simply my perspective as an intern supporting the response, not a disclosure of private details.

The network was down. Wi-Fi access was gone. Teachers carried personal mobile hotspots just to open lesson materials. Printers and gradebooks were offline. Some classes returned to paper for attendance and assignments. The learning environment itself — the daily rhythm of the school — had been halted.

I wasn’t leading the response from the front. The IT department carried the primary responsibility for containment and recovery. But I contributed where I could:

- Upgraded 25+ systems to close known vulnerabilities.  
- Deployed Endpoint Detection and Response (EDR), bringing endpoint protection to classrooms and staff devices.  
- Applied critical security patches to harden systems against reinfection.  

What I remember most wasn’t the software tools, but the **fear in the air**. Teachers feared they couldn’t do their jobs. Students feared they’d fall behind. The whole organization had been brought to a halt by a force they couldn’t see or control.

This was my first brush with what Jung might call the **shadow of technology** — the hidden vulnerabilities, the repressed flaws in our systems, suddenly forcing themselves into the light. You can’t wish away the shadow; you can only face it. That day I learned that security failures are never just about machines being compromised; they’re about people being stopped from doing their work.

---

## Scene 2 — Mindset Dojo: A Small but Impactful Vulnerability, Reasonable Decisive Action

Fast forward to Mindset Dojo. This time, I wasn’t in the background.

While building a live version of a branch for an unrelated pull request, I accidentally exploited a domain-control vulnerability in the Mindset Dojo site. My temporary build went live on the main site. When I deleted it, the site itself went down. That was how I discovered the issue: the vulnerability was real, and it could bring the entire site offline.

The vulnerability wasn’t internal to GitHub. It came from a configuration error — an Organizational Cultivator had unlinked their branch while the site repository and the organization were not yet verified. **Crucially, we lacked communication that we were making changes at the same time that could affect the main site.** That silence meant our work collided.

This created a **race condition**: in that brief window, my test branch was able to take over the live site. When I deleted it, the live site disappeared too.

Technically, a race condition means that the outcome depends on which event finishes first. Spiritually, it mirrors how fear and shadow slip in when timing, attention, and communication misalign. When fear “wins the race,” clarity is lost. When presence and dialogue take their place, order is restored.

On its own, the risk of an outside attacker noticing seemed low. But context mattered: later that day, the Organizational Cultivator was set to present the site publicly. A hijacked or broken site at that moment wouldn’t just be inconvenient — it would derail the presentation and relationship-building opportunity, as well as create unknown trust-damaging ripple effects.

So, I acted decisively and reasonably:

1. **Detection:** Recognized the issue while testing a branch build.  
2. **Escalation:** I called the Organizational Cultivator immediately on Signal audio, not delaying or downplaying.  
3. **Centering:** Before we began deciding next steps, we did *One Breath* together — a brief practice to calm down and focus.  
   - [One Breath](https://vimeo.com/944618879/47e96945a4) is a simple Mindset Dojo practice out of Zen Toolkit: pause, take one slow breath together, and let the body and mind settle. It only takes a minute or two, but it helps shift from panic to presence — essential in any incident response.  
   - We brought the site back online, and determined that there was no reasonable risk of exploitation in the immediate term.
4. **Reflection in action (first pass):** Once grounded, we walked through two questions — *What went well?* and *What didn’t go well?* — followed by a first round of *What would we do differently next time?* My answers were clouded by fear, which distorted my perspective. I looked for broad, general fixes, while missing the specific one we needed, at first.  
5. **Execution:** In a follow-up virtual meeting, we addressed and mapped out the medium- and long-term risks. From my vantage point, the problem looked larger and vaguer. The Organizational Cultivator, with steadier experience, saw through the fear, cut to the heart of the issue, and implemented the exact technical fix. They, from the GitHub admin panel, verified domain ownership at both the organization and repository level through DNS TXT validation on the same day as discovery.  
6. **Closure (second pass):** After the vulnerability was fixed, we revisited *What would we do differently next time?* This time, with fear replaced by clarity, the conversation was sharper, more grounded, and more useful.  

Here I learned the difference between meeting fear with fear and meeting fear with presence. Freud might say fear is the eruption of the unconscious into awareness, while Jung would argue it’s the shadow demanding recognition. But in either case, panic amplifies it, while presence transforms it.

**Miscommunication** played as big a role as configuration — and both reminded me that silence in the wrong moment can be as damaging as technical flaws. The Organizational Cultivator embodied presence, and in doing so, showed me how to integrate fear into learning rather than let it rule me.

---

## The Arc That Ties Them Together

Looking back, these two moments tell one story of growth:

- At Richmond Community Schools, I saw how fear and disruption can bring an organization to a halt, and how facing the shadow of vulnerability reveals what truly matters — continuity for people.  
- At Mindset Dojo, I felt fear firsthand, and learned that presence and communication are the only ways to see clearly through it.  

Together, these experiences taught me that Incident Response is not just a technical checklist. It is:

1. **Service** — keeping people working, teaching, and leading without interruption.  
2. **Communication** — making sure silence doesn’t leave space for fear, confusion, or error. Clarity itself is a safeguard.  
3. **Shadow Work** — acknowledging the flaws and fears that surface under stress, and transforming them into insight.  
4. **Growth** — moving from a supportive role to a decisive one, always learning through each moment.  

---

## Reflections for Anyone, Not Just IT Professionals

- **Fear is universal.** Whether it’s a ransomware attack or a personal setback, fear narrows our vision. Meeting it with presence opens it back up.  
- **Shadow work is practical.** The parts of ourselves or our systems we’d rather not see will eventually emerge. Facing them is the only path forward.  
- **Communication is non-negotiable.** Silence, assumptions, or half-shared details often do more harm than the issue itself. Clear, timely communication keeps fear from filling the gaps.  
- **Race conditions happen in life too.** When fear, timing, and miscommunication collide, even small errors can create cascading effects. The lesson isn’t to eliminate risk completely, but to meet those fragile moments with awareness and dialogue.  

This is why Incident Response feels, to me, like a dojo practice. Every event is both *kata* (rehearsed form) and *randori* (free practice). Each one demands readiness, composure, and a willingness to learn while acting.

---

## A Single Koan

When the system fails and the people falter,  
is security in the patch,  
or in the hand that meets fear with presence?  

---

👉 [mindset.dojo.center](https://mindset.dojo.center)  
⛩️🖥️  
*Kyle Ingersoll — Red Level and DevOps Cultivator*

---

## Bow of Respect

I bow in respect and gratitude to the [**Institute for Zen Leadership**](https://zenleader.global/), guardians and stewards of the **Zen Toolkit** and the **FEBI™ framework**, whose practices and teachings make this kind of work possible.

Their lineage of presence, shadow-awareness, and embodied leadership have quietly shaped the language I bring into the intersection of technology and inner work.

In offering this article, I stand on the shoulders of those who taught me to meet fear with presence, speak with clarity, and face shadow with curiosity — and dedicate what follows to carrying that spirit forward.
