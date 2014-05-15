---
layout: default
title: Assessments
---

<div class="container">
  <h1>Assessments <small>in module order</small></h1>
</div>

{% for module in site.morea_module_pages %}
{% if module.morea_coming_soon != true %}
<div class="{% cycle 'section-background-1', 'section-background-2' %}">
  <div class="container">
    <h2><small>Module:</small> <a href="{{ site.baseurl }}{{ module.module_page.url }}">{{ module.title }}</a></h2>

    {% if module.morea_assessments.size == 0 %}
    <p>No assessments for this module.</p>
    {% endif %}

    {% for page_id in module.morea_assessments %}
      {% assign assessment = site.morea_page_table[page_id] %}
      <h3>{{ assessment.title }}</h3>
      <p>
        {% for label in assessment.morea_labels %}
          <span class="badge">{{ label }}</span>
        {% endfor %}
      </p>
      {{ assessment.content | markdownify }}
    {% endfor %}
  </div>
</div>
{% endif %}
{% endfor %}