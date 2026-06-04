# Axis tags with a custom label. The auto-generated bindings expose only the value-rounding
# TagX/TagY(v, col, round::Bool); these wrap the variadic `*_Str` entry points to set a literal label,
# the same way ImPlot.jl wraps Annotation_Str (the label is taken verbatim — pre-format it, e.g.
# `string(round(x; digits=1))`; a stray `%` would be interpreted as a printf directive).
function TagX(x::Real, col::ImVec4, label::AbstractString)
    ccall((:ImPlot_TagX_Str, libcimgui), Cvoid, (Cdouble, ImVec4, Cstring), x, col, label)
end
function TagY(y::Real, col::ImVec4, label::AbstractString)
    ccall((:ImPlot_TagY_Str, libcimgui), Cvoid, (Cdouble, ImVec4, Cstring), y, col, label)
end
