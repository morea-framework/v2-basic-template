---
layout: bootstrap
title: Learning Outcomes
---

<div class="container">
  <h1>Learning Outcomes</h1>
</div>

{% for outcome in site.morea_outcome_pages %}

<div class="{% cycle 'light-gray-background', 'white-background' %}">
  <div class="container">
    <h2><small>Outcome:</small> {{ outcome.title }}</h2>
    {{ outcome.content | markdownify }}
  </div>
</div>

{% endfor %}


