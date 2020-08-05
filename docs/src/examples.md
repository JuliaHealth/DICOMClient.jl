```@meta
CurrentModule = DICOMClient
```

# Examples

```julia
using DICOMClient
using FileIO, ImageInTerminal, ImageMagick

base_url = DICOMClient.BaseURL("https://dicomcloud.azurewebsites.net/api")
auth = DICOMClient.AnonymousAuth()
client = DICOMClient.Client(base_url, auth)

study = "1.2.156.112536.1.2116.222245005117096205.13585270080.1"
series = "1.2.156.112536.1.2116.222245005117096205.13585270080.2"
instance = "1.2.156.112536.1.2116.222245005117096205.13585271850.5"
frames = 1:1

images = DICOMClient.get_frame_images(Val(:jpeg), client;
                                      study = study, series = series,
                                      instance = instance, frames = frames)


size(images)
images[1]
images[2]
FileIO.save("image_1.png",  images[1])
FileIO.save("image_2.jpeg", images[2])
```
