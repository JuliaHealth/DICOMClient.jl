"""
Construct a `BaseURL` object given the base URL.
"""
BaseURL(base_url::AbstractString) = BaseURL(HTTP.URI(base_url))
