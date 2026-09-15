select * exclude (card_id, loan_id, cust_id, branch_id) 
from {{ source('src', 'transactions') }}
