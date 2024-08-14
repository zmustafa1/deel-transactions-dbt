select
cast(date_trunc(date_time, day) as date) as date
, 'USD' as currency_base
, currency as exchange_currency
, exchange_rate
  from {{ ref('stage_globepay__acceptance_reports') }}