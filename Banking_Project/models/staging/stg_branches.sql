select * exclude (updated_at) 
from {{ source('src', 'branches') }}
