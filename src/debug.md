---
layout: default
title: Debug
topdiv: container
---

Debugging
=========

Site
----

{{ site | debug }}

Pages
-----

{% for page in site.pages %}
{{ page.url }}
--------------

{{ page | debug }}
{% endfor %}


