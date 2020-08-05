function _get_expected_hashes(julia_version_to_expected_hashes::AbstractDict, julia_version_number::VersionNumber)
    up_to_patch = VersionNumber(julia_version_number.major, julia_version_number.minor, julia_version_number.patch)
    up_to_minor = VersionNumber(julia_version_number.major, julia_version_number.minor)
    up_to_major = VersionNumber(julia_version_number.major)
    if haskey(julia_version_to_expected_hashes, julia_version_number)
        return julia_version_to_expected_hashes[julia_version_number]
    elseif haskey(julia_version_to_expected_hashes, up_to_patch)
        return julia_version_to_expected_hashes[up_to_patch]
    elseif haskey(julia_version_to_expected_hashes, up_to_minor)
        return julia_version_to_expected_hashes[up_to_minor]
    else
        return julia_version_to_expected_hashes[up_to_major]
    end
end
