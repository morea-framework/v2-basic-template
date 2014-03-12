---
layout: morea
title: Modules
---

<div class="container">
  <h1>Modules <small>Topics covered in this class.</small></h1>
  <div class="row">
     {% for module in site.morea_module_pages %}
        <div class="col-sm-3">
          <div class="thumbnail">
            <img src="{{ module.morea_icon_url }}" class="img-circle img-responsive">
            <div class="caption">
              <h3 style="text-align: center">{{ forloop.index }}. {{ module.title }}</h3>
              {{ module.content | markdownify }}
              {% if module.morea_module_coming_soon %}
                <p class="text-center"><a href="#" class="btn btn-default" role="button">Coming soon...</a></p>
              {% else %}
                <p class="text-center"><a href="{{ module.morea_id }}" class="btn btn-primary" role="button">Learn more...</a></p>
              {% endif %}
            </div>
          </div>
        </div>
       {% cycle '', '', '', '</div><div class="row">' %}
     {% endfor %}
  </div>
</div>


