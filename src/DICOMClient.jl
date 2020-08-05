module DICOMClient

import Base64
import DICOM
import DocStringExtensions
import FHIRClient
import FileIO
import HTTP
import ImageMagick
import Images
import JSON3
import Pkg
import StructTypes

include("types.jl")
include("version.jl")

include("authentication.jl")
include("authentication-headers.jl")
include("base-url.jl")
include("client.jl")
include("headers.jl")
include("image-utils.jl")
include("multipart-images.jl")
include("requests.jl")
include("uri.jl")
include("version-utils.jl")

end # end module DICOMClient
