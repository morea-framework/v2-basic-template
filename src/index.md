---
layout: bootstrap
title: Home
topdiv: container
---

Morea Basic Template
====================

This is the home page.

Pages
-----

<ul>
{% for page in site.pages %}
  <li>
      {{ page.url }}, {{ page.title }}, {{ page.id }}
    </a>
  </li>
{% endfor %}
</ul>
