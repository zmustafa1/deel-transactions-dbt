select
cast(date_trunc(date_time, day) as date) as date
, 'USD' as currency_base
, currency
, CASE WHEN currency = 'CAD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.CAD') as float64)
  WHEN currency = 'MXN' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.MXN') as float64)
  WHEN currency = 'EUR' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.EUR') as float64)
  WHEN currency = 'USD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.USD') as float64)
  WHEN currency = 'AUD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.AUD') as float64)
  WHEN currency = 'GBP' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.GBP') as float64)
  end as rate
  from {{ ref('stage_globepay__acceptance_reports') }}