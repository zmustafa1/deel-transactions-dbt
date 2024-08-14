{% macro json__currency_extract(currency_code, column_name) %}

CASE
      WHEN currency = 'CAD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.CAD') AS float64)
      WHEN currency = 'MXN' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.MXN') AS float64)
      WHEN currency = 'EUR' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.EUR') AS float64)
      WHEN currency = 'USD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.USD') AS float64)
      WHEN currency = 'AUD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.AUD') AS float64)
      WHEN currency = 'GBP' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.GBP') AS float64)
  END AS {{ column_name }}

{% endmacro %}