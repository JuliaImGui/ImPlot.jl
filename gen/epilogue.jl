function Annotation(x::Real, y::Real, pix_offset::ImVec2, fmt::String)
    col = GetLastItemColor()
    @ccall libcimgui.ImPlot_Annotation_Str(x::Cdouble, y::Cdouble, col::ImVec4, pix_offset::ImVec2,
                                           false::Bool, fmt::Cstring)::Cvoid
end

function AnnotationClamped(x::Real, y::Real, pix_offset::ImVec2, fmt::String)
    col = GetLastItemColor()
    @ccall libcimgui.ImPlot_Annotation_Str(x::Cdouble, y::Cdouble, col::ImVec4, pix_offset::ImVec2,
                                           true::Bool, fmt::Cstring)::Cvoid
end

function Annotation(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, fmt::String)
    @ccall libcimgui.ImPlot_Annotation_Str(x::Cdouble, y::Cdouble, col::ImVec4, pix_offset::ImVec2,
                                           false::Bool, fmt::Cstring)::Cvoid
end

function AnnotationClamped(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, fmt::String)
    @ccall libcimgui.ImPlot_Annotation_Str(x::Cdouble, y::Cdouble, col::ImVec4, pix_offset::ImVec2,
                                           true::Bool, fmt::Cstring)::Cvoid
end
