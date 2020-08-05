import Base64

function authentication_headers!(headers::AbstractDict, client::Client)::Nothing
    auth = get_auth(client)
    authentication_headers!(headers, auth)
    return nothing
end

function authentication_headers!(headers::AbstractDict, auth::AnonymousAuth)::Nothing
    return nothing
end
