function parse_multipart_image(::Val{:jpeg}, body::AbstractVector{UInt8})
    body_length = length(body)
    body_length_minus_one = body_length - 1
    image_starts = Vector{Int}(undef, 0)
    image_ends = Vector{Int}(undef, 0)
    for i = 1:body_length_minus_one
        body_i = body[i]
        body_i_plus_one = body[i+1]
        if body_i == 0xff && body_i_plus_one == 0xd8
            push!(image_starts, i)
        end
        if body_i == 0xff && body_i_plus_one == 0xd9
            push!(image_ends, i+1)
        end
    end
    num_image_starts = length(image_starts)
    num_image_ends = length(image_ends)
    if num_image_starts !== num_image_ends
        throw(ArgumentError("There are $(num_image_starts) starts but $(num_image_ends) ends"))
    end
    image_bytes = Vector{Vector{UInt8}}(undef, num_image_starts)
    for i = 1:num_image_starts
        image_start = image_starts[i]
        image_end = image_ends[i]
        bytes = body[image_start:image_end]
        image_bytes[i] = bytes
    end
    images = [bytes_to_image(Val(:jpeg), bytes) for bytes in image_bytes]
    return images
end
