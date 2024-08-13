select 
    external_ref
    , status
    , source
    , ref
    , date_time
    , state
    , cvv_provided
    , amount
    , country
    , currency
    , rates
    , CASE WHEN currency = 'CAD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.CAD') as float64)
      WHEN currency = 'MXN' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.MXN') as float64)
      WHEN currency = 'EUR' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.EUR') as float64)
      WHEN currency = 'USD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.USD') as float64)
      WHEN currency = 'AUD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.AUD') as float64)
      WHEN currency = 'GBP' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.GBP') as float64)
      end as exchange_rate
from {{ source('transactions', 'globepay_acceptance_report') }}
