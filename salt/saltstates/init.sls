include:
  {% for state, args in pillar.items() %}
    {% if 'sls' in args %}
  - {{ args['sls'] }}
    {% endif %}
  {% endfor %}
