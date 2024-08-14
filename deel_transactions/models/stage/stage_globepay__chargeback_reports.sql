select
    external_ref
    , status
    , source
    , chargeback
from {{ source('transactions', 'globepay_chargeback_report') }}