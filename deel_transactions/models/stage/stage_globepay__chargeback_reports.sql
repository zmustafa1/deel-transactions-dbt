WITH
  globepay_chargeback AS (
  SELECT
    external_ref,
    status,
    SOURCE,
    chargeback
  FROM
    {{ source('transactions', 'globepay_chargeback_report') }}
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['external_ref']) }} as PK_STAGE_GLOBEPAY__CHARGEBACK_REPORTS,
  *
FROM
  globepay_chargeback