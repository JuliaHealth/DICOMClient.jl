# Credential() = Credential(Base.SecretBuffer())

# function set_credential!(cred::Credential,
#                          value::AbstractString)::Nothing
#     Base.shred!(cred.secret_buffer)
#     seekstart(cred.secret_buffer)
#     write(cred.secret_buffer, value)
#     return nothing
# end

function Base.shred!(anonymous_auth::AnonymousAuth)::Nothing
    return nothing
end
