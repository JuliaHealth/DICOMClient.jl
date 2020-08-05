get_auth(client::Client) = client.auth
get_base_url(client::Client) = client.base_url

function Base.shred!(client::Client)::Nothing
    Base.shred!(client.auth)
    return nothing
end
