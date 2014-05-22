---
title: "Assessment of Foo construction skill"
published: true
morea_id: assessment1
morea_type: assessment
morea_sort_order: 1
morea_outcomes_assessed:
  - outcome1
  - outcome2
---

Assessed ability to construct foo instances.

<link rel="stylesheet" href="http://cdn.oesmith.co.uk/morris-0.4.3.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="http://cdn.oesmith.co.uk/morris-0.4.3.min.js"></script>

<div class="well">
  <div id="assessment" style="height: 250px;"></div>
</div>

<script>
Morris.Bar({
  element: 'assessment',
  hideHover: false,
  data: [
        { y: 'Very satisfactory (%)', num: 25 },
        { y: 'Satisfactory (%)', num: 40 },
        { y: 'Unsatisfactory (%)', num: 30 },
        { y: 'Absent (%)', num: 5 },
        ],
  xkey: 'y',
  ykeys: ['num'],
  resize: true,
  labels: ['Students']
});
</script>