---
layout: bootstrap
title: Readings
---

<div class="container">
  <h1>Readings and other resources <small>in module order</small></h1>
</div>

{% for module in site.morea_module_pages %}
<div class="{% cycle 'light-gray-background', 'white-background' %}">
  <div class="container">
    <h2><small>Module:</small> <a href="{{ module.url }}">{{ module.title }}</a></h2>
    <div class="row">
    {% for page_id in module.morea_readings %}
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
{% endfor %}
