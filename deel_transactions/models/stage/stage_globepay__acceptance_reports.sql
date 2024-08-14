WITH
  globepay_acceptance AS (
  SELECT
    external_ref,
    status,
    SOURCE,
    ref,
    date_time,
    state,
    cvv_provided,
    amount,
    country,
    currency,
    rates,
    CASE
      WHEN currency = 'CAD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.CAD') AS float64)
      WHEN currency = 'MXN' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.MXN') AS float64)
      WHEN currency = 'EUR' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.EUR') AS float64)
      WHEN currency = 'USD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.USD') AS float64)
      WHEN currency = 'AUD' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.AUD') AS float64)
      WHEN currency = 'GBP' THEN CAST(JSON_EXTRACT_SCALAR(rates, '$.GBP') AS float64)
  END
    AS exchange_rate
  FROM
    {{ source('transactions', 'globepay_acceptance_report') }}
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['external_ref']) }} as PK_STAGE_GLOBEPAY__ACCEPTANCE_REPORTS,
  *
FROM
  globepay_acceptance
