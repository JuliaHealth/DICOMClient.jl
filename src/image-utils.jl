import FileIO
import ImageMagick
import Images

function bytes_to_image(::Val{:jpeg}, bytes::AbstractVector{UInt8})
    image = _bytes_to_image("jpeg", bytes)
    return image
end

function _bytes_to_image(file_extension::AbstractString, bytes::AbstractVector{UInt8})
    original_directory = pwd()
    temp_directory = mktempdir()
    atexit(() -> rm(temp_directory; force = true, recursive = true))
    temp_image_file = joinpath(temp_directory, "image.$(file_extension)")
    rm(temp_image_file; force = true, recursive = true)
    open(temp_image_file, "w") do io
        write(io, bytes)
    end
    image = FileIO.load(temp_image_file)
    cd(original_directory)
    rm(temp_image_file; force = true, recursive = true)
    rm(temp_directory; force = true, recursive = true)
    return image
end
