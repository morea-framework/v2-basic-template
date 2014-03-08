---
layout: bootstrap
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
              <p class="text-center"><a href="#" class="btn btn-primary" role="button">Learn more...</a></p>
            </div>
          </div>
        </div>
     {% endfor %}
  </div>
</div>


