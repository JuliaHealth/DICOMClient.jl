import HTTP

abstract type Authentication end

abstract type DICOMType end

struct BaseURL
    uri::HTTP.URI
end

struct Client{A <: Authentication}
    base_url::BaseURL
    auth::A
end

# struct Credential
#     secret_buffer::Base.SecretBuffer
# end

struct AnonymousAuth <: Authentication end
