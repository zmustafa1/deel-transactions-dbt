WITH
  globepay_transactions AS (
  SELECT
    acceptance_report.external_ref,
    acceptance_report.status,
    acceptance_report.source,
    acceptance_report.ref,
    acceptance_report.date_time,
    acceptance_report.state,
    acceptance_report.cvv_provided,
    acceptance_report.amount,
    acceptance_report.country,
    acceptance_report.currency,
    chargeback_report.chargeback,
    CAST(DATE_TRUNC(acceptance_report.date_time, day) AS date) AS date
  FROM
    {{ ref('stage_globepay__acceptance_reports') }} AS acceptance_report
  LEFT JOIN
    {{ ref('stage_globepay__chargeback_reports') }} AS chargeback_report
  ON
    acceptance_report.external_ref = chargeback_report.external_ref
)

, pre_final AS (
  SELECT
    globepay_transactions.*,
    dim_currency_conversion.currency_base,
    dim_currency_conversion.exchange_currency,
    dim_currency_conversion.exchange_rate,
    globepay_transactions.amount / dim_currency_conversion.exchange_rate AS amount_USD
  FROM
    globepay_transactions
  LEFT JOIN
    {{ ref('dim_currency_conversion') }} as dim_currency_conversion
  ON
    globepay_transactions.currency = dim_currency_conversion.exchange_currency
    AND globepay_transactions.date = dim_currency_conversion.date
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['external_ref']) }} as PK_FACT_GLOBEPAY__TRANSACTIONS,
  external_ref,
  status,
  source,
  ref,
  date_time AS timestamp,
  date,
  state,
  cvv_provided,
  country,
  currency AS local_currency,
  amount AS amount_local_currency,
  currency_base AS currency_USD,
  amount_USD,
  chargeback
FROM
  pre_final