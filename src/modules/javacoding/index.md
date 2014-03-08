---
layout: bootstrap
title: "Java Coding"
published: true
morea_id: javacoding
morea_outcomes:
 - 314Java
 - 314CodingStandards
morea_readings:
 - screencasts
 - javaspec
morea_experiences:
 - pwod-countlines
morea_assessments:
 - inclasswod-javacoding-results
morea_icon: javacoding.png
morea_type: module
morea_sort_order: 0
---

<div class="container">
  <h1><small>Module: </small> {{ page.title }} </h1>
</div>

<div class="light-gray-background">
  <div class="container">
    <h2>Learning outcomes</h2>

    {% for page_id in page.morea_outcomes %}
      {% assign outcome = site.morea_page_table[page_id] %}
      <h3>Outcome {{ forloop.index }}: {{ outcome.title }}</h3>
      {{ outcome.content | markdownify }}
    {% endfor %}

  </div>
</div>

<div class="white-background">
  <div class="container">
  <h2>Readings and other resources</h2>
    <div class="row">

      {% for page_id in page.morea_readings %}
        {% assign reading = site.morea_page_table[page_id] %}
        <div class="col-sm-3">
          <div class="thumbnail">
            <h4><a href="{{ reading.morea_url }}">{{ reading.title }}</a></h4>
            {{ reading.morea_summary | markdownify }}
          </div>
        </div>
      {% endfor %}

    </div>
  </div>
</div>

<div class="light-gray-background">
  <div class="container">
  <h2>Experiential Learning</h2>
    <div class="row">

      {% for page_id in page.morea_experiences %}
        {% assign experience = site.morea_page_table[page_id] %}
        <div class="col-sm-3">
          <div class="thumbnail">
            <h4><a href="{{ experience.morea_url }}">{{ experience.title }}</a></h4>
            {{ experience.morea_summary | markdownify }}
          </div>
        </div>
      {% endfor %}

    </div>
  </div>
</div>

<div class="white-background">
  <div class="container">
    <h2>Assessment</h2>

    {% for page_id in page.morea_assessments %}
      {% assign assessment = site.morea_page_table[page_id] %}
      <h3>Assessment {{ forloop.index }}: {{ assessment.title }}</h3>
      {{ assessment.content | markdownify }}
    {% endfor %}

  </div>
</div>



