select * exclude (updated_at, branch_id) 
from {{ source('src', 'customers') }}
