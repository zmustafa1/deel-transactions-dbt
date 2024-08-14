WITH
  currency_conversion AS (
  SELECT
    DISTINCT CAST(DATE_TRUNC(date_time, day) AS date) AS date,
    'USD' AS currency_base,
    currency AS exchange_currency,
    exchange_rate
  FROM
    {{ ref('stage_globepay__acceptance_reports') }} 
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['date', 'currency_base', 'exchange_currency']) }} as PK_DIM_CURRENCY_CONVERSION,
  *
FROM
  currency_conversion