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
    {{ json__currency_extract('currency', 'exchange_rate') }}
  FROM
    {{ source('transactions', 'globepay_acceptance_report') }}
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['external_ref']) }} as PK_STAGE_GLOBEPAY__ACCEPTANCE_REPORTS,
  *
FROM
  globepay_acceptance
