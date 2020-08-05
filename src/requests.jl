import DocStringExtensions
import HTTP
import JSON3

function _add_trailing_slash(url::HTTP.URI)
    _url_string = _get_http_uri_string(url)
    if endswith(_url_string, "/")
        return url
    end
    result = HTTP.URI(string(_url_string, "/"))::HTTP.URI
    return result
end

function _generate_full_url(client::Client,
                            path::AbstractString)
    base_url = get_base_url(client)
    result = _generate_full_url(base_url, path)::HTTP.URI
    return result
end

function _generate_full_url(base_url::BaseURL,
                            path::AbstractString)
    base_url_uri = _get_http_uri(base_url)
    result = _generate_full_url(base_url_uri, path)::HTTP.URI
    return result
end

function _generate_full_url(base_url_uri::HTTP.URI,
                            path::AbstractString)
    base_url_uri_with_trailing_slash = _add_trailing_slash(base_url_uri)
    base_url_uri_string = _get_http_uri_string(base_url_uri_with_trailing_slash)
    full_url_uri_string = string(base_url_uri_string, path)
    full_url_uri = HTTP.URI(full_url_uri_string)::HTTP.URI
    return full_url_uri
end

function _make_http_get_request(client::Client,
                                content_type::V,
                                path::AbstractString) where V <: Val
    http_verb = "GET"
    full_url = _generate_full_url(client, path)
    new_headers = Dict{String, String}()
    content_headers!(new_headers, content_type)
    authentication_headers!(new_headers, client)
    response = HTTP.request(http_verb, full_url, new_headers)
    empty!(new_headers)
    response_body = response.body
    return response_body
end

function get_all_studies(client::Client)
    path = "studies"
    content_type = Val(:json)
    response_body = _make_http_get_request(client, content_type, path)
    response_body_string = String(response_body)::String
    response_body_json = JSON3.read(response_body_string)
    return response_body_json
end

function get_all_series(client::Client;
                        study::AbstractString)
    path = "studies/$(study)/series"
    content_type = Val(:json)
    response_body = _make_http_get_request(client, content_type, path)
    response_body_string = String(response_body)::String
    response_body_json = JSON3.read(response_body_string)
    return response_body_json
end

function get_all_instances(client::Client;
                           study::AbstractString,
                           series::AbstractString)
    path = "studies/$(study)/series/$(series)/instances"
    content_type = Val(:json)
    response_body = _make_http_get_request(client, content_type, path)
    response_body_string = String(response_body)::String
    response_body_json = JSON3.read(response_body_string)
    return response_body_json
end

function get_single_instance_metadata(client::Client;
                                      study::AbstractString,
                                      series::AbstractString,
                                      instance::AbstractString)
    path = "studies/$(study)/series/$(series)/instances/$(instance)/metadata"
    content_type = Val(:json)
    response_body = _make_http_get_request(client, content_type, path)
    response_body_string = String(response_body)::String
    response_body_json = JSON3.read(response_body_string)
    return response_body_json
end

function get_frame_images(::Val{:jpeg},
                          client::Client;
                          study::AbstractString,
                          series::AbstractString,
                          instance::AbstractString,
                          frames::AbstractVector{<:Integer})
    frame_list_string = join(string.(collect(frames)), ",")
    path = "studies/$(study)/series/$(series)/instances/$(instance)/frames/$(frame_list_string)"
    content_type = Val(:jpeg)
    response_body = _make_http_get_request(client, content_type, path)
    images = parse_multipart_image(Val(:jpeg), response_body)
    return images
end
