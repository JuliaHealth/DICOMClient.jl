function content_headers!(headers::AbstractDict, ::Val{:json})
    headers["Accept"] = "application/json"
    headers["Content-Type"] = "application/json"
    return headers
end

function content_headers!(headers::AbstractDict, ::Val{:jpeg})
    headers["Accept"] = "multipart/related; type = \"image/jpeg\""
    headers["Content-Type"] = "application/json"
    return headers
end
